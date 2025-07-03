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
            title: '그래프 시각화',
            subtitle: '2개의 입력으로 퍼셉트론의 결정 경계 확인',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VisualizerScreen()),
              );
            },
          ),
          NavCard(
            title: '패턴 인식',
            subtitle: '16개의 입력으로 패턴을 학습하는 과정을 시뮬레이션',
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
