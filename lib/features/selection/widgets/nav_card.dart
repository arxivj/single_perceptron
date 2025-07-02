import 'package:flutter/material.dart';
import 'package:single_perceptron/features/shared/widgets/neu_container.dart';

class NavCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final GestureTapCallback onTap;

  const NavCard({required this.title, required this.onTap, super.key, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NeuContainer(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18.0),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8.0),
                Text(
                  subtitle!,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}