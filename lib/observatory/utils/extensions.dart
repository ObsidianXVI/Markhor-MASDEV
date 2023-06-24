part of markhor;

extension MapUtils on Map {
  String toColStr() {
    final List<String> lines = [];
    for (MapEntry entry in entries) {
      lines.add("${entry.key}: ${entry.value}");
    }
    return lines.join('\n');
  }
}
