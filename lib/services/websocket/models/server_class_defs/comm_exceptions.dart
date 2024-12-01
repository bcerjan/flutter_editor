class WebsocketConnectionException implements Exception {
  const WebsocketConnectionException([this.msg = '']);
  final String msg;
}

class FileNodeUpdateException implements Exception {
  const FileNodeUpdateException([this.msg = '']);
  final String msg;
}
