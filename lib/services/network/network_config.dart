class NetworkConfig {
  String baseUrl = 'https://google.com';

  String? httpProxy;

  int? httpProxyPort;

  String? contentType = 'application/json; charset=utf-8';

  int? receiveTimeout = 5000;

  int? connectTimeout = 30000;

  bool isShowHttpLog = true;
}
