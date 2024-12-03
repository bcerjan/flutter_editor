import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
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
  final bool
      isExpanded; // Added this to mark if a directory is expanded in our viewer -- not in the orignal Rust code

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
    return 'FileNode with path: ${path.toFilePath()}, isDir: $isDirectory';
  }

  /// Convert to format expected by filesystem classes:
  String toFSJSON() {
    return json.encode({
      'path': path.toFilePath(),
      'isDirectory': isDirectory,
      'items': children?.map((i) => i.toFSJSON()).toList() ?? [],
    });
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

  /// Returns positive value for any node that has at least a partial path match
  /// higher values indicate more path segments that match
  static FileNode? updateSubTree(
      {required FileNode parent, required FileNode child}) {
    if (!child.path.pathSegments.contains(parent.path.pathSegments.last)) {
      return null;
    }

    if (parent.children == null || parent.children!.isEmpty) {
      // TODO: check if this fails for subdirectories with identical names as
      // their parent
      final List<String> needed = child.path.pathSegments
          .toSet()
          .difference(parent.path.pathSegments.toSet())
          .toList();
      return createSubPath(
          segments: needed, basePath: parent.path.toFilePath());
    }

    // We updated this node
    if (parent.path == child.path) {
      return child;
    }

    FileNode? ret;
    for (final p in parent.children!) {
      ret = updateSubTree(parent: p, child: child);
      if (ret != null) {
        return ret;
      }
    }

    // Maybe throw an error here?
    return null;
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

  final Set<String> initSegments = Set<String>.from(init.path.pathSegments);
  final List<String> childSegments = List<String>.from(child.path.pathSegments);
  final List<String> needed = [];

  for (final seg in childSegments) {
    if (initSegments.add(seg)) {
      needed.add(seg);
    }
  }

  // Parent has no children, so we need to make a whole tree below where we are
  if (init.children == null || init.children!.isEmpty) {
    return init.copyWith(children: [
      FileNode.createSubPath(
        segments: needed,
        basePath: init.path.toFilePath(),
      )
    ]);
  }

  // child is (hopefully) somewhere in the tree of children of this parent:

  final ret = FileNode.updateSubTree(parent: init, child: child);

  if (ret == null) {
    throw const FileNodeUpdateException(
        'Could not place / update new node in tree');
  }

  return ret;
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
