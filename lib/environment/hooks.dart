part of markhor;

abstract class Hook {
  final Environment env;

  Hook({required this.env});
}

class TimestepHook extends Hook {
  final void Function(Environment) body;
  TimestepHook({required super.env, required this.body});
}

class EpisodeEndHook extends Hook {
  final void Function(Environment)? body;
  final Future<void> Function(Environment)? asyncBody;

  EpisodeEndHook({required super.env, this.body, this.asyncBody});
}
