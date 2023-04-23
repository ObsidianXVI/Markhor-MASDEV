part of markhor;

abstract class State {
  final List<Action> actionsAvailable;
  final bool isTerminal;
  State({required this.actionsAvailable, this.isTerminal = false});
}
