/// A [Parameter] represents a single parameter in a function declaration.
class Parameter<T> {
  final String name;
  final T? defaultValue;

  Parameter({
    required this.name,
    this.defaultValue,
  });
}

/// A [ParamSet] is a set of [Parameter]s that belongs to a function.
abstract class ParamSet {
  final List<Parameter> params;

  ParamSet(this.params);

  ArgSet<ParamSet> fulfill();
}
