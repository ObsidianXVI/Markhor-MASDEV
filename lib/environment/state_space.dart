part of markhor;

class StateSpace<T extends State> {
  final List<T> states;

  StateSpace({required this.states});

  StateSpace.generator({
    required List<T> Function() generatorFn,
  }) : states = generatorFn();
}
