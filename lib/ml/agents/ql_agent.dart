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
        print('starting ep $currentEpisode');
        timeStep = 0;
        actionResult = perform(initialState);
        currentState = actionResult.newState;
        try {
          while (runConfigs.maxTimesteps != null &&
              runConfigs.maxTimesteps! > timeStep) {
            print('inside loop');
            await Future.delayed(runConfigs.timestepPause ?? Duration.zero, () {
              print('about to perform');
              actionResult = perform(currentState);
              print('performed');
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
            env.reset();
            continue;
          }
        }
        await env.advanceEpisode(this);
      }
    }
  }
}
