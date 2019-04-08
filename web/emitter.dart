class Emitter {
  Map<String, List<Function>> _listners = {};

  void on(String eventName, Function listner) {
    if (!_listners.containsKey(eventName)) _listners[eventName] = [];

    _listners[eventName].add(listner);
  }

  void off(String eventName, Function listner) {
    if (!_listners.containsKey(eventName)) return;

    _listners[eventName].removeWhere((l) => l == listner);
  }

  void emit(String eventName, [dynamic event]) {
    if (!_listners.containsKey(eventName)) return;

    _listners[eventName].forEach((l) {
      if (event != null) l(event);
      else l();
    });
  }
}

Emitter emitter = Emitter();
