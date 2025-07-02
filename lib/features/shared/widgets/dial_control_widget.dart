import 'package:flutter/material.dart';
import 'package:single_perceptron/models/dial.dart';

class DialControlWidget extends StatelessWidget {
  final Dial dial;
  final GestureTapCallback onChanged;
  final String? label;

  const DialControlWidget({required this.dial, required this.onChanged, this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label != null)
          Text(
            label!,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
        Slider(
          value: dial.value.toDouble(),
          min: -50,
          max: 50,
          divisions: 100,
          label: dial.value.toString(),
          onChanged: (double newValue) {
            dial.value = newValue.round();
            onChanged();
          },
        ),
      ],
    );
  }
}
