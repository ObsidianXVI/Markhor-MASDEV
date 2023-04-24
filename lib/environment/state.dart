part of markhor;

abstract class State extends Vector {
  final List<Action> actionsAvailable;
  final bool isTerminal;
  State({
    required this.actionsAvailable,
    this.isTerminal = false,
    required super.dimensions,
    required super.values,
  });
}
