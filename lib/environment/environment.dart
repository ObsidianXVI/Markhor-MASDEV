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

  Future<void> advanceEpisode(QLAgent qlAgent) async {
    for (EpisodeEndHook endHook in hooks.whereType<EpisodeEndHook>()) {
      if (endHook.asyncBody != null) await endHook.asyncBody!(this, qlAgent);
      if (endHook.body != null) endHook.body!(this, qlAgent);
      if (endHook.pause != null) await Future.delayed(endHook.pause!);
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
      final double qVectVal;
      if (qVector is QVector3D) {
        final bool argIsCompat =
            qVector.action.isCompatibleWithArgSet(qVector.argSet);
        qVectVal = argIsCompat ? 0 : -1;
      } else {
        qVectVal = 0;
      }
      qTable[qVector] = qVectVal;
      return qVectVal;
    } else {
      throw "No QValue found for ${qVector.toVectorStr()}. Try enabling 'dynamicQValueInitialiser'";
    }
  }

  void updateQValue(QVector qVector, double newValue) {
    qTable[qVector] = newValue;
  }
}
