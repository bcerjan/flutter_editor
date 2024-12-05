import 'dart:convert';
import 'dart:async';
import 'package:editor/services/websocket/models/server_class_defs/file_node.dart';
import 'package:editor/services/websocket/remote_connection.dart';
import 'package:path/path.dart' as _path;

List<String> folderExclude = [];
List<String> fileExclude = [];

class ExplorerItem {
  ExplorerItem(this.fullPath) {
    fileName = _path.basename(fullPath);
  }

  String fileName = '';
  String fullPath = '';
  String tempPath = '';
  String iconPath = '';

  int depth = 0;
  bool isDirectory = false;
  // bool isBinary = false;
  bool isExpanded = false;

  // bool canLoadMore = false;

  double height = 0;
  int duration = 0;

  ExplorerItem? parent;
  List<ExplorerItem?> children = [];
  dynamic data;
  dynamic extraData;

  factory ExplorerItem.fromFileNode(FileNode node, {int depth = 0}) {
    final ExplorerItem ret = ExplorerItem(node.path.toFilePath());

    final List<ExplorerItem> children = [];

    ret.depth = depth;
    ret.isDirectory = node.isDirectory;

    for (final c in node.children ?? []) {
      children
          .add(ExplorerItem.fromFileNode(c, depth: depth + 1)..parent = ret);
    }

    children.sort((a, b) {
      if (a.isDirectory != b.isDirectory) {
        return a.isDirectory ? -1 : 1;
      }
      return a.fileName.compareTo(b.fileName);
    });

    ret.children = children;
    if (depth == 0) ret.isExpanded = true;
    return ret;
  }

  List<ExplorerItem?> buildTree() {
    if (isDirectory) {
      for (final ex in folderExclude) {
        if (fullPath.contains(ex)) return [];
      }
    } else {
      String ext = _path.extension(fullPath).toLowerCase();
      for (final ex in fileExclude) {
        if (ext == ex) return [];
      }
    }
    final List<ExplorerItem?> ret = [];
    ret.add(this);
    if (!isExpanded) return ret;
    for (final c in children) {
      ret.addAll(c?.buildTree() ?? []);
    }

    return ret;
  }

  void files(List<ExplorerItem?> items) {
    if (!isDirectory) {
      items.add(this);
    }
    for (final c in children) {
      c?.files(items);
    }
  }

  void dump() {
    String pad = List.generate(depth, (_) => '--').join();
    print(' $pad $fullPath');
    for (final c in children) {
      c?.dump();
    }
  }

  ExplorerItem? itemFromPath(String path, {bool deep = true}) {
    if (path == fullPath) return this;
    for (final c in children) {
      if (path == c?.fullPath) return c;
      if (!deep) continue;
      ExplorerItem? ci = c?.itemFromPath(path);
      if (ci != null) {
        return ci;
      }
    }
    return null;
  }

  ExplorerItem? rootItem() {
    return parent?.rootItem() ?? this;
  }

  bool setData(FileNode node) {
    if (node.children == null || node.children!.isEmpty) return false;

    List<ExplorerItem?> added = [];
    List<ExplorerItem?> removed = [];
    for (final FileNode child in node.children!) {
      final Map<String, dynamic> item = {};
      String path = child.path.toFilePath();
      if (path == '') continue;
      if (path.startsWith('.')) {
        path = _path.join(fullPath, path);
      }
      String base = _path.basename(path);
      if (base.startsWith('.')) continue; // skip

      item['path'] = path;

      String dir = _path.dirname(path);
      if (dir == fullPath && path != fullPath) {
        ExplorerItem? ci = itemFromPath(path, deep: false);
        if (ci == null) {
          ci = ExplorerItem(path);
          ci.depth = depth + 1;
          ci.isDirectory = item['isDirectory'];
          ci.parent = this;
          children.add(ci);
          added.add(ci);
        }
      }
    }

    for (final c in children) {
      bool found = false;
      String cp = c?.fullPath ?? '';
      for (final child in node.children!) {
        String ip = child.path.toFilePath();
        if (cp == ip) {
          found = true;
          break;
        }
      }
      if (!found) {
        removed.add(c);
      }
    }

    for (final c in removed) {
      children.remove(c);
    }

    children.sort((a, b) {
      if (a == null || b == null) return 0;
      if (a.isDirectory != b.isDirectory) {
        return a.isDirectory ? -1 : 1;
      }
      return a.fileName.compareTo(b.fileName);
    });

    return (removed.length + added.length) > 0;
  }

  @override
  String toString() {
    String pad = List.generate(depth, (_) => '   ').join();
    return '$pad${isDirectory ? (isExpanded ? '-' : '+') : ' '} $fileName';
  }
}

class Explorer implements ExplorerListener {
  ExplorerBackend? backend;
  ExplorerItem? root;

  Map<String, Completer> requests = {};

  void _busy() {
    //...setRootPath
  }

  void setBackend(ExplorerBackend? back) {
    backend = back;
    backend?.addListener(this);
    if (back == null) {
      root = null;
    }
  }

  Future<bool> setRootPath(String path) {
    String p = _path.normalize(getCorrectPath(path));
    root = ExplorerItem(p);
    backend?.setRootPath(p);
    return loadPath(p);
  }

  void getWorkingDirectory() {
    backend?.getWorkingDirectory();
  }

  Future<bool> loadPath(String path) {
    String p = _path.normalize(getCorrectPath(path));
    if (isLoading(p)) {
      _busy();
      return Future.value(false);
    }
    backend?.loadPath(path);

    Completer<bool> completer = Completer<bool>();
    requests[p] = completer;
    return completer.future;
  }

  ExplorerItem? itemFromPath(String path) {
    String p = _path.normalize(getCorrectPath(path));
    return root?.itemFromPath(p);
  }

  Future<bool> deleteDirectory(String path, {bool recursive = false}) {
    String p = _path.normalize(getCorrectPath(path));
    if (isLoading(p)) {
      _busy();
      return Future.value(false);
    }
    backend?.deleteDirectory(p, recursive: recursive);
    Completer<bool> completer = Completer<bool>();
    requests[p] = completer;
    return completer.future;
  }

  Future<bool> deleteFile(String path) {
    String p = _path.normalize(getCorrectPath(path));
    if (isLoading(p)) {
      _busy();
      return Future.value(false);
    }
    backend?.deleteFile(p);
    Completer<bool> completer = Completer<bool>();
    requests[p] = completer;
    return completer.future;
  }

  Future<bool> renameDirectory(String path, String newPath) {
    String p = _path.normalize(getCorrectPath(path));
    String np = _path.normalize(getCorrectPath(newPath));
    if (isLoading(p)) {
      _busy();
      return Future.value(false);
    }
    backend?.renameDirectory(p, np);
    Completer<bool> completer = Completer<bool>();
    requests[p] = completer;
    return completer.future;
  }

  Future<bool> renameFile(String path, String newPath) {
    String p = _path.normalize(getCorrectPath(path));
    String np = _path.normalize(getCorrectPath(newPath));
    if (isLoading(p)) {
      _busy();
      return Future.value(false);
    }
    backend?.renameFile(p, np);
    Completer<bool> completer = Completer<bool>();
    requests[p] = completer;
    return completer.future;
  }

  bool isLoading(String path) {
    String p = _path.normalize(getCorrectPath(path));
    return requests.containsKey(p);
  }

  void dump() {
    root?.dump();
  }

  List<ExplorerItem?> tree() {
    return root?.buildTree() ?? [];
  }

  List<ExplorerItem?> files() {
    List<ExplorerItem?> _files = [];
    root?.files(_files);
    return _files;
  }

  // event
  /// Requires json that contains: 'path' and 'items': [{'path' : ... ,
  ///   'isDirectory': ... , 'items': [] }] as a raw string, not a map
  @override
  void onLoad(FileNode node) {
    root = ExplorerItem.fromFileNode(node.convertToRelativePath('.'));
  }

  void onCreate(dynamic item) {}

  void onDelete(dynamic item) {
    dynamic json = jsonDecode(item);
    String p = _path.normalize(getCorrectPath(json['path']));

    ExplorerItem? _item = itemFromPath(p);
    _item?.parent?.children.removeWhere((i) => i == item);

    if (requests.containsKey(p)) {
      requests[p]?.complete(true);
      requests.remove(p);
    }
  }

  void onError(dynamic error) {}

  void search(String fileName) {}

  void setExcludePatterns(
      dynamic _folderExclude, dynamic _fileExclude, dynamic binaryExclude) {
    for (String s in _folderExclude) {
      folderExclude.add(s);
    }
    for (String s in [...binaryExclude, ..._fileExclude]) {
      if (s.indexOf('*.') != -1) {
        s = s.substring(1);
      }
      fileExclude.add(s);
    }
  }

  String getCorrectPath(String path) {
    // Originally, used absolute paths. On Windows, this breaks things with the
    // server, so we use all relative paths
    // print('in getCorrectPath: $path and root path is: ${root?.fullPath}');
    return _path.relative(path, from: root?.fullPath);
  }
}

abstract class ExplorerListener {
  void onLoad(FileNode node);
  void onCreate(dynamic item);
  void onDelete(dynamic item);
  void onError(dynamic error);
}

// isolate?
abstract class ExplorerBackend<T extends RemoteConnection> {
  void updateConnection(T? connection);
  void addListener(ExplorerListener listener);
  void setRootPath(String path);
  void getWorkingDirectory();
  void loadPath(String path);
  void openFile(String path);
  void createDirectory(String path);
  void createFile(String path);
  void deleteDirectory(String path, {bool recursive = false});
  void deleteFile(String path);
  void renameDirectory(String path, String newPath);
  void renameFile(String path, String newPath);
  void search(String fileName);
  // void preload();
}
