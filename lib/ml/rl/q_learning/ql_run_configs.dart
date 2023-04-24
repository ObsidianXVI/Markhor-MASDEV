part of markhor;

class QLRunConfigs extends RunConfigs {
  final double learningRate;
  final double discountFactor;
  final double epsilonValue;
  final int episodes;
  final int epochs;

  QLRunConfigs({
    required this.learningRate,
    required this.discountFactor,
    required this.epsilonValue,
    required this.episodes,
    required this.epochs,
  });
}
