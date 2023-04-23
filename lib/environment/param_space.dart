part of markhor;

class ParameterSpace {
  final List<ParamSet> paramSets;
  final List<ArgSet> argSets;

  ParameterSpace({required this.paramSets, required this.argSets});
}

class ParamSet<A extends Action> {
  ParamSet();
  const ParamSet.none();
}

abstract class ArgSet<T extends ParamSet> {}
