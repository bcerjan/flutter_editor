// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'document_metadata.dart';

class FileTypeMapper extends EnumMapper<FileType> {
  FileTypeMapper._();

  static FileTypeMapper? _instance;
  static FileTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FileTypeMapper._());
    }
    return _instance!;
  }

  static FileType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  FileType decode(dynamic value) {
    switch (value) {
      case 'Text':
        return FileType.text;
      case 'Binary':
        return FileType.binary;
      case 'Symlink':
        return FileType.symlink;
      case 'Unknown':
        return FileType.unknown;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(FileType self) {
    switch (self) {
      case FileType.text:
        return 'Text';
      case FileType.binary:
        return 'Binary';
      case FileType.symlink:
        return 'Symlink';
      case FileType.unknown:
        return 'Unknown';
    }
  }
}

extension FileTypeMapperExtension on FileType {
  String toValue() {
    FileTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<FileType>(this) as String;
  }
}

class LineEndingMapper extends EnumMapper<LineEnding> {
  LineEndingMapper._();

  static LineEndingMapper? _instance;
  static LineEndingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LineEndingMapper._());
    }
    return _instance!;
  }

  static LineEnding fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  LineEnding decode(dynamic value) {
    switch (value) {
      case 'CRLF':
        return LineEnding.crlf;
      case 'LF':
        return LineEnding.lf;
      case 'MIXED':
        return LineEnding.mixed;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(LineEnding self) {
    switch (self) {
      case LineEnding.crlf:
        return 'CRLF';
      case LineEnding.lf:
        return 'LF';
      case LineEnding.mixed:
        return 'MIXED';
    }
  }
}

extension LineEndingMapperExtension on LineEnding {
  String toValue() {
    LineEndingMapper.ensureInitialized();
    return MapperContainer.globals.toValue<LineEnding>(this) as String;
  }
}

class FileEncodingMapper extends ClassMapperBase<FileEncoding> {
  FileEncodingMapper._();

  static FileEncodingMapper? _instance;
  static FileEncodingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FileEncodingMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FileEncoding';

  static String _$encoding(FileEncoding v) => v.encoding;
  static const Field<FileEncoding, String> _f$encoding =
      Field('encoding', _$encoding);
  static double _$confidence(FileEncoding v) => v.confidence;
  static const Field<FileEncoding, double> _f$confidence =
      Field('confidence', _$confidence);

  @override
  final MappableFields<FileEncoding> fields = const {
    #encoding: _f$encoding,
    #confidence: _f$confidence,
  };

  static FileEncoding _instantiate(DecodingData data) {
    return FileEncoding(
        encoding: data.dec(_f$encoding), confidence: data.dec(_f$confidence));
  }

  @override
  final Function instantiate = _instantiate;

  static FileEncoding fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FileEncoding>(map);
  }

  static FileEncoding fromJson(String json) {
    return ensureInitialized().decodeJson<FileEncoding>(json);
  }
}

mixin FileEncodingMappable {
  String toJson() {
    return FileEncodingMapper.ensureInitialized()
        .encodeJson<FileEncoding>(this as FileEncoding);
  }

  Map<String, dynamic> toMap() {
    return FileEncodingMapper.ensureInitialized()
        .encodeMap<FileEncoding>(this as FileEncoding);
  }

  FileEncodingCopyWith<FileEncoding, FileEncoding, FileEncoding> get copyWith =>
      _FileEncodingCopyWithImpl(this as FileEncoding, $identity, $identity);
  @override
  String toString() {
    return FileEncodingMapper.ensureInitialized()
        .stringifyValue(this as FileEncoding);
  }

  @override
  bool operator ==(Object other) {
    return FileEncodingMapper.ensureInitialized()
        .equalsValue(this as FileEncoding, other);
  }

  @override
  int get hashCode {
    return FileEncodingMapper.ensureInitialized()
        .hashValue(this as FileEncoding);
  }
}

extension FileEncodingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FileEncoding, $Out> {
  FileEncodingCopyWith<$R, FileEncoding, $Out> get $asFileEncoding =>
      $base.as((v, t, t2) => _FileEncodingCopyWithImpl(v, t, t2));
}

abstract class FileEncodingCopyWith<$R, $In extends FileEncoding, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? encoding, double? confidence});
  FileEncodingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FileEncodingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FileEncoding, $Out>
    implements FileEncodingCopyWith<$R, FileEncoding, $Out> {
  _FileEncodingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FileEncoding> $mapper =
      FileEncodingMapper.ensureInitialized();
  @override
  $R call({String? encoding, double? confidence}) => $apply(FieldCopyWithData({
        if (encoding != null) #encoding: encoding,
        if (confidence != null) #confidence: confidence
      }));
  @override
  FileEncoding $make(CopyWithData data) => FileEncoding(
      encoding: data.get(#encoding, or: $value.encoding),
      confidence: data.get(#confidence, or: $value.confidence));

  @override
  FileEncodingCopyWith<$R2, FileEncoding, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FileEncodingCopyWithImpl($value, $cast, t);
}

class DocumentMetadataMapper extends ClassMapperBase<DocumentMetadata> {
  DocumentMetadataMapper._();

  static DocumentMetadataMapper? _instance;
  static DocumentMetadataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DocumentMetadataMapper._());
      FileTypeMapper.ensureInitialized();
      FileEncodingMapper.ensureInitialized();
      LineEndingMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DocumentMetadata';

  static int _$size(DocumentMetadata v) => v.size;
  static const Field<DocumentMetadata, int> _f$size = Field('size', _$size);
  static bool _$isDirectory(DocumentMetadata v) => v.isDirectory;
  static const Field<DocumentMetadata, bool> _f$isDirectory =
      Field('isDirectory', _$isDirectory, key: 'is_directory');
  static bool _$isSymlink(DocumentMetadata v) => v.isSymlink;
  static const Field<DocumentMetadata, bool> _f$isSymlink =
      Field('isSymlink', _$isSymlink, key: 'is_symlink');
  static int? _$createdAt(DocumentMetadata v) => v.createdAt;
  static const Field<DocumentMetadata, int> _f$createdAt =
      Field('createdAt', _$createdAt, key: 'created_at', opt: true);
  static int? _$modifiedAt(DocumentMetadata v) => v.modifiedAt;
  static const Field<DocumentMetadata, int> _f$modifiedAt =
      Field('modifiedAt', _$modifiedAt, key: 'modified_at', opt: true);
  static bool _$readonly(DocumentMetadata v) => v.readonly;
  static const Field<DocumentMetadata, bool> _f$readonly =
      Field('readonly', _$readonly);
  static FileType _$fileType(DocumentMetadata v) => v.fileType;
  static const Field<DocumentMetadata, FileType> _f$fileType =
      Field('fileType', _$fileType, key: 'file_type');
  static FileEncoding _$encoding(DocumentMetadata v) => v.encoding;
  static const Field<DocumentMetadata, FileEncoding> _f$encoding =
      Field('encoding', _$encoding);
  static LineEnding _$lineEnding(DocumentMetadata v) => v.lineEnding;
  static const Field<DocumentMetadata, LineEnding> _f$lineEnding =
      Field('lineEnding', _$lineEnding, key: 'line_ending');

  @override
  final MappableFields<DocumentMetadata> fields = const {
    #size: _f$size,
    #isDirectory: _f$isDirectory,
    #isSymlink: _f$isSymlink,
    #createdAt: _f$createdAt,
    #modifiedAt: _f$modifiedAt,
    #readonly: _f$readonly,
    #fileType: _f$fileType,
    #encoding: _f$encoding,
    #lineEnding: _f$lineEnding,
  };

  static DocumentMetadata _instantiate(DecodingData data) {
    return DocumentMetadata(
        size: data.dec(_f$size),
        isDirectory: data.dec(_f$isDirectory),
        isSymlink: data.dec(_f$isSymlink),
        createdAt: data.dec(_f$createdAt),
        modifiedAt: data.dec(_f$modifiedAt),
        readonly: data.dec(_f$readonly),
        fileType: data.dec(_f$fileType),
        encoding: data.dec(_f$encoding),
        lineEnding: data.dec(_f$lineEnding));
  }

  @override
  final Function instantiate = _instantiate;

  static DocumentMetadata fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DocumentMetadata>(map);
  }

  static DocumentMetadata fromJson(String json) {
    return ensureInitialized().decodeJson<DocumentMetadata>(json);
  }
}

mixin DocumentMetadataMappable {
  String toJson() {
    return DocumentMetadataMapper.ensureInitialized()
        .encodeJson<DocumentMetadata>(this as DocumentMetadata);
  }

  Map<String, dynamic> toMap() {
    return DocumentMetadataMapper.ensureInitialized()
        .encodeMap<DocumentMetadata>(this as DocumentMetadata);
  }

  DocumentMetadataCopyWith<DocumentMetadata, DocumentMetadata, DocumentMetadata>
      get copyWith => _DocumentMetadataCopyWithImpl(
          this as DocumentMetadata, $identity, $identity);
  @override
  String toString() {
    return DocumentMetadataMapper.ensureInitialized()
        .stringifyValue(this as DocumentMetadata);
  }

  @override
  bool operator ==(Object other) {
    return DocumentMetadataMapper.ensureInitialized()
        .equalsValue(this as DocumentMetadata, other);
  }

  @override
  int get hashCode {
    return DocumentMetadataMapper.ensureInitialized()
        .hashValue(this as DocumentMetadata);
  }
}

extension DocumentMetadataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DocumentMetadata, $Out> {
  DocumentMetadataCopyWith<$R, DocumentMetadata, $Out>
      get $asDocumentMetadata =>
          $base.as((v, t, t2) => _DocumentMetadataCopyWithImpl(v, t, t2));
}

abstract class DocumentMetadataCopyWith<$R, $In extends DocumentMetadata, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  FileEncodingCopyWith<$R, FileEncoding, FileEncoding> get encoding;
  $R call(
      {int? size,
      bool? isDirectory,
      bool? isSymlink,
      int? createdAt,
      int? modifiedAt,
      bool? readonly,
      FileType? fileType,
      FileEncoding? encoding,
      LineEnding? lineEnding});
  DocumentMetadataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DocumentMetadataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DocumentMetadata, $Out>
    implements DocumentMetadataCopyWith<$R, DocumentMetadata, $Out> {
  _DocumentMetadataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DocumentMetadata> $mapper =
      DocumentMetadataMapper.ensureInitialized();
  @override
  FileEncodingCopyWith<$R, FileEncoding, FileEncoding> get encoding =>
      $value.encoding.copyWith.$chain((v) => call(encoding: v));
  @override
  $R call(
          {int? size,
          bool? isDirectory,
          bool? isSymlink,
          Object? createdAt = $none,
          Object? modifiedAt = $none,
          bool? readonly,
          FileType? fileType,
          FileEncoding? encoding,
          LineEnding? lineEnding}) =>
      $apply(FieldCopyWithData({
        if (size != null) #size: size,
        if (isDirectory != null) #isDirectory: isDirectory,
        if (isSymlink != null) #isSymlink: isSymlink,
        if (createdAt != $none) #createdAt: createdAt,
        if (modifiedAt != $none) #modifiedAt: modifiedAt,
        if (readonly != null) #readonly: readonly,
        if (fileType != null) #fileType: fileType,
        if (encoding != null) #encoding: encoding,
        if (lineEnding != null) #lineEnding: lineEnding
      }));
  @override
  DocumentMetadata $make(CopyWithData data) => DocumentMetadata(
      size: data.get(#size, or: $value.size),
      isDirectory: data.get(#isDirectory, or: $value.isDirectory),
      isSymlink: data.get(#isSymlink, or: $value.isSymlink),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      modifiedAt: data.get(#modifiedAt, or: $value.modifiedAt),
      readonly: data.get(#readonly, or: $value.readonly),
      fileType: data.get(#fileType, or: $value.fileType),
      encoding: data.get(#encoding, or: $value.encoding),
      lineEnding: data.get(#lineEnding, or: $value.lineEnding));

  @override
  DocumentMetadataCopyWith<$R2, DocumentMetadata, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DocumentMetadataCopyWithImpl($value, $cast, t);
}
