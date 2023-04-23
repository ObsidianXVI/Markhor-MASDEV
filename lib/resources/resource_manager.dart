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
  int memoryTokens;
  int processingTokens;
  int networkIngressTokens;
  int networkEgressTokens;

  ResourceManager(ResourceConfigs resourceConfigs)
      : memoryTokens = resourceConfigs.memoryTokens ?? 0,
        processingTokens = resourceConfigs.processingTokens ?? 0,
        networkIngressTokens = resourceConfigs.networkIngressTokens ?? 0,
        networkEgressTokens = resourceConfigs.networkEgressTokens ?? 0;
}
