// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'message_types.dart';

class ClientMessageTypeMapper extends EnumMapper<ClientMessageType> {
  ClientMessageTypeMapper._();

  static ClientMessageTypeMapper? _instance;
  static ClientMessageTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClientMessageTypeMapper._());
    }
    return _instance!;
  }

  static ClientMessageType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ClientMessageType decode(dynamic value) {
    switch (value) {
      case 'OpenFile':
        return ClientMessageType.openFile;
      case 'CloseFile':
        return ClientMessageType.closeFile;
      case 'GetDirectory':
        return ClientMessageType.getDirectory;
      case 'RefreshDirectory':
        return ClientMessageType.refreshDirectory;
      case 'ChangeFile':
        return ClientMessageType.changeFile;
      case 'SaveFile':
        return ClientMessageType.saveFile;
      case 'Completion':
        return ClientMessageType.completion;
      case 'Hover':
        return ClientMessageType.hover;
      case 'Definition':
        return ClientMessageType.definition;
      case 'CreateTerminal':
        return ClientMessageType.createTerminal;
      case 'ResizeTerminal':
        return ClientMessageType.resizeTerminal;
      case 'WriteTerminal':
        return ClientMessageType.writeTerminal;
      case 'CloseTerminal':
        return ClientMessageType.closeTerminal;
      case 'CreateFile':
        return ClientMessageType.createFile;
      case 'DeleteFile':
        return ClientMessageType.deleteFile;
      case 'RenameFile':
        return ClientMessageType.renameFile;
      case 'Search':
        return ClientMessageType.search;
      case 'CancelSearch':
        return ClientMessageType.cancelSearch;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ClientMessageType self) {
    switch (self) {
      case ClientMessageType.openFile:
        return 'OpenFile';
      case ClientMessageType.closeFile:
        return 'CloseFile';
      case ClientMessageType.getDirectory:
        return 'GetDirectory';
      case ClientMessageType.refreshDirectory:
        return 'RefreshDirectory';
      case ClientMessageType.changeFile:
        return 'ChangeFile';
      case ClientMessageType.saveFile:
        return 'SaveFile';
      case ClientMessageType.completion:
        return 'Completion';
      case ClientMessageType.hover:
        return 'Hover';
      case ClientMessageType.definition:
        return 'Definition';
      case ClientMessageType.createTerminal:
        return 'CreateTerminal';
      case ClientMessageType.resizeTerminal:
        return 'ResizeTerminal';
      case ClientMessageType.writeTerminal:
        return 'WriteTerminal';
      case ClientMessageType.closeTerminal:
        return 'CloseTerminal';
      case ClientMessageType.createFile:
        return 'CreateFile';
      case ClientMessageType.deleteFile:
        return 'DeleteFile';
      case ClientMessageType.renameFile:
        return 'RenameFile';
      case ClientMessageType.search:
        return 'Search';
      case ClientMessageType.cancelSearch:
        return 'CancelSearch';
    }
  }
}

extension ClientMessageTypeMapperExtension on ClientMessageType {
  String toValue() {
    ClientMessageTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ClientMessageType>(this) as String;
  }
}

class ServerMessageTypeMapper extends EnumMapper<ServerMessageType> {
  ServerMessageTypeMapper._();

  static ServerMessageTypeMapper? _instance;
  static ServerMessageTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServerMessageTypeMapper._());
    }
    return _instance!;
  }

  static ServerMessageType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ServerMessageType decode(dynamic value) {
    switch (value) {
      case 'DirectoryContent':
        return ServerMessageType.directoryContent;
      case 'DocumentContent':
        return ServerMessageType.documentContent;
      case 'DocumentPreview':
        return ServerMessageType.documentPreview;
      case 'DocumentChunk':
        return ServerMessageType.documentChunk;
      case 'FileSystemEvents':
        return ServerMessageType.fileSystemEvents;
      case 'CompletionResponse':
        return ServerMessageType.completionResponse;
      case 'HoverResponse':
        return ServerMessageType.hoverResponse;
      case 'DefinitionResponse':
        return ServerMessageType.definitionResponse;
      case 'ChangeSuccess':
        return ServerMessageType.changeSuccess;
      case 'SaveSuccess':
        return ServerMessageType.saveSuccess;
      case 'Error':
        return ServerMessageType.error;
      case 'Success':
        return ServerMessageType.success;
      case 'TerminalCreated':
        return ServerMessageType.terminalCreated;
      case 'TerminalOutput':
        return ServerMessageType.terminalOutput;
      case 'TerminalClosed':
        return ServerMessageType.terminalClosed;
      case 'TerminalError':
        return ServerMessageType.terminalError;
      case 'SearchResults':
        return ServerMessageType.searchResults;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ServerMessageType self) {
    switch (self) {
      case ServerMessageType.directoryContent:
        return 'DirectoryContent';
      case ServerMessageType.documentContent:
        return 'DocumentContent';
      case ServerMessageType.documentPreview:
        return 'DocumentPreview';
      case ServerMessageType.documentChunk:
        return 'DocumentChunk';
      case ServerMessageType.fileSystemEvents:
        return 'FileSystemEvents';
      case ServerMessageType.completionResponse:
        return 'CompletionResponse';
      case ServerMessageType.hoverResponse:
        return 'HoverResponse';
      case ServerMessageType.definitionResponse:
        return 'DefinitionResponse';
      case ServerMessageType.changeSuccess:
        return 'ChangeSuccess';
      case ServerMessageType.saveSuccess:
        return 'SaveSuccess';
      case ServerMessageType.error:
        return 'Error';
      case ServerMessageType.success:
        return 'Success';
      case ServerMessageType.terminalCreated:
        return 'TerminalCreated';
      case ServerMessageType.terminalOutput:
        return 'TerminalOutput';
      case ServerMessageType.terminalClosed:
        return 'TerminalClosed';
      case ServerMessageType.terminalError:
        return 'TerminalError';
      case ServerMessageType.searchResults:
        return 'SearchResults';
    }
  }
}

extension ServerMessageTypeMapperExtension on ServerMessageType {
  String toValue() {
    ServerMessageTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ServerMessageType>(this) as String;
  }
}

class ClientMessageMapper extends ClassMapperBase<ClientMessage> {
  ClientMessageMapper._();

  static ClientMessageMapper? _instance;
  static ClientMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClientMessageMapper._());
      ClientMessageTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ClientMessage';

  static ClientMessageType _$type(ClientMessage v) => v.type;
  static const Field<ClientMessage, ClientMessageType> _f$type =
      Field('type', _$type);
  static Map<String, dynamic> _$content(ClientMessage v) => v.content;
  static const Field<ClientMessage, Map<String, dynamic>> _f$content =
      Field('content', _$content);

  @override
  final MappableFields<ClientMessage> fields = const {
    #type: _f$type,
    #content: _f$content,
  };

  static ClientMessage _instantiate(DecodingData data) {
    return ClientMessage(
        type: data.dec(_f$type), content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static ClientMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ClientMessage>(map);
  }

  static ClientMessage fromJson(String json) {
    return ensureInitialized().decodeJson<ClientMessage>(json);
  }
}

mixin ClientMessageMappable {
  String toJson() {
    return ClientMessageMapper.ensureInitialized()
        .encodeJson<ClientMessage>(this as ClientMessage);
  }

  Map<String, dynamic> toMap() {
    return ClientMessageMapper.ensureInitialized()
        .encodeMap<ClientMessage>(this as ClientMessage);
  }

  ClientMessageCopyWith<ClientMessage, ClientMessage, ClientMessage>
      get copyWith => _ClientMessageCopyWithImpl(
          this as ClientMessage, $identity, $identity);
  @override
  String toString() {
    return ClientMessageMapper.ensureInitialized()
        .stringifyValue(this as ClientMessage);
  }

  @override
  bool operator ==(Object other) {
    return ClientMessageMapper.ensureInitialized()
        .equalsValue(this as ClientMessage, other);
  }

  @override
  int get hashCode {
    return ClientMessageMapper.ensureInitialized()
        .hashValue(this as ClientMessage);
  }
}

extension ClientMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ClientMessage, $Out> {
  ClientMessageCopyWith<$R, ClientMessage, $Out> get $asClientMessage =>
      $base.as((v, t, t2) => _ClientMessageCopyWithImpl(v, t, t2));
}

abstract class ClientMessageCopyWith<$R, $In extends ClientMessage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get content;
  $R call({ClientMessageType? type, Map<String, dynamic>? content});
  ClientMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ClientMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ClientMessage, $Out>
    implements ClientMessageCopyWith<$R, ClientMessage, $Out> {
  _ClientMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ClientMessage> $mapper =
      ClientMessageMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get content => MapCopyWith($value.content,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(content: v));
  @override
  $R call({ClientMessageType? type, Map<String, dynamic>? content}) =>
      $apply(FieldCopyWithData({
        if (type != null) #type: type,
        if (content != null) #content: content
      }));
  @override
  ClientMessage $make(CopyWithData data) => ClientMessage(
      type: data.get(#type, or: $value.type),
      content: data.get(#content, or: $value.content));

  @override
  ClientMessageCopyWith<$R2, ClientMessage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ClientMessageCopyWithImpl($value, $cast, t);
}

class ServerMessageMapper extends ClassMapperBase<ServerMessage> {
  ServerMessageMapper._();

  static ServerMessageMapper? _instance;
  static ServerMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServerMessageMapper._());
      ServerMessageTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ServerMessage';

  static ServerMessageType _$type(ServerMessage v) => v.type;
  static const Field<ServerMessage, ServerMessageType> _f$type =
      Field('type', _$type);
  static Map<String, dynamic> _$content(ServerMessage v) => v.content;
  static const Field<ServerMessage, Map<String, dynamic>> _f$content =
      Field('content', _$content);

  @override
  final MappableFields<ServerMessage> fields = const {
    #type: _f$type,
    #content: _f$content,
  };

  static ServerMessage _instantiate(DecodingData data) {
    return ServerMessage(
        type: data.dec(_f$type), content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static ServerMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServerMessage>(map);
  }

  static ServerMessage fromJson(String json) {
    return ensureInitialized().decodeJson<ServerMessage>(json);
  }
}

mixin ServerMessageMappable {
  String toJson() {
    return ServerMessageMapper.ensureInitialized()
        .encodeJson<ServerMessage>(this as ServerMessage);
  }

  Map<String, dynamic> toMap() {
    return ServerMessageMapper.ensureInitialized()
        .encodeMap<ServerMessage>(this as ServerMessage);
  }

  ServerMessageCopyWith<ServerMessage, ServerMessage, ServerMessage>
      get copyWith => _ServerMessageCopyWithImpl(
          this as ServerMessage, $identity, $identity);
  @override
  String toString() {
    return ServerMessageMapper.ensureInitialized()
        .stringifyValue(this as ServerMessage);
  }

  @override
  bool operator ==(Object other) {
    return ServerMessageMapper.ensureInitialized()
        .equalsValue(this as ServerMessage, other);
  }

  @override
  int get hashCode {
    return ServerMessageMapper.ensureInitialized()
        .hashValue(this as ServerMessage);
  }
}

extension ServerMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServerMessage, $Out> {
  ServerMessageCopyWith<$R, ServerMessage, $Out> get $asServerMessage =>
      $base.as((v, t, t2) => _ServerMessageCopyWithImpl(v, t, t2));
}

abstract class ServerMessageCopyWith<$R, $In extends ServerMessage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get content;
  $R call({ServerMessageType? type, Map<String, dynamic>? content});
  ServerMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ServerMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServerMessage, $Out>
    implements ServerMessageCopyWith<$R, ServerMessage, $Out> {
  _ServerMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServerMessage> $mapper =
      ServerMessageMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get content => MapCopyWith($value.content,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(content: v));
  @override
  $R call({ServerMessageType? type, Map<String, dynamic>? content}) =>
      $apply(FieldCopyWithData({
        if (type != null) #type: type,
        if (content != null) #content: content
      }));
  @override
  ServerMessage $make(CopyWithData data) => ServerMessage(
      type: data.get(#type, or: $value.type),
      content: data.get(#content, or: $value.content));

  @override
  ServerMessageCopyWith<$R2, ServerMessage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ServerMessageCopyWithImpl($value, $cast, t);
}
