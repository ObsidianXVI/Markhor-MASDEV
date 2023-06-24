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

class QVector3D extends QVector {
  final ArgSet argSet;
  const QVector3D(
    super.state,
    super.action,
    this.argSet, {
    required super.values,
  }) : super(dimensions: 3);

  @override
  bool equalityComparator(Object other) {
    if (other is! QVector3D) {
      return false;
    } else {
      return (state == other.state &&
          action == other.action &&
          argSet == other.argSet);
    }
  }
}
