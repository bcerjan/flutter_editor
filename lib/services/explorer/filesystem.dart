import 'dart:convert';
import 'dart:async';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:editor/layout/explorer.dart';
import 'package:editor/main.dart';
import 'package:editor/services/util.dart';
import 'package:editor/services/websocket/models/server_class_defs/file_node.dart';
import 'package:editor/services/websocket/remote_connection.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as _path;

part 'filesystem.mapper.dart';

List<String> folderExclude = [];
List<String> fileExclude = [];

@MappableClass()
class ExplorerItem with ExplorerItemMappable {
  ExplorerItem({
    required this.path,
    this.isDirectory = false,
    this.isExpanded = false,
    this.isLoaded = false,
    this.depth = 0,
    this.children,
  }) : name = _path.basename(path.toFilePath());

  List<ExplorerItem>? children;
  bool isDirectory = false;
  bool isExpanded = false;
  bool isLoaded = false;

  Uri path;
  String name = '';
  String tempPath = '';
  String iconPath = '';

  int depth = 0;
  double height = 0;
  int duration = 0;

  ExplorerItem? parent;
  // List<ExplorerItem?> expChildren = [];
  dynamic data;
  dynamic extraData;

  factory ExplorerItem.fromFileNode(FileNode node, {int depth = 0}) {
    final ExplorerItem ret = ExplorerItem(
      path: node.path,
      isDirectory: node.isDirectory,
      isLoaded: node.isLoaded,
      isExpanded: node.isExpanded,
      depth: depth,
    );

    ret.setChildren(node.children, depth: depth + 1);
    ret.children?.sort((a, b) => compareTo(a, b));
    ret.children?.map((e) => e.parent = ret);

    return ret;
  }

  static int compareTo(ExplorerItem a, ExplorerItem b) {
    if (a.isDirectory != b.isDirectory) {
      return a.isDirectory ? -1 : 1;
    }
    return a.name.compareTo(b.name);
  }

  void setChildren(List<FileNode>? list, {int depth = 0}) {
    children?.clear();
    children = [];
    for (final l in list ?? []) {
      children?.add(ExplorerItem.fromFileNode(l, depth: depth));
    }
    children?.sort((a, b) => compareTo(a, b));
  }

  /// Returns the index of the child if it's already in our list, or -1 if it
  /// isn't there yet.
  int childIndex({required Uri childPath}) {
    return children?.indexWhere((c) => c.path == childPath) ?? -1;
  }

  /// Returns the root node with it's children updated
  ExplorerItem recursiveUpdate(FileNode node) {
    if (node.path == path) {
      final ret = ExplorerItem.fromFileNode(node);
      ret.isExpanded = isExpanded;
      return ret;
    }

    final List<ExplorerItem> ret = List<ExplorerItem>.from(children ?? []);
    if (path.immediateChild(child: node.path)) {
      final idx = childIndex(childPath: node.path);
      if (idx < 0) {
        // Add this entry if new
        ret.add(ExplorerItem.fromFileNode(node, depth: depth + 1));
      } else {
        final rep = ExplorerItem.fromFileNode(node, depth: depth + 1);
        rep.isExpanded = children![idx].isExpanded;
        ret.replaceRange(idx, idx + 1, [rep]);
      }
      return copyWith(children: ret);
    }

    for (final c in children?.where((e) => e.isDirectory) ?? <ExplorerItem>[]) {
      if (c.path.ancestorOfChild(child: node.path)) {
        final rep = c.recursiveUpdate(node);
        final idx = childIndex(childPath: rep.path);
        ret.replaceRange(idx, idx + 1, [rep]);
        return copyWith(children: ret);
      }
    }

    throw Exception(
        'Node is not a descendant of this tree and could not be added');
  }

  /// Updates tree preserving status where appropriate.
  Future<ExplorerItem> update(FileNode updated) async {
    // final merged = await populate(child: updated);

    return compute<FileNode, ExplorerItem>(recursiveUpdate, updated);
  }

  List<ExplorerItem?> buildTree() {
    if (isDirectory) {
      for (final ex in folderExclude) {
        if (path.path.contains(ex)) return [];
      }
    } else {
      String ext = _path.extension(path.path).toLowerCase();
      for (final ex in fileExclude) {
        if (ext == ex) return [];
      }
    }
    final List<ExplorerItem?> ret = [];
    ret.add(this);
    if (!isExpanded) return ret;
    for (final c in children ?? <ExplorerItem>[]) {
      ret.addAll((c).buildTree());
    }

    return ret;
  }

  void files(List<ExplorerItem?> items) {
    if (!isDirectory) {
      items.add(this);
    }
    for (final c in children ?? <ExplorerItem>[]) {
      c.files(items);
    }
  }

  void dump() {
    String pad = List.generate(depth, (_) => '--').join();
    print(' $pad ${path.path}');
    for (final c in children ?? <ExplorerItem>[]) {
      c.dump();
    }
  }

  // ExplorerItem? itemFromPath(String path, {bool deep = true}) {
  //   if (path == fullPath) return this;
  //   for (final c in expChildren) {
  //     if (path == c?.fullPath) return c;
  //     if (!deep) continue;
  //     ExplorerItem? ci = c?.itemFromPath(path);
  //     if (ci != null) {
  //       return ci;
  //     }
  //   }
  //   return null;
  // }

  ExplorerItem? rootItem() {
    return parent?.rootItem() ?? this;
  }

  @override
  String toString() {
    String pad = List.generate(depth, (_) => '   ').join();
    return '$pad${isDirectory ? (isExpanded ? '-' : '+') : ' '} $name';
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

  // Future<bool> setRootPath(String path) {
  //   String p = _path.normalize(getCorrectPath(path));
  //   root = ExplorerItem(p);
  //   backend?.setRootPath(p);
  //   return loadPath(p);
  // }

  void getWorkingDirectory() {
    backend?.getWorkingDirectory();
  }

  Future<bool> loadPath(String path) {
    String p = _path.normalize(getCorrectPath(path));
    if (isLoading(p)) {
      _busy();
      return Future.value(false);
    }
    backend?.loadPath(p);

    Completer<bool> completer = Completer<bool>();
    requests[p] = completer;
    return completer.future;
  }

  // ExplorerItem? itemFromPath(String path) {
  //   String p = _path.normalize(getCorrectPath(path));
  //   return root?.itemFromPath(p);
  // }

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
  void onLoad(FileNode node) async {
    if (root == null) {
      root = ExplorerItem.fromFileNode(node);
    } else {
      final temp = await root?.update(node);
      temp?.children?.sort((a, b) => ExplorerItem.compareTo(a, b));
      root?.children = temp?.children;
    }

    final String p =
        _path.normalize(getCorrectPath(node.path.getRegularPath()));
    if (requests.containsKey(p)) {
      requests[p]?.complete(true);
      requests.remove(p);
    }
  }

  void onCreate(FileNode item) {}

  void onDelete(FileNode item) {
    final String p =
        _path.normalize(getCorrectPath(item.path.getRegularPath()));
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
    return _path.relative(path, from: root?.path.getRegularPath());
  }
}

abstract class ExplorerListener {
  void onLoad(FileNode node);
  void onCreate(FileNode item);
  void onDelete(FileNode item);
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
