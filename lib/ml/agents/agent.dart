part of markhor;

abstract class Agent {
  final Environment env;
  final List<State> states;
  final List<Action> actions;

  Agent({required this.env})
      : states = env.stateSpace.states,
        actions = env.actionSpace.actions;
}
