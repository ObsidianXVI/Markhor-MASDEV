part of markhor;

class QVector extends Vector {
  final State state;
  final Action action;

  const QVector(
    this.state,
    this.action, {
    required super.dimensions,
    required super.values,
  });

  @override
  bool equalityComparator(Object other) {
    if (other is! QVector) {
      return false;
    } else {
      return (state == other.state && action == other.action);
    }
  }
}
