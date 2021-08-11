

mixin ApiCallback<T> {
  Future<void> onStart(String path);
  Future<void> onCompleted(String path, dynamic response);

  Future<void> onReceiveProgress(int progress, int total) async {}
  Future<void> onSendProgress(int progress, int total) async {}
}