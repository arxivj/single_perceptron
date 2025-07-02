import 'package:flutter/material.dart';
import 'package:single_perceptron/features/shared/widgets/neu_container.dart';
import 'package:single_perceptron/models/led_switch.dart';

class LedControlWidget extends StatelessWidget {
  final LedSwitch led;
  final GestureTapCallback onChanged;
  final String? label;

  const LedControlWidget({required this.led, required this.onChanged, super.key, this.label});

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
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (label != null)
              Positioned(
                top: -24.0,
                left: 24.0,
                child: Text(
                  label!,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey[500]),
                ),
              ),
            SizedBox(
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
          ],
        ),
      ),
    );
  }
}
