part of markhor;

class ActionSpace {
  final List<Action> actions;

  ActionSpace({required this.actions});
}

typedef ActionBody<T extends ArgSet> = void Function(T);

abstract class Action<T extends ArgSet> {
  final ActionBody<T> body;
  Action({
    required this.body,
  });

  T convertArgSet(ArgSet argSet) => argSet as T;

  @override
  String toString() {
    final InstanceMirror im = reflect(this);
    final ClassMirror classMirror = im.type;
    return classMirror.reflectedType.toString();
  }
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
