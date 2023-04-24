part of markhor;

class ActionSpace {
  final List<Action> actions;

  ActionSpace({required this.actions});
}

abstract class Action<T> {
  final T Function(ArgSet<Action<T>>) body;

  Action({
    required this.body,
  });

  ActionResult performWith(ArgSet<Action<T>> argSet) {
    body(argSet);
    return ActionResult(reward: 0);
  }
}

class ActionResult {
  final double reward;

  ActionResult({required this.reward});
}
