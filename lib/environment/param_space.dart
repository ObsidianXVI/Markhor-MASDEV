part of markhor;

class ParamSpace {
  final List<ArgSet> argSets;

  ParamSpace({required this.argSets});
}

abstract class ArgSet<T extends Action> {}
