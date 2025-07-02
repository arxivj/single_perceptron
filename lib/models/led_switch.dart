enum LedState {
  on(1),
  off(-1);

  final int value;

  const LedState(this.value);
}

class LedSwitch {
  LedState _state = LedState.off;

  LedSwitch();

  LedState get state => _state;

  int get value => _state.value;

  void toggle() {
    _state = _state == LedState.on ? LedState.off : LedState.on;
  }
}
