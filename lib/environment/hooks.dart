part of markhor;

abstract class Hook {
  final Environment env;

  Hook({required this.env});
}

class TimestepHook extends Hook {
  final void Function(Environment) body;
  TimestepHook({required super.env, required this.body});
}
