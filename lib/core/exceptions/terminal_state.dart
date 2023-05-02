part of markhor;

class MarkhorException implements Exception {
  final String msg;
  MarkhorException(this.msg);
}

class TerminalStateException extends MarkhorException {
  TerminalStateException() : super('Terminal state provided');
}
