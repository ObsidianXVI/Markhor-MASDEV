part of markhor;

/// A [SimulatorController] exposes an API for the user to modify the respective
/// [SimulatedComponent]'s configuration at runtime.
abstract class SimulatorController<T extends SimulatedComponent>
    extends MarkhorComponent {
  SimulatorController(super.env);
}

/// A [SimulatedComponent] represents a specific class that is being simulated.
abstract class SimulatedComponent extends MarkhorComponent {
  SimulatedComponent(super.env);
}

/* String scope() {
  final List<String> chunks = ((StackTrace.current.toString().split('\n')
        ..removeAt(0))
      .first
      .split(' '));
  chunks.removeWhere(
      (String e) => e.startsWith('#') || e.isEmpty || e.startsWith('('));
  return chunks.first;
} */
