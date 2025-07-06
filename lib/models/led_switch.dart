class LedSwitch {
  static const bool initialIsOn = false;

  bool _isOn = initialIsOn;

  LedSwitch();

  bool get isOn => _isOn;

  int get value => _isOn ? 1 : -1;

  void toggle() {
    _isOn = !_isOn;
  }

  void reset() {
    _isOn = initialIsOn;
  }
}
