part of markhor;

class QLRunConfigs extends RunConfigs {
  double learningRate;
  final double learningRateDecay;
  final double discountFactor;
  final double epsilonValue;
  final int episodes;
  final int epochs;
  final int? maxTimesteps;

  QLRunConfigs({
    required this.learningRate,
    required this.learningRateDecay,
    required this.discountFactor,
    required this.epsilonValue,
    required this.episodes,
    required this.epochs,
    this.maxTimesteps,
    super.timestepPause,
  });
}
