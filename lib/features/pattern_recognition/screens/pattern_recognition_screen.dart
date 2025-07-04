import 'package:flutter/material.dart';
import 'package:single_perceptron/features/pattern_recognition/widgets/learned_pattern_card.dart';
import 'package:single_perceptron/features/pattern_recognition/widgets/learning_target_selector.dart';
import 'package:single_perceptron/features/shared/widgets/led_control_widget.dart';
import 'package:single_perceptron/features/shared/widgets/neu_container.dart';
import 'package:single_perceptron/models/learned_pattern.dart';
import 'package:single_perceptron/models/perceptron.dart';

class PatternRecognitionScreen extends StatefulWidget {
  const PatternRecognitionScreen({super.key});

  @override
  State<PatternRecognitionScreen> createState() => _PatternRecognitionScreenState();
}

class _PatternRecognitionScreenState extends State<PatternRecognitionScreen> {
  static const int _gridDimension = 4;
  static const int _perceptronInputSize = _gridDimension * _gridDimension;

  final perceptron = Perceptron(inputSize: _perceptronInputSize);
  LearningTarget _learningTarget = LearningTarget.positive;
  final List<LearnedPattern> _learnedPatterns = [];

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

  void _saveCurrentPattern() {
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
      _learnedPatterns.add(LearnedPattern(ledStates: currentLedStates, target: _learningTarget));
    }
  }

  void _loadPattern(LearnedPattern pattern) {
    for (int i = 0; i < perceptron.inputSize; i++) {
      if (perceptron[i].led.isOn != pattern.ledStates[i]) {
        perceptron[i].led.toggle();
      }
    }
    setState(() {
      _learningTarget = pattern.target;
    });
  }

  void _learn() {
    _saveCurrentPattern();
    _learningAlgorithm();
    _resetAllLeds();
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
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _gridDimension),
              itemCount: _perceptronInputSize,
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
                      selection: _learningTarget,
                      onSelectionChanged: (newSelection) {
                        setState(() {
                          _learningTarget = newSelection;
                        });
                      },
                      segments: const [
                        ButtonSegment(
                          value: LearningTarget.positive,
                          label: Text('Positive Target'),
                        ),
                        ButtonSegment(
                          value: LearningTarget.negative,
                          label: Text('Negative Target'),
                        ),
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
                      icon: const Icon(Icons.refresh, size: 24.0),
                      tooltip: 'Reset all LEDs',
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
                        child: Text(
                          'Learn',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 140.0,
                    child: _learnedPatterns.isEmpty
                        ? Center(
                            child: Text(
                              'No patterns learned yet.',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _learnedPatterns.length,
                            itemBuilder: (context, index) {
                              final pattern = _learnedPatterns[index];
                              final netInput = perceptron.calculateNetInputForPattern(pattern.ledStates);

                              return LearnedPatternCard(
                                pattern: pattern,
                                netInput: netInput,
                                onPressed: () => _loadPattern(pattern),
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

