import 'package:flutter/material.dart';

class FormulaDisplay extends StatelessWidget {
  final List<int> weights;
  final List<int> inputs;
  final int bias;
  final int net;
  final String symbolicFormula;

  const FormulaDisplay({
    required this.weights,
    required this.inputs,
    required this.bias,
    required this.net,
    required this.symbolicFormula,
    super.key,
  }) : assert(weights.length == inputs.length, 'Weights and inputs must have the same length.');

  @override
  Widget build(BuildContext context) {
    final TextStyle weightStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade700,
    );
    final inputStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.red.shade300,
    );
    final biasStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade700,
    );
    final netStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: net > 0 ? Colors.red : Colors.blue,
    );
    final List<TextSpan> formulaSpans = [];

    for (int i = 0; i < weights.length; i++) {
      formulaSpans.add(const TextSpan(text: '('));
      formulaSpans.add(TextSpan(text: '${weights[i]}', style: weightStyle));
      formulaSpans.add(const TextSpan(text: ' × '));
      formulaSpans.add(TextSpan(text: '${inputs[i]}', style: inputs[i] > 0 ? inputStyle : null));
      formulaSpans.add(const TextSpan(text: ')'));
      if (i < weights.length - 1) {
        formulaSpans.add(const TextSpan(text: ' + '));
      }
    }



    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 18.0, color: Colors.grey.shade700, height: 1.5),
        text: '$symbolicFormula\n',
        children: [
          const TextSpan(text: '= '),
          ...formulaSpans,
          TextSpan(text: bias >= 0 ? ' + ' : ' - ', style: biasStyle),
          TextSpan(text: '${bias.abs()}', style: biasStyle),
          const TextSpan(text: ' = '),
          TextSpan(text: '$net', style: netStyle),
        ],
      ),
    );
  }
}
