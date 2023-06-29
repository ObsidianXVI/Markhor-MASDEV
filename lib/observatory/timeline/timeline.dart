part of markhor;

class Timeline extends ObservatoryClient {
  final TimelineConfigs timelineConfigs;
  final StreamController<int> _streamController = StreamController();
  late Stream<int> eventStream = _streamController.stream;
  final Map<String, List> csvData;

  Timeline({required this.timelineConfigs})
      : csvData = <String, List>{
          'timeStep': [],
          for (String key in timelineConfigs.monitoredAttr.keys) key: []
        } {
    timelineConfigs.monitoredAttr.addAll({
      'timeStep': (EnvReport envReport) {
        return envReport.timeStep;
      },
    });
  }

  @override
  void onEvent(EnvReport envReport) {
    final List<String> logs = [];
    for (String key in csvData.keys) {
      final dynamic accessValue =
          timelineConfigs.monitoredAttr[key]!(envReport);
      csvData[key]!.add(accessValue);
      logs.add("    $key: $accessValue");
    }
    if (timelineConfigs.liveReport) {
      print("""
${envReport.timeStep} | ${envReport.actionResult.newState}
  ${logs.join('\n  ')}
""");
    }
  }

  Future<String> exportCSV(String testName, [String? directory]) async {
    const String delimiter = ';';
    directory ??= './data';
    await Directory(directory).create();
    final File dataFile = await File("$directory/$testName.csv").create();
    final List<String> headers = csvData.keys.toList();
    final int rowCount = csvData['timeStep']!.length;
    final List<String> data = [];
    data.add(headers.join(delimiter));
    for (int i = 0; i < rowCount; i++) {
      final List rowData = [];
      for (String header in headers) {
        rowData.add(csvData[header]![i]);
      }
      data.add(rowData.join(delimiter));
    }
    dataFile.writeAsString(data.join('\n'));
    return dataFile.path;
  }
}

class TimelineConfigs {
  final bool liveReport;
  final Map<String, dynamic Function(EnvReport)> monitoredAttr;

  TimelineConfigs({
    required this.monitoredAttr,
    this.liveReport = false,
  });
}
