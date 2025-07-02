import 'dart:math';

import 'package:flutter/material.dart';
import 'package:single_perceptron/features/graph_visualizer/widgets/formula_display.dart';
import 'package:single_perceptron/features/graph_visualizer/widgets/perceptron_graph.dart';
import 'package:single_perceptron/features/shared/widgets/dial_control_widget.dart';
import 'package:single_perceptron/features/shared/widgets/led_control_widget.dart';
import 'package:single_perceptron/features/shared/widgets/neu_container.dart';
import 'package:single_perceptron/models/perceptron.dart';

class VisualizerScreen extends StatefulWidget {
  const VisualizerScreen({super.key});

  @override
  State<VisualizerScreen> createState() => _VisualizerScreenState();
}

class _VisualizerScreenState extends State<VisualizerScreen> {
  final Perceptron perceptron = Perceptron(inputSize: 2);

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<int> weights = List.generate(perceptron.inputSize, (i) => perceptron[i].dial.value);
    final List<int> inputs = List.generate(perceptron.inputSize, (i) => perceptron[i].led.value);

    return Scaffold(
      appBar: AppBar(title: const Text('그래프 시각화')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            NeuContainer(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    NeuContainer(
                      child: SizedBox(
                        width: 240.0,
                        height: 240.0,
                        child: CustomPaint(
                          painter: PerceptronGraph(
                            w1: perceptron[0].dial.value,
                            w2: perceptron[1].dial.value,
                            bias: perceptron.bias.value,
                            selectedPoint: Point(perceptron[0].led.value, perceptron[1].led.value),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    FormulaDisplay(
                      weights: weights,
                      inputs: inputs,
                      bias: perceptron.bias.value,
                      net: perceptron.netInput,
                      symbolicFormula: 'net = (w₁ × x₁) + (w₂ × x₂) + bias',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Expanded(
                  child: NeuContainer(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: LedControlWidget(led: perceptron[0].led, onChanged: _updateState, label: 'x₁'),
                        ),
                        DialControlWidget(
                          dial: perceptron[0].dial,
                          onChanged: _updateState,
                          label: 'w₁',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: NeuContainer(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: LedControlWidget(led: perceptron[1].led, onChanged: _updateState, label: 'x₂'),
                        ),
                        DialControlWidget(
                          dial: perceptron[1].dial,
                          onChanged: _updateState,
                          label: 'w₂',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            NeuContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: DialControlWidget(
                dial: perceptron.bias,
                onChanged: _updateState,
                label: 'bias',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
