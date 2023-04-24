part of markhor;

abstract class Environment {
  final ResourceConfigs? resourceConfigs;
  final NetworkConfigs? networkConfigs;
  final ActionSpace actionSpace;
  final StateSpace stateSpace;
  final ParamSpace paramSpace;
  final ResourceManager? resourceManager;

  Environment({
    required this.actionSpace,
    required this.stateSpace,
    required this.paramSpace,
    required this.resourceConfigs,
    required this.networkConfigs,
    required this.resourceManager,
  });

  GlobalState? get globalState;

  /// The agent performs an action on the environment, and a reward of type
  /// [double] is returned. This method is part of the environment and not the
  /// agent because the environment will have logging and profiling tools attached
  /// to observe the actions taken.
  double performAction<R>(Action<R> action, ArgSet<Action<R>> argSet);
}
