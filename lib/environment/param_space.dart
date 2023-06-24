part of markhor;

class ParamSpace {
  final List<ArgSet> argSets;

  ParamSpace({required this.argSets});
}

abstract class ArgSet extends Vector {
  const ArgSet({
    required super.values,
    required super.dimensions,
  });

  String toInstanceLabel();

  @override
  String toString() {
    final InstanceMirror im = reflect(this);
    final ClassMirror classMirror = im.type;
    final String argSetName = classMirror.reflectedType.toString();
    final List<String> constructors = classMirror.declarations.keys
        .where((Symbol s) => s.toString().contains(argSetName))
        .map((e) => e
            .toString()
            .replaceAll("Symbol(\"", '')
            .replaceAll("$argSetName.", '')
            .replaceAll('")', ''))
        .toList();
    return "$argSetName<${values.first}>";
  }

  @override
  bool equalityComparator(Object other) {
    return (other is ArgSet) && (other.runtimeType == runtimeType);
  }
}
