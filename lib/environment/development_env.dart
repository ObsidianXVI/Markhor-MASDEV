part of markhor;

abstract class DevelopmentEnv extends Environment {
  DevelopmentEnv({
    required super.actionSpace,
    required super.stateSpace,
    required super.paramSpace,
    required super.runConfigs,
    super.networkConfigs,
    super.resourceConfigs,
    super.resourceManager,
    super.observatory,
    super.dataStore,
  });
}
