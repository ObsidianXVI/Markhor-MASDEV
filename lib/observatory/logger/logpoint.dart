part of markhor;

class ValueMonitor<T> {
  final T reference;
  final StreamController<T> _streamController = StreamController();

  ValueMonitor(this.reference);

  void emit(T event) {
    _streamController.add(event);
  }

  void log() {
    print(reference.toString());
  }
}
