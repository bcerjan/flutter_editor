import 'package:dart_mappable/dart_mappable.dart';
import 'package:diff_match_patch/diff_match_patch.dart';

part 'diff_change.mapper.dart';

/*
From what I can tell in the documentation, a single instance of this class
indicates a single insertion or deletion within a given line. So the changes for
an entire line are made up of a list of these. I believe this requires
converting the entire document to a single string, and then computing the diffs.

In the example, they are computed using jsdiff's diffLines function with
newLineIsToken: true


#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct DiffChange {
    pub value: String,
    pub added: bool,
    pub removed: bool,
}
*/

@MappableClass()
class DiffChange with DiffChangeMappable {
  const DiffChange({
    required this.value,
    required this.added,
    required this.removed,
  });
  final String value;
  final bool added;
  final bool removed;

  factory DiffChange.fromDiff({required Diff diff}) {
    final added = diff.operation == DIFF_INSERT;
    final removed = diff.operation == DIFF_DELETE;
    return DiffChange(value: diff.text, added: added, removed: removed);
  }
}
