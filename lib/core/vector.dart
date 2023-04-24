part of markhor;

abstract class Vector {
  final int dimensions;
  final List values;

  Vector({required this.dimensions, required this.values});

  bool equalityComparator(Object other);

  @override
  bool operator ==(Object other) => equalityComparator(other);
}
