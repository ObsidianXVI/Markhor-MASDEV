part of markhor;

class Observatory {
  final ObservatoryConfigs observatoryConfigs;
  final StreamController<EnvReport> _streamController;
  late Stream<EnvReport> stream = _streamController.stream;

  Observatory({
    required this.observatoryConfigs,
  }) : _streamController = StreamController();

  void addReport(EnvReport envReport) {
    _streamController.add(envReport);
  }
}

class ObservatoryConfigs {}

abstract class ObservatoryClient {
  void listenOn(Observatory observatory) {
    observatory.stream.listen(((EnvReport report) {
      onEvent(report);
    }));
  }

  void onEvent(EnvReport envReport);
}
