import 'dart:io';
import 'dart:convert';
import 'package:editor/services/websocket/models/server_class_defs/file_node.dart';
import 'package:editor/services/websocket/remote_provider.dart';
import 'package:path/path.dart' as _path;
import 'package:editor/services/explorer/filesystem.dart';
import 'package:editor/services/websocket/models/server_class_defs/message_types.dart';
import 'package:editor/services/websocket/remote_connection.dart';
import 'package:editor/services/websocket/websocket_connection.dart';

class RemoteFs<T extends RemoteConnection> extends ExplorerBackend {
  RemoteFs({
    this.wsConnection,
    this.msgStream,
  });
  List<ExplorerListener> listeners = [];
  List<FileSystemEntity> files = [];
  String rootPath = '';
  T? wsConnection;

  /// Note: needs to be a broadcast stream to correctly handle sub-functions
  /// connecting/disconnecting from it
  Stream<ServerMessage>? msgStream;

  void remoteChange(RemoteProvider<T> provider) {
    if (provider.remote != null) {
      wsConnection = provider.remote;
      msgStream = provider.remote!.messages;
    } else {
      wsConnection = null;
      msgStream = null;
    }
  }

  @override
  void addListener(ExplorerListener listener) {
    listeners.add(listener);
  }

  @override
  void setRootPath(String path) {
    checkConnection();
    wsConnection!.getDirectory(path: _path.toUri(path));
    rootPath = _path.normalize(path);
  }

  @override
  void createDirectory(String path) {
    //TODO: Unimplemented erver side
  }

  @override
  void createFile(String path) {
    // TODO: Unimplemented server side
  }

  @override
  void deleteDirectory(String path, {bool recursive = false}) {
    // TODO: Unimplemented server side
  }

  @override
  void deleteFile(String path) {
    // TODO: Unimplemented server side
  }

  @override

  /// Should this be the same as setRootPath?
  /// TODO: check if this works correctly with empty directories
  void loadPath(String path) async {
    checkConnection();
    final ServerMessage msg = await msgStream!
        .asBroadcastStream()
        .firstWhere((msg) => msg.type == ServerMessageType.directoryContent);

    files.clear();

    final newTree = FileNode.fromServerDirectory(
      rootPath: msg.content['path'] ?? rootPath,
      jsonList: msg.content['content'],
    );

    if (newTree.children == null) {
      // no children in this location, just parent folder
      return;
    }

    for (final l in listeners) {
      for (final k in newTree.children!) {
        final json = k.toFSJSON();
        l.onLoad(json);
      }
    }
  }

  @override
  void openFile(String path) async {
    /// This appears to be unused in this location, maybe only used somewhere else?
    // wsConnection.openFile(path: _path.toUri(path));

    // final ServerMessage msg = await msgStream
    //     .firstWhere((msg) => msg.type == ServerMessageType.documentContent);
  }

  @override
  void renameDirectory(String path, String newPath) {
    // TODO: Unimplemented server side
  }

  @override
  void renameFile(String path, String newPath) {
    // TODO: Unimplemented server side
  }

  @override

  /// Only searches filenames
  void search(String fileName) {
    checkConnection();
    // no command for searching within files in the override...
    wsConnection!.search(search: fileName);
  }

  /// Searches filenames and content
  void contentSearch(String query) {
    checkConnection();
    wsConnection!.search(search: query, searchContent: true);
  }

  void checkConnection() {
    if (wsConnection == null || msgStream == null) {
      throw Exception('No connection established yet -- initialize first');
    }
  }
}
