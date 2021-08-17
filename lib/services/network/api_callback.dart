mixin ApiCallback {
  Future<void> onStart(String path);
  Future<void> onCompleted(String path, Map<String, dynamic> response);

  Future<void> onReceiveProgress(String path, int progress, int total) async {}
  Future<void> onSendProgress(String path, int progress, int total) async {}
}
