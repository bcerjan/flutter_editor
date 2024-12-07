import 'package:dart_mappable/dart_mappable.dart';

part 'document_metadata.mapper.dart';
/*
#[derive(Debug, Serialize, Deserialize, Clone)]
pub enum FileType {
    Text,
    Binary,
    SymLink,
    Unknown,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct FileEncoding {
    pub encoding: String,
    pub confidence: f32,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub enum LineEnding {
    CRLF,
    LF,
    Mixed,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct DocumentMetadata {
    pub size: u64,
    pub is_directory: bool,
    pub is_symlink: bool,
    pub created_at: Option<u64>,
    pub modified_at: Option<u64>,
    pub readonly: bool,
    pub file_type: FileType,
    pub encoding: FileEncoding,
    pub line_ending: LineEnding,
}
*/

@MappableEnum(caseStyle: CaseStyle.pascalCase)
enum FileType {
  text,
  binary,
  symlink,
  unknown,
}

@MappableClass()
class FileEncoding with FileEncodingMappable {
  const FileEncoding({
    required this.encoding,
    required this.confidence,
  });
  final String encoding;
  final double confidence;
}

//TODO: Check what LineEnding.mixed should return...
@MappableEnum()
enum LineEnding {
  @MappableValue('CRLF')
  crlf,
  @MappableValue('LR')
  lf,
  @MappableValue('Mixed')
  mixed;

  String getStringEnding() {
    switch (this) {
      case LineEnding.crlf:
        return '\r\n';
      case LineEnding.lf:
        return '\n';
      case LineEnding.mixed:
        // Bad???
        return '\n';
    }
  }
}

@MappableClass(caseStyle: CaseStyle.snakeCase)
class DocumentMetadata with DocumentMetadataMappable {
  const DocumentMetadata({
    required this.size,
    required this.isDirectory,
    required this.isSymlink,
    this.createdAt,
    this.modifiedAt,
    required this.readonly,
    required this.fileType,
    required this.encoding,
    required this.lineEnding,
  });
  // could be too small potentially as it is signed here and not above
  final int size;
  final bool isDirectory;
  final bool isSymlink;
  final int? createdAt;
  final int? modifiedAt;
  final bool readonly;
  final FileType fileType;
  final FileEncoding encoding;
  final LineEnding lineEnding;

  const DocumentMetadata.getDefault()
      : size = -1,
        isDirectory = false,
        isSymlink = false,
        readonly = false,
        fileType = FileType.unknown,
        encoding = const FileEncoding(encoding: '', confidence: 0),
        lineEnding = LineEnding.lf,
        createdAt = null,
        modifiedAt = null;
}
