part of markhor;

abstract class DevelopmentEnv extends Environment {
  DevelopmentEnv({
    required super.actionSpace,
    required super.parameterSpace,
    required super.stateSpace,
    super.networkConfigs,
    super.resourceConfigs,
  });
}
