part of markhor;
/* 
class Vars {
  final Map<String, Map<String, dynamic>> _store = {};

  T? get<T>(String scope, String name) {
    if (_store.containsKey(scope) && _store[scope]!.containsKey(name)) {
      return _store[scope]![name] as T;
    } else {
      return null;
    }
  }

  T put<T>(String name, T value) {
    _store.putIfAbsent(scope(), () => {name: value});
    print(_store);
    return value;
  }
} */

/* class Globals {
  final Map<String, dynamic> _store = {};

  T? get<T>(String name) {
    if (_store.containsKey(name)) {
      return _store[name] as T;
    } else {
      return null;
    }
  }

  T put<T>(String name, T value) {
    _store[name] = value;
    return value;
  }
} */
