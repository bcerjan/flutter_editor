// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'diff_change.dart';

class DiffChangeMapper extends ClassMapperBase<DiffChange> {
  DiffChangeMapper._();

  static DiffChangeMapper? _instance;
  static DiffChangeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DiffChangeMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DiffChange';

  static String _$value(DiffChange v) => v.value;
  static const Field<DiffChange, String> _f$value = Field('value', _$value);
  static bool _$added(DiffChange v) => v.added;
  static const Field<DiffChange, bool> _f$added = Field('added', _$added);
  static bool _$removed(DiffChange v) => v.removed;
  static const Field<DiffChange, bool> _f$removed = Field('removed', _$removed);

  @override
  final MappableFields<DiffChange> fields = const {
    #value: _f$value,
    #added: _f$added,
    #removed: _f$removed,
  };

  static DiffChange _instantiate(DecodingData data) {
    return DiffChange(
        value: data.dec(_f$value),
        added: data.dec(_f$added),
        removed: data.dec(_f$removed));
  }

  @override
  final Function instantiate = _instantiate;

  static DiffChange fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DiffChange>(map);
  }

  static DiffChange fromJson(String json) {
    return ensureInitialized().decodeJson<DiffChange>(json);
  }
}

mixin DiffChangeMappable {
  String toJson() {
    return DiffChangeMapper.ensureInitialized()
        .encodeJson<DiffChange>(this as DiffChange);
  }

  Map<String, dynamic> toMap() {
    return DiffChangeMapper.ensureInitialized()
        .encodeMap<DiffChange>(this as DiffChange);
  }

  DiffChangeCopyWith<DiffChange, DiffChange, DiffChange> get copyWith =>
      _DiffChangeCopyWithImpl(this as DiffChange, $identity, $identity);
  @override
  String toString() {
    return DiffChangeMapper.ensureInitialized()
        .stringifyValue(this as DiffChange);
  }

  @override
  bool operator ==(Object other) {
    return DiffChangeMapper.ensureInitialized()
        .equalsValue(this as DiffChange, other);
  }

  @override
  int get hashCode {
    return DiffChangeMapper.ensureInitialized().hashValue(this as DiffChange);
  }
}

extension DiffChangeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DiffChange, $Out> {
  DiffChangeCopyWith<$R, DiffChange, $Out> get $asDiffChange =>
      $base.as((v, t, t2) => _DiffChangeCopyWithImpl(v, t, t2));
}

abstract class DiffChangeCopyWith<$R, $In extends DiffChange, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? value, bool? added, bool? removed});
  DiffChangeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DiffChangeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DiffChange, $Out>
    implements DiffChangeCopyWith<$R, DiffChange, $Out> {
  _DiffChangeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DiffChange> $mapper =
      DiffChangeMapper.ensureInitialized();
  @override
  $R call({String? value, bool? added, bool? removed}) =>
      $apply(FieldCopyWithData({
        if (value != null) #value: value,
        if (added != null) #added: added,
        if (removed != null) #removed: removed
      }));
  @override
  DiffChange $make(CopyWithData data) => DiffChange(
      value: data.get(#value, or: $value.value),
      added: data.get(#added, or: $value.added),
      removed: data.get(#removed, or: $value.removed));

  @override
  DiffChangeCopyWith<$R2, DiffChange, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DiffChangeCopyWithImpl($value, $cast, t);
}
