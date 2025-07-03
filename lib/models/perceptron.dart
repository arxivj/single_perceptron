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
      throw RangeError('Index out of range: $index');
    }
    return PerceptronItem(_inputs[index], _weights[index]);
  }

  int get netInput => _calculateNetInput();

  int predict() => _activation(netInput);

  void reset() => _initialize();

  void _initialize() {
    _inputs = List.generate(inputSize, (_) => LedSwitch());
    _weights = List.generate(inputSize, (_) => Dial());
    bias = Dial();
  }

  int _calculateNetInput() {
    int sum = 0;
    for (int i = 0; i < inputSize; i++) {
      sum += _inputs[i].value * _weights[i].value;
    }
    sum += bias.value;
    return sum;
  }

  int _activation(int netInput) => netInput >= 0 ? 1 : 0;
}
