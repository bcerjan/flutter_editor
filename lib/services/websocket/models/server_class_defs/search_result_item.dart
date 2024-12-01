import 'package:dart_mappable/dart_mappable.dart';

part 'search_result_item.mapper.dart';

/* server defs:

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SearchOptions {
    pub query: String,
    pub case_sensitive: bool,
}

*/

@MappableClass(caseStyle: CaseStyle.snakeCase)
class SearchOptions with SearchOptionsMappable {
  const SearchOptions({
    required this.query,
    required this.caseSensitive,
  });
  final String query;
  final bool caseSensitive;
}

/*
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SearchResult {
    pub file_path: PathBuf,
    pub line_number: u32,
    pub line_content: String,
}
*/

@MappableClass(caseStyle: CaseStyle.snakeCase)
class SearchResult with SearchResultMappable {
  const SearchResult({
    required this.filePath,
    required this.lineNumber,
    required this.lineContent,
  });
  final Uri filePath;
  final int lineNumber;
  final String lineContent;
}

/*
#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum SearchStatus {
    Started,
    Completed,
    Error { message: String },
}
*/

@MappableEnum(caseStyle: CaseStyle.pascalCase)
enum SearchStatus {
  started,
  completed,
  error,
}

/*
Needed?
struct ActiveSearch {
    receiver: mpsc::Receiver<ServerMessage>,
    _task: tokio::task::JoinHandle<()>,
}
*/

/*
#[derive(Clone, Serialize, Deserialize, Debug)]
pub struct SearchResultItem {
    pub path: String,
    pub line_number: u32,
    pub content: String,
}
*/
@MappableClass()
class SearchResultItem with SearchResultItemMappable {
  const SearchResultItem({
    required this.path,
    required this.lineNumber,
    required this.content,
  });
  final String path;
  final int lineNumber;
  final String content;
}
/*
Internal I think?
#[derive(Clone)]
pub enum SearchMessage {
    Results {
        search_id: String,
        items: Vec<SearchResultItem>, // Vec of matching results
        is_complete: bool,  // indicates if this is the final batch
    },
    Error {
        search_id: String,
        error: String,
    },
}

*/

