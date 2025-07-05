import 'package:flutter/material.dart';
import 'package:single_perceptron/features/graph_visualizer/screens/visualizer_screen.dart';
import 'package:single_perceptron/features/pattern_recognition/screens/pattern_recognition_screen.dart';
import 'package:single_perceptron/features/selection/widgets/nav_card.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Single Perceptron')),
      body: ListView(
        children: [
          NavCard(
            title: '결정 경계 시각화',
            subtitle: 'AND, OR, NOT 등 논리 연산 학습을 시각화하여 퍼셉트론의 분류 능력을 확인하고, XOR 문제로 인한 단일 퍼셉트론의 한계를 탐구합니다.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VisualizerScreen()),
              );
            },
          ),
          NavCard(
            title: '패턴 인식 시뮬레이션',
            subtitle: '16개의 입력 패턴을 사용하여 퍼셉트론을 훈련하고 패턴 인식 과정을 시뮬레이션합니다.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PatternRecognitionScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
