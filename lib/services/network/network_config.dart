class NetworkConfig {
  NetworkConfig(
      {this.baseUrl,
      this.httpProxy,
      this.httpProxyPort,
      this.contentType,
      this.receiveTimeout,
      this.connectTimeout});

  String? baseUrl;

  String? httpProxy;

  int? httpProxyPort;

  String? contentType = 'application/json; charset=utf-8';

  int? receiveTimeout = 5000;

  int? connectTimeout = 30000;

}
