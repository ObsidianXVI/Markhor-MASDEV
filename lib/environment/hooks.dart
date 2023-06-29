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
  final void Function(Environment, QLAgent)? body;
  final Future<void> Function(Environment, QLAgent)? asyncBody;
  final Duration? pause;

  EpisodeEndHook({required super.env, this.body, this.asyncBody, this.pause});
}
