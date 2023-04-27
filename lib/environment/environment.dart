part of markhor;

abstract class Environment {
  final List<Hook> hooks = [];
  final ResourceConfigs? resourceConfigs;
  final NetworkConfigs? networkConfigs;
  final ActionSpace actionSpace;
  final StateSpace stateSpace;
  final ParamSpace paramSpace;
  final ResourceManager? resourceManager;
  final Observatory? observatory;
  final DataStore? dataStore;

  Environment({
    required this.actionSpace,
    required this.stateSpace,
    required this.paramSpace,
    required this.resourceConfigs,
    required this.networkConfigs,
    required this.resourceManager,
    this.observatory,
    this.dataStore,
  });

  void advance(EnvReport report) {
    observatory?.addReport(report);
    for (TimestepHook timestepHook in hooks.whereType<TimestepHook>()) {
      timestepHook.body(this);
    }
  }

  GlobalState? get globalState;

  void addHook(Hook hook) => hooks.add(hook);

  /// The agent performs an action on the environment, and a reward of type
  /// [double] is obtained. This method is part of the environment and not the
  /// agent because the environment will have logging and profiling tools attached
  /// to observe the actions taken.
  ActionResult performAction(Action action, ArgSet argSet);

  Map<QVector, double> initialiseQTable();
}
