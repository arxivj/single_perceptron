class LedSwitch {
  bool _isOn = false;

  LedSwitch();

  bool get isOn => _isOn;

  int get value => _isOn ? 1 : -1;

  void toggle() {
    _isOn = !_isOn;
  }
}
