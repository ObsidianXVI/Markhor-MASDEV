part of markhor;

class Delay {
  static Future<T> action<T>(T Function() fn, Duration duration) async {
    return await Future.delayed(duration, fn);
  }
}
