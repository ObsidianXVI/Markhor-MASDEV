part of markhor;

class ResourceConfigs {
  final int? memoryTokens;
  final int? processingTokens;
  final int? networkIngressTokens;
  final int? networkEgressTokens;

  ResourceConfigs({
    this.memoryTokens,
    this.processingTokens,
    this.networkIngressTokens,
    this.networkEgressTokens,
  });
}

class ResourceManager extends Manager {
  ResourceManager(super.env);
}
