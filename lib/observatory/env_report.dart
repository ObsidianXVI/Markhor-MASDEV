part of markhor;

class EnvReport {
  final ActionResult actionResult;
  final int timeStep;
  final int epochNum;
  final int episodeNum;
  final Action previousAction;
  final double rewardObtained;
  final QVector selectedQVector;
  final double oldQValueOfSelectedQVect;
  final double newQValueOfSelectedQVect;
  final bool isRandom;
  final DateTime timestamp = DateTime.now();

  EnvReport({
    required this.timeStep,
    required this.epochNum,
    required this.episodeNum,
    required this.actionResult,
  })  : previousAction = actionResult.actionTaken,
        rewardObtained = actionResult.reward,
        selectedQVector = actionResult.selectedQVector,
        oldQValueOfSelectedQVect = actionResult.oldQValueOfSelectedQVect,
        newQValueOfSelectedQVect = actionResult.newQValueOfSelectedQVect,
        isRandom = actionResult.isRandom;
}
