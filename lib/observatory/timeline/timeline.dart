part of markhor;

class Timeline extends ObservatoryClient {
  final TimelineConfigs timelineConfigs;
  final StreamController<int> _streamController = StreamController();
  late Stream<int> eventStream = _streamController.stream;

  Timeline({required this.timelineConfigs});

  @override
  void onEvent(EnvReport envReport) {
    print(
      """
${envReport.timeStep} | ${envReport.actionResult.previouState} → ${envReport.actionResult.newState}
    preA: ${envReport.previousAction}
    preP: ${envReport.actionResult.argSetUsed}
    slQV: ${envReport.selectedQVector}
      oVal: ${envReport.oldQValueOfSelectedQVect}
      nVal: ${envReport.newQValueOfSelectedQVect}
      rand: ${envReport.isRandom}
    obtR: ${envReport.rewardObtained}
""",
    );
  }
}

class TimelineConfigs {
  final bool liveReport;

  TimelineConfigs({
    this.liveReport = false,
  });
}
