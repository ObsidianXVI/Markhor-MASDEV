part of markhor;

class Observatory {
  final ObservatoryConfigs observatoryConfigs;
  final List<EnvReport> _reports = [];
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
  final List<EnvReport> reports = [];

  void listenOn(Observatory observatory) {
    observatory.stream.listen(((EnvReport report) {
      reports.add(report);
      onEvent(report);
    }));
  }

  void onEvent(EnvReport envReport);
}
