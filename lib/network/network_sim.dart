part of markhor;

class NetworkConfigs {
  double networkLatency;
  Map<Uri, Future<void> Function(Uri, HttpClientRequest)> requestTriggers = {};
  Map<Uri, Future<HttpClientRequest> Function(Uri, HttpClientRequest)>
      requestInterceptors = {};
  Map<Uri, Future<void> Function(Uri, HttpClientResponse)> responseTriggers =
      {};
  Map<Uri, Future<HttpClientResponse> Function(Uri, HttpClientResponse)>
      responseInterceptors = {};

  NetworkConfigs({
    this.networkLatency = 0,
  });
}

class NetworkSimulator<NetworkSimulatorClient> extends SimulatorController {
  NetworkSimulator(super.env);
}

class NetworkSimulatorClient extends SimulatedComponent {
  final HttpClient httpClient = HttpClient();

  NetworkSimulatorClient(super.env);

  Future<NSHttpClientRequest> getUrl(Uri url) async {
    HttpClientRequest req = await httpClient.getUrl(url);
    if (_env.networkConfigs != null) {
      if (_env.networkConfigs!.requestTriggers.containsKey(url)) {
        await (_env.networkConfigs!.requestTriggers[url]!.call(url, req));
      } else if (_env.networkConfigs!.requestInterceptors.containsKey(url)) {
        req = await (_env.networkConfigs!.requestInterceptors[url]!
            .call(url, req));
      }
    }

    return NSHttpClientRequest._(req, networkConfigs: _env.networkConfigs);
  }
}

class NSHttpClientRequest {
  final HttpClientRequest req;
  final NetworkConfigs? networkConfigs;

  NSHttpClientRequest._(
    this.req, {
    this.networkConfigs,
  });

  Future<HttpClientResponse> close() async {
    HttpClientResponse res = await req.close();
    if (networkConfigs != null) {
      if (networkConfigs!.responseTriggers.containsKey(req.uri)) {
        await (networkConfigs!.responseTriggers[req.uri]!.call(req.uri, res));
      } else if (networkConfigs!.responseInterceptors.containsKey(req.uri)) {
        res = await (networkConfigs!.responseInterceptors[req.uri]!
            .call(req.uri, res));
      }
    }
    return res;
  }
}
