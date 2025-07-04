import 'package:flutter/material.dart';
import 'package:single_perceptron/models/learned_pattern.dart';

class LearnedPatternCard extends StatelessWidget {
  final LearnedPattern pattern;
  final int netInput;
  final VoidCallback onPressed;

  const LearnedPatternCard({required this.pattern, required this.netInput, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
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
          const SizedBox(height: 4.0),
          Column(
            children: [
              Text(
                'Net: $netInput',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                pattern.target == LearningTarget.positive
                    ? 'Target>0'
                    : 'Target<0',
                style: TextStyle(
                  fontSize: 12.0,
                  color: pattern.target == LearningTarget.positive
                      ? Colors.green
                      : Colors.red,
                ),
              ),
              Text(
                netInput >= 0 ? 'Actual>0' : 'Actual<0',
                style: TextStyle(
                  fontSize: 12.0,
                  color:
                  netInput >= 0 ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
