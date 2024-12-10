// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'filesystem.dart';

class ExplorerItemMapper extends ClassMapperBase<ExplorerItem> {
  ExplorerItemMapper._();

  static ExplorerItemMapper? _instance;
  static ExplorerItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExplorerItemMapper._());
      ExplorerItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ExplorerItem';

  static Uri _$path(ExplorerItem v) => v.path;
  static const Field<ExplorerItem, Uri> _f$path = Field('path', _$path);
  static bool _$isDirectory(ExplorerItem v) => v.isDirectory;
  static const Field<ExplorerItem, bool> _f$isDirectory =
      Field('isDirectory', _$isDirectory, opt: true, def: false);
  static bool _$isExpanded(ExplorerItem v) => v.isExpanded;
  static const Field<ExplorerItem, bool> _f$isExpanded =
      Field('isExpanded', _$isExpanded, opt: true, def: false);
  static bool _$isLoaded(ExplorerItem v) => v.isLoaded;
  static const Field<ExplorerItem, bool> _f$isLoaded =
      Field('isLoaded', _$isLoaded, opt: true, def: false);
  static int _$depth(ExplorerItem v) => v.depth;
  static const Field<ExplorerItem, int> _f$depth =
      Field('depth', _$depth, opt: true, def: 0);
  static List<ExplorerItem>? _$children(ExplorerItem v) => v.children;
  static const Field<ExplorerItem, List<ExplorerItem>> _f$children =
      Field('children', _$children, opt: true, def: const []);
  static String _$name(ExplorerItem v) => v.name;
  static const Field<ExplorerItem, String> _f$name =
      Field('name', _$name, mode: FieldMode.member);
  static String _$tempPath(ExplorerItem v) => v.tempPath;
  static const Field<ExplorerItem, String> _f$tempPath =
      Field('tempPath', _$tempPath, mode: FieldMode.member);
  static String _$iconPath(ExplorerItem v) => v.iconPath;
  static const Field<ExplorerItem, String> _f$iconPath =
      Field('iconPath', _$iconPath, mode: FieldMode.member);
  static double _$height(ExplorerItem v) => v.height;
  static const Field<ExplorerItem, double> _f$height =
      Field('height', _$height, mode: FieldMode.member);
  static int _$duration(ExplorerItem v) => v.duration;
  static const Field<ExplorerItem, int> _f$duration =
      Field('duration', _$duration, mode: FieldMode.member);
  static ExplorerItem? _$parent(ExplorerItem v) => v.parent;
  static const Field<ExplorerItem, ExplorerItem> _f$parent =
      Field('parent', _$parent, mode: FieldMode.member);
  static dynamic _$data(ExplorerItem v) => v.data;
  static const Field<ExplorerItem, dynamic> _f$data =
      Field('data', _$data, mode: FieldMode.member);
  static dynamic _$extraData(ExplorerItem v) => v.extraData;
  static const Field<ExplorerItem, dynamic> _f$extraData =
      Field('extraData', _$extraData, mode: FieldMode.member);

  @override
  final MappableFields<ExplorerItem> fields = const {
    #path: _f$path,
    #isDirectory: _f$isDirectory,
    #isExpanded: _f$isExpanded,
    #isLoaded: _f$isLoaded,
    #depth: _f$depth,
    #children: _f$children,
    #name: _f$name,
    #tempPath: _f$tempPath,
    #iconPath: _f$iconPath,
    #height: _f$height,
    #duration: _f$duration,
    #parent: _f$parent,
    #data: _f$data,
    #extraData: _f$extraData,
  };

  static ExplorerItem _instantiate(DecodingData data) {
    return ExplorerItem(
        path: data.dec(_f$path),
        isDirectory: data.dec(_f$isDirectory),
        isExpanded: data.dec(_f$isExpanded),
        isLoaded: data.dec(_f$isLoaded),
        depth: data.dec(_f$depth),
        children: data.dec(_f$children));
  }

  @override
  final Function instantiate = _instantiate;

  static ExplorerItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ExplorerItem>(map);
  }

  static ExplorerItem fromJson(String json) {
    return ensureInitialized().decodeJson<ExplorerItem>(json);
  }
}

mixin ExplorerItemMappable {
  String toJson() {
    return ExplorerItemMapper.ensureInitialized()
        .encodeJson<ExplorerItem>(this as ExplorerItem);
  }

  Map<String, dynamic> toMap() {
    return ExplorerItemMapper.ensureInitialized()
        .encodeMap<ExplorerItem>(this as ExplorerItem);
  }

  ExplorerItemCopyWith<ExplorerItem, ExplorerItem, ExplorerItem> get copyWith =>
      _ExplorerItemCopyWithImpl(this as ExplorerItem, $identity, $identity);
  @override
  String toString() {
    return ExplorerItemMapper.ensureInitialized()
        .stringifyValue(this as ExplorerItem);
  }

  @override
  bool operator ==(Object other) {
    return ExplorerItemMapper.ensureInitialized()
        .equalsValue(this as ExplorerItem, other);
  }

  @override
  int get hashCode {
    return ExplorerItemMapper.ensureInitialized()
        .hashValue(this as ExplorerItem);
  }
}

extension ExplorerItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ExplorerItem, $Out> {
  ExplorerItemCopyWith<$R, ExplorerItem, $Out> get $asExplorerItem =>
      $base.as((v, t, t2) => _ExplorerItemCopyWithImpl(v, t, t2));
}

abstract class ExplorerItemCopyWith<$R, $In extends ExplorerItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ExplorerItem,
      ExplorerItemCopyWith<$R, ExplorerItem, ExplorerItem>>? get children;
  $R call(
      {Uri? path,
      bool? isDirectory,
      bool? isExpanded,
      bool? isLoaded,
      int? depth,
      List<ExplorerItem>? children});
  ExplorerItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ExplorerItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ExplorerItem, $Out>
    implements ExplorerItemCopyWith<$R, ExplorerItem, $Out> {
  _ExplorerItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ExplorerItem> $mapper =
      ExplorerItemMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ExplorerItem,
          ExplorerItemCopyWith<$R, ExplorerItem, ExplorerItem>>?
      get children => $value.children != null
          ? ListCopyWith($value.children!, (v, t) => v.copyWith.$chain(t),
              (v) => call(children: v))
          : null;
  @override
  $R call(
          {Uri? path,
          bool? isDirectory,
          bool? isExpanded,
          bool? isLoaded,
          int? depth,
          Object? children = $none}) =>
      $apply(FieldCopyWithData({
        if (path != null) #path: path,
        if (isDirectory != null) #isDirectory: isDirectory,
        if (isExpanded != null) #isExpanded: isExpanded,
        if (isLoaded != null) #isLoaded: isLoaded,
        if (depth != null) #depth: depth,
        if (children != $none) #children: children
      }));
  @override
  ExplorerItem $make(CopyWithData data) => ExplorerItem(
      path: data.get(#path, or: $value.path),
      isDirectory: data.get(#isDirectory, or: $value.isDirectory),
      isExpanded: data.get(#isExpanded, or: $value.isExpanded),
      isLoaded: data.get(#isLoaded, or: $value.isLoaded),
      depth: data.get(#depth, or: $value.depth),
      children: data.get(#children, or: $value.children));

  @override
  ExplorerItemCopyWith<$R2, ExplorerItem, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ExplorerItemCopyWithImpl($value, $cast, t);
}
