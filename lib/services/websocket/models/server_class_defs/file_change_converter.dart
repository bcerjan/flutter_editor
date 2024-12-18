import 'package:editor/services/websocket/models/lsp_autogenerated/language_server_protocol/lib/protocol_generated.dart';

FileChangeType convert(String text) {
  if (text == 'Modified') {
    return FileChangeType.Changed;
  } else if (text == 'Deleted') {
    return FileChangeType.Deleted;
  } else if (text == 'Created') {
    return FileChangeType.Created;
  }
  throw Exception('Unkown FileChangeType: $text');
}
