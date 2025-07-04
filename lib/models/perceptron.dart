import 'package:single_perceptron/models/dial.dart';
import 'package:single_perceptron/models/led_switch.dart';

class PerceptronItem {
  final LedSwitch led;
  final Dial dial;

  const PerceptronItem(this.led, this.dial);
}

class Perceptron {
  final int inputSize;
  late List<LedSwitch> _inputs;
  late List<Dial> _weights;
  late final Dial bias;

  Perceptron({required this.inputSize}) {
    _initialize();
  }

  PerceptronItem operator [](int index) {
    if (index < 0 || index >= inputSize) {
      throw RangeError('인덱스 범위를 벗어났습니다: $index');
    }
    return PerceptronItem(_inputs[index], _weights[index]);
  }

  List<Dial> get weights => _weights;

  int get netInput => _calculateNetInput(_inputs.map((e) => e.isOn).toList());

  int predict() => _activation(netInput);

  void reset() => _initialize();

  int calculateNetInputForPattern(List<bool> ledStates) {
    return _calculateNetInput(ledStates);
  }

  void _initialize() {
    _inputs = List.generate(inputSize, (_) => LedSwitch());
    _weights = List.generate(inputSize, (_) => Dial());
    bias = Dial();
  }

  int _calculateNetInput(List<bool> ledStates) {
    int sum = 0;
    for (int i = 0; i < inputSize; i++) {
      final inputValue = ledStates[i] ? 1 : -1;
      sum += inputValue * _weights[i].value;
    }
    sum += bias.value;
    return sum;
  }

  int _activation(int netInput) => netInput >= 0 ? 1 : 0;
}
