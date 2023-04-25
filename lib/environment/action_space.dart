part of markhor;

class ActionSpace {
  final List<Action> actions;

  ActionSpace({required this.actions});
}

abstract class Action<T> {
  final void Function(T) body;

  Action({
    required this.body,
  });
}

class ActionResult {
  final State previouState;
  final Action actionTaken;
  final ArgSet argSetUsed;
  final double reward;
  final State newState;
  late QVector selectedQVector;
  late double oldQValueOfSelectedQVect;
  late double newQValueOfSelectedQVect;
  late bool isRandom;

  ActionResult({
    required this.previouState,
    required this.actionTaken,
    required this.argSetUsed,
    required this.reward,
    required this.newState,
  });
}
