class ConnectOpts {
  String url;
  int timeout;
  dynamic wsClient;

  ConnectOpts([String url, int timeout, dynamic wsClient]) {
    this.url = url;
    this.timeout = timeout;
    this.wsClient = wsClient;
  }
}
