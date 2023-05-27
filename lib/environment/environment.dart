part of markhor;

abstract class Environment extends MarkhorComponent {
  final List<Hook> hooks = [];
  final ResourceConfigs? resourceConfigs;
  final NetworkConfigs? networkConfigs;
  final ActionSpace actionSpace;
  final StateSpace stateSpace;
  final ParamSpace paramSpace;
  final ResourceManager? resourceManager;
  final Observatory? observatory;
  final DataStore? dataStore;
  final RunConfigs runConfigs;
  final Map<QVector, double> qTable = {};
  final bool enableDynamicQValueInitialiser;
  int envTimestep = 0;

  Environment({
    required this.actionSpace,
    required this.stateSpace,
    required this.paramSpace,
    required this.resourceConfigs,
    required this.networkConfigs,
    required this.resourceManager,
    required this.runConfigs,
    required this.enableDynamicQValueInitialiser,
    this.observatory,
    this.dataStore,
    Map<QVector, double> Function()? qTableInitialiser,
  }) {
    if (qTableInitialiser != null) qTable.addAll(qTableInitialiser());
  }

  void advance(EnvReport report) {
    envTimestep++;
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

  double lookupQValue(QVector qVector) {
    if (qTable.containsKey(qVector)) {
      return qTable[qVector]!;
    } else if (enableDynamicQValueInitialiser) {
      qTable[qVector] = 0;
      return 0;
    } else {
      throw "No QValue found for ${qVector.toVectorStr()}. Try enabling 'dynamicQValueInitialiser'";
    }
  }

  void updateQValue(QVector qVector, double newValue) {
    qTable[qVector] = newValue;
  }
}
