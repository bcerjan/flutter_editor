import 'package:editor/services/websocket/remote_connection.dart';
import 'package:flutter/foundation.dart';

class RemoteProvider<T extends RemoteConnection> extends ChangeNotifier {
  RemoteProvider();
  T? remote;

  bool get connected => remote != null;

  void connect(T remote) {
    this.remote = remote;

    // We need the delay for the stream from the websocket to be initialized
    // probably there is a more elegant method to handle this...
    Future.delayed(const Duration(milliseconds: 50), () => notifyListeners());
  }

  void disconnect() {
    if (remote != null) {
      remote!.disconnect();
    }
    remote = null;
    notifyListeners();
  }

  @override
  void dispose() {
    if (remote != null) {
      remote!.disconnect();
    }
    super.dispose();
  }
}
