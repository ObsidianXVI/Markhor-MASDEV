part of markhor;

abstract class Vector {
  final int dimensions;
  final List values;

  const Vector({required this.dimensions, required this.values});

  bool equalityComparator(Object other) {
    if (other is! Vector) {
      return false;
    } else {
      if (other.dimensions != dimensions) {
        return false;
      } else {
        if (!IterableEquality().equals(values, other.values)) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  bool operator ==(Object other) => equalityComparator(other);

  String toVectorStr() {
    final List<String> vals = [];
    for (int i = 0; i < values.length; i++) {
      final val = values[i];
      if (i == 0) {
        vals.add('${val is Vector ? val.toVectorStr() : val.toString()}');
      } else {
        vals.add(', ${val is Vector ? val.toVectorStr() : val.toString()}');
      }
    }
    final InstanceMirror im = reflect(this);
    final ClassMirror classMirror = im.type;
    final String instanceName = classMirror.reflectedType.toString();
    return "$instanceName<${vals.join()}>";
  }
}
