import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:path/path.dart' as _path;
import 'package:flutter/foundation.dart';
import './comm_exceptions.dart';

part 'file_node.mapper.dart';

/*
Def from directory_manager.rs
pub struct FileNode {
    pub name: String,
    pub path: PathBuf,
    pub is_directory: bool,
    pub size: u64,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub children: Option<Vec<FileNode>>,
    pub is_loaded: bool,
}
*/
@MappableClass(
    includeCustomMappers: [UriMapper()], caseStyle: CaseStyle.snakeCase)
class FileNode with FileNodeMappable {
  const FileNode({
    required this.name,
    required this.path,
    required this.isDirectory,
    required this.size,
    this.children,
    required this.isLoaded,
    this.isExpanded = false,
  });
  final String name;
  final Uri path;
  final bool isDirectory;
  final int size;
  final List<FileNode>? children;
  final bool isLoaded;
  // Added this to mark if a directory is expanded in our viewer -- not in the orignal Rust code
  final bool isExpanded;

  // This json has the format: {path: /path/, content: [ {FileNode(s)} ]}
  factory FileNode.fromServer({required Map<String, dynamic> json}) {
    return FileNodeMapper.fromMap(json);
  }

  /// This assumes we get back the root directory from the server
  factory FileNode.fromServerDirectory(
      {required String rootPath, required List<dynamic> jsonList}) {
    final rootUri = Uri.file(rootPath);
    final List<FileNode> children = [];
    for (final json in jsonList) {
      children.add(FileNode.fromServer(json: json as Map<String, dynamic>));
    }
    return FileNode(
      name: rootUri.pathSegments.last,
      path: rootUri,
      isDirectory: true,
      size: 0,
      isLoaded: true,
      children: children,
    );
  }

  @override
  String toString() {
    return 'FileNode with path: ${path.toFilePath()}, isDir: $isDirectory, isExpanded: $isExpanded';
  }

  /// Convert to format expected by filesystem classes:
  String toFSJSON() {
    return json.encode({
      'path': path.toFilePath(),
      'isDirectory': isDirectory,
      'items': children?.map((i) => i.toFSJSON()).toList() ?? [],
    });
  }

  /// Converts the path of this node and all children to be relative to the
  /// provided path
  FileNode convertToRelativePath(String root) {
    final List<FileNode> children = [];
    for (final c in this.children ?? []) {
      children.add(c.convertToRelativePath(root));
    }
    return copyWith(
      children: children,
      path: _path.toUri(_path.relative(path.toFilePath(), from: root)),
    );
  }

  /// Attempts to (re)populate the tree at the appropriate child node down the
  /// tree from wherever this method was called. To do a full-tree rewrite, make
  /// sure this method is called on the root node.
  Future<FileNode> populate({required FileNode child}) async {
    return compute(updateNodeTree, [this, child]);
  }

  static FileNode createSubPath(
      {required List<String> segments, String? basePath}) {
    return FileNode(
        name: segments[0],
        path: Uri.parse((basePath ?? '') + segments.join()),
        isDirectory: segments.length > 1,
        size: -1,
        isLoaded: false,
        children: [
          createSubPath(segments: segments.sublist(1), basePath: basePath),
        ]);
  }

  /// Returns true if child should be in this node's children (as in, it is a
  /// child of this node). Will return false if the child is a child somewhere
  /// down the tree.
  bool immediateChild({required FileNode child}) {
    return path == Uri.file(_path.dirname(child.path.toFilePath()));
  }

  /// Returns true if this node has the child somewhere in its descendants
  bool ancestorOfChild({required FileNode child}) {
    final List<String> initSegments = List<String>.from(path.pathSegments);
    final List<String> childSegments =
        List<String>.from(child.path.pathSegments);

    final int initSegNum = initSegments.length;
    final subList = childSegments.sublist(0, initSegNum - 1);
    if (subList == initSegments) {
      return true;
    }
    return false;
  }

  /// Returns the index of the child if it's already in our list, or -1 if it
  /// isn't there yet.
  int childIndex({required FileNode child}) {
    return children?.indexWhere((c) => c.path == child.path) ?? -1;
  }

  FileNode insertSubNode({required FileNode child}) {
    // If we are at the correct location already, insert
    if (immediateChild(child: child)) {
      final int idx = childIndex(child: child);
      final updated = List<FileNode>.from(children ?? []);
      if (idx >= 0) {
        // Replace with new child, preserve if it is expanded (or not)
        // child.isExpanded = children![idx].isExpanded;
        if (child.isDirectory) {
          print(child.isExpanded);
          print(children![idx].isExpanded);
        }

        updated.replaceRange(idx, idx + 1, [child]);
        return copyWith(children: updated);
      } else {
        updated.add(child);
        return copyWith(children: updated);
      }
    }

    // Else, we need to go down one level:
    for (final c in children ?? []) {
      if (c.ancestorOfChild(child: child)) {
        return c.insertSubNode(child: child);
      }
    }

    throw const FileNodeUpdateException('Could not place node in tree');
  }
}

class UriMapper extends SimpleMapper<Uri> {
  const UriMapper();

  @override
  Uri decode(Object value) {
    return Uri.file(value as String);
  }

  @override
  Object? encode(Uri self) {
    return self.path;
  }
}

/// As this is passed to a compute function, we are only allowed a single input
/// therefore, we assume that the current tree is input[0] and the new/updated
/// child is input[1] (and that it is in fact a child of a node somewhere
/// already present in the tree or is at the root for a new tree)
/// TODO: If we always get a 'relative-parent' node this algorithm could be
/// improved to take advantage of that. Need to check.
FileNode updateNodeTree(List<FileNode> input) {
  if (input.length != 2) {
    throw const FileNodeUpdateException('Must have exactly two inputs');
  }

  final FileNode init = input[0];
  final FileNode child = input[1];
  // This is a root location
  if (child.path.pathSegments.length == 1) {
    return child;
  }

  if (child.path == init.path) {
    return child;
  }

  // child is (hopefully) somewhere in the tree of children of this parent:
  return init.insertSubNode(child: child);
}

@MappableClass()
class TreeNodeData with TreeNodeDataMappable {
  const TreeNodeData({
    required this.isDirectory,
    required this.isExpanded,
    required this.isLoaded,
    required this.path,
  });
  final bool isDirectory;
  final bool isExpanded;
  final bool isLoaded;
  final Uri path;

  factory TreeNodeData.fromFileNode({required FileNode node}) {
    return TreeNodeData(
      isDirectory: node.isDirectory,
      isExpanded: node.isExpanded,
      isLoaded: node.isLoaded,
      path: node.path,
    );
  }
}
