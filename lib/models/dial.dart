class Dial {
  int _value = 0;

  Dial();

  int get value => _value;

  set value(int newValue) => _value = newValue.clamp(-50, 50);

  // void increment() {
  //   _value = (_value + 10).clamp(-50, 50);
  // }
  //
  // void decrement() {
  //   _value = (_value - 10).clamp(-50, 50);
  // }
}
