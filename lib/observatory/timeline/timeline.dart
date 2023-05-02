part of markhor;

class Timeline extends ObservatoryClient {
  final TimelineConfigs timelineConfigs;
  final StreamController<int> _streamController = StreamController();
  late Stream<int> eventStream = _streamController.stream;
  final Map<String, List> csvData = {
    'timeStep': [],
    'argSetIndex': [],
    'state_memoryTokens': [],
    'state_ingredientTokens': [],
    'temporalDifference': [],
    'reward': [],
  };

  Timeline({required this.timelineConfigs});

  @override
  void onEvent(EnvReport envReport) {
    if (timelineConfigs.liveReport) {
      print(
        """
${envReport.timeStep} | ${envReport.actionResult.previouState}
    preA: ${envReport.previousAction}
    preP: ${envReport.actionResult.argSetUsed}
    slQV: ${envReport.selectedQVector.toVectorStr()}
      oVal: ${envReport.oldQValueOfSelectedQVect}
      nVal: ${envReport.newQValueOfSelectedQVect}
      rand: ${envReport.isRandom}
    obtR: ${envReport.rewardObtained}
""",
      );
    }
    csvData['timeStep']?.add(envReport.timeStep);
    csvData['argSetIndex']?.add(envReport.actionResult.argSetUsed.values.first);
    csvData['state_memoryTokens']
        ?.add(envReport.actionResult.previouState.values[0]);
    csvData['state_ingredientTokens']
        ?.add(envReport.actionResult.previouState.values[1]);
    csvData['temporalDifference']?.add(envReport.newQValueOfSelectedQVect -
        envReport.oldQValueOfSelectedQVect);
    csvData['reward']?.add(envReport.rewardObtained);
  }

  Future<String> exportCSV(String testName, [String? directory]) async {
    directory ??= './data';
    await Directory(directory).create();
    final File dataFile = await File("$directory/$testName.csv").create();
    final List<String> headers = csvData.keys.toList();
    final int rowCount = csvData['timeStep']!.length;
    final List<String> data = [];
    data.add(headers.join(','));
    for (int i = 0; i < rowCount; i++) {
      final List rowData = [];
      for (String header in headers) {
        rowData.add(csvData[header]![i]);
      }
      data.add(rowData.join(','));
    }
    dataFile.writeAsString(data.join('\n'));
    return dataFile.path;
  }
}

class TimelineConfigs {
  final bool liveReport;

  TimelineConfigs({
    this.liveReport = false,
  });
}
