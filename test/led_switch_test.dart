import 'package:flutter_test/flutter_test.dart';
import 'package:single_perceptron/models/led_switch.dart';

void main() {
  group('LedSwitch', () {
    late LedSwitch ledSwitch;

    setUp(() {
      // 공통 Given
      ledSwitch = LedSwitch();
    });

    test('toggle()은 isOn 상태를 반전시켜야 한다', () {
      // When
      ledSwitch.toggle();
      // Then
      expect(ledSwitch.isOn, true);
    });
    test('isOn이 true일 때 value는 1을 반환해야 한다', () {
      // When
      ledSwitch.toggle();
      final result = ledSwitch.value;
      // Then
      expect(result, 1);
    });
    test('isOn이 false일 때 value는 -1을 반환해야 한다', () {
      // When
      final result = ledSwitch.value;
      // Then
      expect(result, -1);
    });
    test('reset()은 isOn 상태를 초기값으로 되돌려야 한다', () {
      // When
      ledSwitch.toggle();
      ledSwitch.reset();
      // Then
      expect(ledSwitch.isOn, false);
    });
  });
}
