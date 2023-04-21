part of markhor;

abstract class Environment {
  final ResourceConfigs? resourceConfigs;
  final NetworkConfigs? networkConfigs;
  final ActionSpace actionSpace;
  final ParameterSpace parameterSpace;
  final StateSpace stateSpace;

  Environment({
    required this.actionSpace,
    required this.parameterSpace,
    required this.stateSpace,
    required this.resourceConfigs,
    required this.networkConfigs,
  });
}
