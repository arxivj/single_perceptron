import 'package:flutter_test/flutter_test.dart';
import 'package:single_perceptron/models/perceptron.dart';

void main() {
  group('Perceptron', () {
    late Perceptron perceptron;

    setUp((){
      // 공통 Given
      perceptron = Perceptron(inputSize: 3);

      perceptron.weights[0].value = 10;
      perceptron.weights[1].value = 15;
      perceptron.weights[2].value = 13;
      perceptron.bias.value = -14;
    });

    test('주어진 패턴으로 정확한 netInput 값을 계산해야 한다', () {
      // Given
      final pattern = [true, false, true];

      // When
      final result = perceptron.calculateNetInputForPattern(pattern);

      // Then
      expect(result, -6);
    });

    test('내부 입력 상태가 양의 netInput을 만들 때 1을 반환해야 한다', () {
      // Given
      perceptron.inputs[0].toggle();
      perceptron.inputs[2].toggle();
      // When
      final result = perceptron.predict();
      // Then
      expect(result, 0);
    });

    test('모든 입력, 가중치, 편향을 초기값으로 리셋해야 한다', () {
      // Given
      perceptron.inputs[0].toggle();

      // When
      perceptron.reset();

      // Then
      expect(perceptron.inputs.every((input) => !input.isOn), isTrue);
      expect(perceptron.weights.every((weight) => weight.value == 0), isTrue);
      expect(perceptron.bias.value, 0);
    });

  });
}
