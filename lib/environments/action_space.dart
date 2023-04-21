part of markhor;

class ActionSpace {
  final List<Action> actions;

  ActionSpace({required this.actions});
}

abstract class Action<T> {
  final ParamSet<Action<T>> paramSet;
  final T Function(ArgSet<ParamSet<Action<T>>>) body;

  Action({
    required this.body,
    this.paramSet = const ParamSet.none(),
  });

  ActionResult performWith(ArgSet<ParamSet<Action<T>>> argSet) {
    body(argSet);
    return ActionResult(reward: 0);
  }
}

class ActionResult {
  final double reward;

  ActionResult({required this.reward});
}
