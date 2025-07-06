import 'package:flutter_test/flutter_test.dart';
import 'package:single_perceptron/models/dial.dart';

void main() {
  group('Dial', () {
    late Dial dial;

    setUp(() {
      // 공통 Given
      dial = Dial();
    });

    test('increment()는 value를 10 증가시켜야 한다', () {
      // When
      dial.increment();

      // Then
      expect(dial.value, 10);
    });
    test('decrement()는 value를 10 감소시켜야 한다', () {
      // When
      dial.decrement();
      // Then
      expect(dial.value, -10);
    });
    test('상한선을 넘는 값을 할당하면 50으로 고정되어야 한다', () {
      // Given
      dial.value = 60;
      // When
      final result = dial.value;
      // Then
      expect(result, 50);
    });
    test('하한선 미만의 값을 할당하면 -50으로 고정되어야 한다', () {
      // Given
      dial.value = -100;
      // When
      final result = dial.value;
      // Then
      expect(result, -50);
    });
    test('reset()은 value를 초기값으로 되돌려야 한다', () {
      // Given
      dial.value = 14;
      // When
      dial.reset();
      // Then
      expect(dial.value, 0);
    });
  });
}
