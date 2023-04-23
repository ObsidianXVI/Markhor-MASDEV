abstract class Action<T extends ParamSet> {
  final void Function(ArgSet<T>) fn;

  Action(this.fn);

  void perform(ArgSet<T> args) {}
}

/// An [ArgSet] is a set of arguments provided for each [Parameter] in
/// the [ParamSet] of a given function. It is generated by calling `ParamSet.fulfill()`
abstract class ArgSet<T extends ParamSet> {}

class HttpGet extends Action<HttpParams> {
  HttpGet() : super((ArgSet<HttpParams> args) {});
}

class HttpParams extends ParamSet {
  HttpParams()
      : super([
          Parameter<Uri>(name: 'uri'),
          Parameter<String>(name: 'path'),
          Parameter<Map<String, String>>(name: 'headers'),
        ]);

  @override
  ArgSet<ParamSet> fulfill() {}
}