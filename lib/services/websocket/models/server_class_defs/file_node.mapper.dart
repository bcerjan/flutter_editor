// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'file_node.dart';

class FileNodeMapper extends ClassMapperBase<FileNode> {
  FileNodeMapper._();

  static FileNodeMapper? _instance;
  static FileNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FileNodeMapper._());
      MapperContainer.globals.useAll([UriMapper()]);
      FileNodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FileNode';

  static String _$name(FileNode v) => v.name;
  static const Field<FileNode, String> _f$name = Field('name', _$name);
  static Uri _$path(FileNode v) => v.path;
  static const Field<FileNode, Uri> _f$path = Field('path', _$path);
  static bool _$isDirectory(FileNode v) => v.isDirectory;
  static const Field<FileNode, bool> _f$isDirectory =
      Field('isDirectory', _$isDirectory, key: 'is_directory');
  static int _$size(FileNode v) => v.size;
  static const Field<FileNode, int> _f$size = Field('size', _$size);
  static List<FileNode>? _$children(FileNode v) => v.children;
  static const Field<FileNode, List<FileNode>> _f$children =
      Field('children', _$children, opt: true);
  static bool _$isLoaded(FileNode v) => v.isLoaded;
  static const Field<FileNode, bool> _f$isLoaded =
      Field('isLoaded', _$isLoaded, key: 'is_loaded');
  static bool _$isExpanded(FileNode v) => v.isExpanded;
  static const Field<FileNode, bool> _f$isExpanded = Field(
      'isExpanded', _$isExpanded,
      key: 'is_expanded', opt: true, def: false);

  @override
  final MappableFields<FileNode> fields = const {
    #name: _f$name,
    #path: _f$path,
    #isDirectory: _f$isDirectory,
    #size: _f$size,
    #children: _f$children,
    #isLoaded: _f$isLoaded,
    #isExpanded: _f$isExpanded,
  };

  static FileNode _instantiate(DecodingData data) {
    return FileNode(
        name: data.dec(_f$name),
        path: data.dec(_f$path),
        isDirectory: data.dec(_f$isDirectory),
        size: data.dec(_f$size),
        children: data.dec(_f$children),
        isLoaded: data.dec(_f$isLoaded),
        isExpanded: data.dec(_f$isExpanded));
  }

  @override
  final Function instantiate = _instantiate;

  static FileNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FileNode>(map);
  }

  static FileNode fromJson(String json) {
    return ensureInitialized().decodeJson<FileNode>(json);
  }
}

mixin FileNodeMappable {
  String toJson() {
    return FileNodeMapper.ensureInitialized()
        .encodeJson<FileNode>(this as FileNode);
  }

  Map<String, dynamic> toMap() {
    return FileNodeMapper.ensureInitialized()
        .encodeMap<FileNode>(this as FileNode);
  }

  FileNodeCopyWith<FileNode, FileNode, FileNode> get copyWith =>
      _FileNodeCopyWithImpl(this as FileNode, $identity, $identity);
  @override
  String toString() {
    return FileNodeMapper.ensureInitialized().stringifyValue(this as FileNode);
  }

  @override
  bool operator ==(Object other) {
    return FileNodeMapper.ensureInitialized()
        .equalsValue(this as FileNode, other);
  }

  @override
  int get hashCode {
    return FileNodeMapper.ensureInitialized().hashValue(this as FileNode);
  }
}

extension FileNodeValueCopy<$R, $Out> on ObjectCopyWith<$R, FileNode, $Out> {
  FileNodeCopyWith<$R, FileNode, $Out> get $asFileNode =>
      $base.as((v, t, t2) => _FileNodeCopyWithImpl(v, t, t2));
}

abstract class FileNodeCopyWith<$R, $In extends FileNode, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, FileNode, FileNodeCopyWith<$R, FileNode, FileNode>>?
      get children;
  $R call(
      {String? name,
      Uri? path,
      bool? isDirectory,
      int? size,
      List<FileNode>? children,
      bool? isLoaded,
      bool? isExpanded});
  FileNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FileNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FileNode, $Out>
    implements FileNodeCopyWith<$R, FileNode, $Out> {
  _FileNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FileNode> $mapper =
      FileNodeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, FileNode, FileNodeCopyWith<$R, FileNode, FileNode>>?
      get children => $value.children != null
          ? ListCopyWith($value.children!, (v, t) => v.copyWith.$chain(t),
              (v) => call(children: v))
          : null;
  @override
  $R call(
          {String? name,
          Uri? path,
          bool? isDirectory,
          int? size,
          Object? children = $none,
          bool? isLoaded,
          bool? isExpanded}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (path != null) #path: path,
        if (isDirectory != null) #isDirectory: isDirectory,
        if (size != null) #size: size,
        if (children != $none) #children: children,
        if (isLoaded != null) #isLoaded: isLoaded,
        if (isExpanded != null) #isExpanded: isExpanded
      }));
  @override
  FileNode $make(CopyWithData data) => FileNode(
      name: data.get(#name, or: $value.name),
      path: data.get(#path, or: $value.path),
      isDirectory: data.get(#isDirectory, or: $value.isDirectory),
      size: data.get(#size, or: $value.size),
      children: data.get(#children, or: $value.children),
      isLoaded: data.get(#isLoaded, or: $value.isLoaded),
      isExpanded: data.get(#isExpanded, or: $value.isExpanded));

  @override
  FileNodeCopyWith<$R2, FileNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FileNodeCopyWithImpl($value, $cast, t);
}

class TreeNodeDataMapper extends ClassMapperBase<TreeNodeData> {
  TreeNodeDataMapper._();

  static TreeNodeDataMapper? _instance;
  static TreeNodeDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TreeNodeDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TreeNodeData';

  static bool _$isDirectory(TreeNodeData v) => v.isDirectory;
  static const Field<TreeNodeData, bool> _f$isDirectory =
      Field('isDirectory', _$isDirectory);
  static bool _$isExpanded(TreeNodeData v) => v.isExpanded;
  static const Field<TreeNodeData, bool> _f$isExpanded =
      Field('isExpanded', _$isExpanded);
  static bool _$isLoaded(TreeNodeData v) => v.isLoaded;
  static const Field<TreeNodeData, bool> _f$isLoaded =
      Field('isLoaded', _$isLoaded);
  static Uri _$path(TreeNodeData v) => v.path;
  static const Field<TreeNodeData, Uri> _f$path = Field('path', _$path);

  @override
  final MappableFields<TreeNodeData> fields = const {
    #isDirectory: _f$isDirectory,
    #isExpanded: _f$isExpanded,
    #isLoaded: _f$isLoaded,
    #path: _f$path,
  };

  static TreeNodeData _instantiate(DecodingData data) {
    return TreeNodeData(
        isDirectory: data.dec(_f$isDirectory),
        isExpanded: data.dec(_f$isExpanded),
        isLoaded: data.dec(_f$isLoaded),
        path: data.dec(_f$path));
  }

  @override
  final Function instantiate = _instantiate;

  static TreeNodeData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TreeNodeData>(map);
  }

  static TreeNodeData fromJson(String json) {
    return ensureInitialized().decodeJson<TreeNodeData>(json);
  }
}

mixin TreeNodeDataMappable {
  String toJson() {
    return TreeNodeDataMapper.ensureInitialized()
        .encodeJson<TreeNodeData>(this as TreeNodeData);
  }

  Map<String, dynamic> toMap() {
    return TreeNodeDataMapper.ensureInitialized()
        .encodeMap<TreeNodeData>(this as TreeNodeData);
  }

  TreeNodeDataCopyWith<TreeNodeData, TreeNodeData, TreeNodeData> get copyWith =>
      _TreeNodeDataCopyWithImpl(this as TreeNodeData, $identity, $identity);
  @override
  String toString() {
    return TreeNodeDataMapper.ensureInitialized()
        .stringifyValue(this as TreeNodeData);
  }

  @override
  bool operator ==(Object other) {
    return TreeNodeDataMapper.ensureInitialized()
        .equalsValue(this as TreeNodeData, other);
  }

  @override
  int get hashCode {
    return TreeNodeDataMapper.ensureInitialized()
        .hashValue(this as TreeNodeData);
  }
}

extension TreeNodeDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TreeNodeData, $Out> {
  TreeNodeDataCopyWith<$R, TreeNodeData, $Out> get $asTreeNodeData =>
      $base.as((v, t, t2) => _TreeNodeDataCopyWithImpl(v, t, t2));
}

abstract class TreeNodeDataCopyWith<$R, $In extends TreeNodeData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? isDirectory, bool? isExpanded, bool? isLoaded, Uri? path});
  TreeNodeDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TreeNodeDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TreeNodeData, $Out>
    implements TreeNodeDataCopyWith<$R, TreeNodeData, $Out> {
  _TreeNodeDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TreeNodeData> $mapper =
      TreeNodeDataMapper.ensureInitialized();
  @override
  $R call({bool? isDirectory, bool? isExpanded, bool? isLoaded, Uri? path}) =>
      $apply(FieldCopyWithData({
        if (isDirectory != null) #isDirectory: isDirectory,
        if (isExpanded != null) #isExpanded: isExpanded,
        if (isLoaded != null) #isLoaded: isLoaded,
        if (path != null) #path: path
      }));
  @override
  TreeNodeData $make(CopyWithData data) => TreeNodeData(
      isDirectory: data.get(#isDirectory, or: $value.isDirectory),
      isExpanded: data.get(#isExpanded, or: $value.isExpanded),
      isLoaded: data.get(#isLoaded, or: $value.isLoaded),
      path: data.get(#path, or: $value.path));

  @override
  TreeNodeDataCopyWith<$R2, TreeNodeData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TreeNodeDataCopyWithImpl($value, $cast, t);
}
