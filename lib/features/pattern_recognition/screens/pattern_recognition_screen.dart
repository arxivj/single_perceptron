import 'package:flutter/material.dart';
import 'package:single_perceptron/features/pattern_recognition/widgets/learning_target_selector.dart';
import 'package:single_perceptron/features/shared/widgets/led_control_widget.dart';
import 'package:single_perceptron/features/shared/widgets/neu_container.dart';
import 'package:single_perceptron/models/perceptron.dart';

enum LearningTarget { positive, negative }

class _LearnedPattern {
  final List<bool> ledStates;

  _LearnedPattern({required this.ledStates});
}

class PatternRecognitionScreen extends StatefulWidget {
  const PatternRecognitionScreen({super.key});

  @override
  State<PatternRecognitionScreen> createState() => _PatternRecognitionScreenState();
}

class _PatternRecognitionScreenState extends State<PatternRecognitionScreen> {
  final perceptron = Perceptron(inputSize: 16);
  LearningTarget _learningTarget = LearningTarget.positive;
  final List<_LearnedPattern> _learnedPatterns = [];

  void _updateState() {
    setState(() {});
  }

  void _resetAllLeds() {
    for (int i = 0; i < perceptron.inputSize; i++) {
      if (perceptron[i].led.isOn) {
        perceptron[i].led.toggle();
      }
    }
    _updateState();
  }

  void _saveCurrentPattern(int netInput) {
    final List<bool> currentLedStates = List.generate(
      perceptron.inputSize,
      (index) => perceptron[index].led.isOn,
    );

    bool patternExists = _learnedPatterns.any((pattern) {
      for (int i = 0; i < pattern.ledStates.length; i++) {
        if (pattern.ledStates[i] != currentLedStates[i]) {
          return false;
        }
      }
      return true;
    });

    if (!patternExists) {
      _learnedPatterns.add(_LearnedPattern(ledStates: currentLedStates));
    }
  }

  void _loadPattern(_LearnedPattern pattern) {
    for (int i = 0; i < perceptron.inputSize; i++) {
      if (perceptron[i].led.isOn != pattern.ledStates[i]) {
        perceptron[i].led.toggle();
      }
    }
    _updateState();
  }

  void _learn() {
    try {
      final netInput = perceptron.netInput;
      _saveCurrentPattern(netInput);
      _learningAlgorithm();
    } finally {
      _resetAllLeds();
      // _updateState();
    }
  }

  void _learningAlgorithm() {
    switch (_learningTarget) {
      case LearningTarget.positive:
        for (int i = 0; i < perceptron.inputSize; i++) {
          if (perceptron[i].led.isOn) {
            perceptron[i].dial.increment();
          } else {
            perceptron[i].dial.decrement();
          }
        }
        perceptron.bias.increment();
        break;
      case LearningTarget.negative:
        for (int i = 0; i < perceptron.inputSize; i++) {
          if (perceptron[i].led.isOn) {
            perceptron[i].dial.decrement();
          } else {
            perceptron[i].dial.increment();
          }
        }
        perceptron.bias.decrement();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Net Input: ${perceptron.netInput}', style: const TextStyle(fontSize: 18.0)),
            Container(
              margin: const EdgeInsets.only(left: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: perceptron.netInput >= 0
                    ? Colors.green.withValues(alpha: 0.2)
                    : Colors.red.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                perceptron.netInput >= 0 ? 'Positive' : 'Negative',
                style: TextStyle(
                  color: perceptron.netInput >= 0 ? Colors.green : Colors.red,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: 16,
              itemBuilder: (context, index) {
                return LedControlWidget(led: perceptron[index].led, onChanged: _updateState);
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: LearningTargetSelector<LearningTarget>(
                      initialSelection: _learningTarget,
                      onSelectionChanged: (newSelection) {
                        setState(() {
                          _learningTarget = newSelection;
                        });
                      },
                      segments: const [
                        ButtonSegment(value: LearningTarget.positive, label: Text('Positive Target')),
                        ButtonSegment(value: LearningTarget.negative, label: Text('Negative Target')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  NeuContainer(
                    child: IconButton(
                      onPressed: _resetAllLeds,
                      icon: const Icon(Icons.lightbulb_outline_rounded, size: 24.0),
                      padding: const EdgeInsets.all(16.0),
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: NeuContainer(
                      child: ElevatedButton(
                        onPressed: _learn,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        ),
                        child: Text('Learn', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.grey.shade700)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: _learnedPatterns.isEmpty
                        ? Center(child: Text('No patterns learned yet.', style: TextStyle(color: Colors.grey.shade600)))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _learnedPatterns.length,
                            itemBuilder: (context, index) {
                              final pattern = _learnedPatterns[index];

                              return TextButton(
                                onPressed: () => _loadPattern(pattern),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 8.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: GridView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4,
                                    ),
                                    itemCount: pattern.ledStates.length,
                                    itemBuilder: (context, ledIndex) {
                                      return Icon(
                                        pattern.ledStates[ledIndex]
                                            ? Icons.circle
                                            : Icons.circle_outlined,
                                        color: pattern.ledStates[ledIndex]
                                            ? Colors.red.shade200
                                            : Colors.grey,
                                        size: 14.0,
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
