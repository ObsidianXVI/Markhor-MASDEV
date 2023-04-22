part of markhor;

class ParameterSpace {
  final List<ParamSet> paramsets;

  ParameterSpace({required this.paramsets});
}

class ParamSet<A extends Action> {
  ParamSet();
  const ParamSet.none();
}

abstract class ArgSet<T extends ParamSet> {}
