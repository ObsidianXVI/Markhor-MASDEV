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

  void run(State initialState) {
    State currentState = initialState;
    ActionResult actionResult;
    for (; currentEpoch < runConfigs.epochs; currentEpoch++) {
      for (; currentEpisode < runConfigs.episodes; currentEpisode++) {
        if (initialState.isTerminal)
          throw Exception("Initial state is terminal");
        actionResult = perform(initialState);
        currentState = actionResult.newState;
        try {
          while (true) {
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
          }
        } on Exception catch (e) {
          if (e.toString() == 'Initial state is terminal') {
            return;
          }
        }
      }
    }
  }
}
