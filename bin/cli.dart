library markhor.cli;

import 'dart:io';

void main(List<String> args) {
  /// single-word, alphabets only
  if (args[0] == 'create') {
    createProject(args[1]);
  }
}

Future<void> createProject(String name) async {
  final Directory rootDir = await Directory('./$name').create(recursive: true);
  final String rootPath = rootDir.path;
  final File rootFile = await File('$rootPath/mkproj.dart').create();
  final String envName = "${name.capitalize()}Environment";
  final String resourceManName = "${name.capitalize()}ResourceManager";
  final String resourceConfigsName = "${name.capitalize()}ResourceConfigs";
  final String globalStateName = "${name.capitalize()}GlobalState";
  final String stateName = "${name.capitalize()}State";
  final String libName = "${name}_mkproj";
  final String fileHeader = "part of $libName;";

  /// final DevelopmentEnvironment env = $envName();
  rootFile.writeAsString("""
library $libName;

import 'package:markhor/markhor.dart';
export 'package:markhor/markhor.dart';

part './environment/environment.dart';
part './environment/actions/actions.dart';
part './environment/states/states.dart';
part './environment/states/global_states.dart';
part './environment/params/param_sets.dart';
part './resources/data_cells/data_cells.dart';
part './resources/resource_manager/resource_manager.dart';
part './resources/resource_manager/resource_configs.dart';
""");

  final File envFile = await File("$rootPath/environment/environment.dart")
      .create(recursive: true);
  envFile.writeAsString("""
$fileHeader

class $envName extends Environment {
    $envName({
    required super.actionSpace,
    required super.parameterSpace,
    required super.stateSpace,
    required super.resourceConfigs,
    required super.networkConfigs,
  });

  @override
  $resourceManName get resourceManager => $resourceManName(this);

  @override
  $globalStateName get globalState => $globalStateName();
}
""");
  final File actionsFile =
      await File("$rootPath/environment/actions/actions.dart")
          .create(recursive: true);
  actionsFile.writeAsString(fileHeader);
  final File statesFile = await File("$rootPath/environment/states/states.dart")
      .create(recursive: true);
  statesFile.writeAsString("""
$fileHeader

class $stateName extends State {
  $stateName();

  $stateName.current($envName env);
}
""");
  final File globalStatesFile =
      await File("$rootPath/environment/states/global_states.dart")
          .create(recursive: true);
  globalStatesFile.writeAsString("""
$fileHeader
class $globalStateName extends GlobalState {
  $globalStateName();
}
""");
  final File paramSetsFile =
      await File("$rootPath/environment/params/param_sets.dart")
          .create(recursive: true);
  paramSetsFile.writeAsString(fileHeader);
  final File dataCellsFile =
      await File("$rootPath/resources/data_cells/data_cells.dart")
          .create(recursive: true);
  dataCellsFile.writeAsString(fileHeader);
  final File resourceManFile =
      await File("$rootPath/resources/resource_manager/resource_manager.dart")
          .create(recursive: true);
  resourceManFile.writeAsString("""
$fileHeader

class $resourceManName extends ResourceManager {
  $resourceManName($envName env) : super(env);
}
""");

  final File resourceConfigsFile =
      await File("$rootPath/resources/resource_configs/resource_configs.dart");
  resourceConfigsFile.writeAsString("""
$fileHeader

class $resourceConfigsName extends ResourceConfigs {

  $resourceConfigsName({
    super.memoryTokens,
    super.networkEgressTokens,
    super.networkIngressTokens,
    super.processingTokens,
  });
}
""");
  /**
   * - name/
   *    - mkproj.dart
   *    - environment/
   *        - environment.dart
   *        - actions/
   *            - actions.dart
   *        - states/
   *            - states.dart
   *            - global_states.dart
   *        - params/
   *            - param_sets.dart
   *    - resources/
   *        - data_cells/
   *          - data_cells.dart
   *        - resource_manager/
   *          - resource_manager.dart
   */
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
