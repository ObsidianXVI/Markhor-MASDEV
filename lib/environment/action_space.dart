part of markhor;

class ActionSpace {
  final List<Action> actions;

  ActionSpace({required this.actions});
}

typedef ActionBody<A extends ArgSet> = void Function(A, Environment);

abstract class Action<A extends ArgSet> {
  final ActionBody<A> body;
  Action({
    required this.body,
  });

  A convertArgSet(ArgSet argSet) {
    try {
      final A x = argSet as A;
      return x;
    } catch (e) {
      throw Exception("Convert arg set failed");
    }
  }

  @override
  String toString() {
    final InstanceMirror im = reflect(this);
    final ClassMirror classMirror = im.type;
    return classMirror.reflectedType.toString();
  }

  bool isCompatibleWithArgSet(ArgSet argSet) {
/*     print(
        "${toString()} ${argSet is A ? 'APPROVED' : 'REJECTED'} ${argSet.runtimeType}"); */
    return argSet is A;
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
