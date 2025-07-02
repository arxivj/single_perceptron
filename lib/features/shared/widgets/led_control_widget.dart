import 'package:flutter/material.dart';
import 'package:single_perceptron/features/shared/widgets/neu_container.dart';
import 'package:single_perceptron/models/led_switch.dart';

class LedControlWidget extends StatelessWidget {
  final LedSwitch led;
  final GestureTapCallback onChanged;

  const LedControlWidget({required this.led, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    final isOn = led.state == LedState.on;
    final baseColor = Theme.of(context).scaffoldBackgroundColor;
    return GestureDetector(
      onTap: () {
        led.toggle();
        onChanged();
      },
      child: NeuContainer(
        color: isOn ? Colors.red[300] : baseColor,
        shape: BoxShape.circle,
        child: SizedBox(
          width: 60,
          height: 60,
          child: Center(
            child: Text(
              isOn ? '+' : '-',
              style: TextStyle(
                color: isOn ? Colors.white : Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
