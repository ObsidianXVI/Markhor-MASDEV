part of markhor;

abstract class QLAgent extends Agent {
  final QLRunConfigs runConfigs;
  int currentEpoch = 0;
  int currentEpisode = 0;
  int timeStep = 0;

  QLAgent({
    required super.env,
    required this.runConfigs,
  });

  ActionResult perform([State? state]);

  Future<void> run(State initialState) async {
    if (initialState.isTerminal) throw TerminalStateException();
    State currentState = initialState;
    ActionResult actionResult;
    for (; currentEpoch < runConfigs.epochs; currentEpoch++) {
      for (; currentEpisode < runConfigs.episodes; currentEpisode++) {
        if (runConfigs.maxTimesteps != null &&
            runConfigs.maxTimesteps == timeStep) return;
        actionResult = perform(initialState);
        currentState = actionResult.newState;
        try {
          while (true) {
            await Future.delayed(runConfigs.timestepPause ?? Duration.zero, () {
              actionResult = perform(currentState);
              currentState = actionResult.newState;
              timeStep++;
              env.advance(
                EnvReport(
                  timeStep: timeStep,
                  epochNum: currentEpoch,
                  episodeNum: currentEpisode,
                  actionResult: actionResult,
                ),
              );
            });
          }
        } on MarkhorException catch (e) {
          if (e is TerminalStateException) {
            for (EpisodeEndHook hook in env.hooks.whereType<EpisodeEndHook>()) {
              hook.body?.call(env);
              if (hook.asyncBody != null) await hook.asyncBody!.call(env);
            }
            env.reset();
            continue;
          }
        }
      }
    }
  }
}
