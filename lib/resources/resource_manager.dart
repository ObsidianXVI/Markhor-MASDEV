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

  ResourceManager(super.env)
      : memoryTokens = env.resourceConfigs?.memoryTokens ?? 0,
        processingTokens = env.resourceConfigs?.processingTokens ?? 0,
        networkIngressTokens = env.resourceConfigs?.networkIngressTokens ?? 0,
        networkEgressTokens = env.resourceConfigs?.networkEgressTokens ?? 0;
}
