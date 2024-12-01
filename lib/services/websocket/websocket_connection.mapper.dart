// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'websocket_connection.dart';

class WebsocketConnectionMapper extends ClassMapperBase<WebsocketConnection> {
  WebsocketConnectionMapper._();

  static WebsocketConnectionMapper? _instance;
  static WebsocketConnectionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebsocketConnectionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WebsocketConnection';

  static WebSocketChannel? _$channel(WebsocketConnection v) => v.channel;
  static const Field<WebsocketConnection, WebSocketChannel> _f$channel =
      Field('channel', _$channel, mode: FieldMode.member);

  @override
  final MappableFields<WebsocketConnection> fields = const {
    #channel: _f$channel,
  };

  static WebsocketConnection _instantiate(DecodingData data) {
    return WebsocketConnection();
  }

  @override
  final Function instantiate = _instantiate;

  static WebsocketConnection fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebsocketConnection>(map);
  }

  static WebsocketConnection fromJson(String json) {
    return ensureInitialized().decodeJson<WebsocketConnection>(json);
  }
}

mixin WebsocketConnectionMappable {
  String toJson() {
    return WebsocketConnectionMapper.ensureInitialized()
        .encodeJson<WebsocketConnection>(this as WebsocketConnection);
  }

  Map<String, dynamic> toMap() {
    return WebsocketConnectionMapper.ensureInitialized()
        .encodeMap<WebsocketConnection>(this as WebsocketConnection);
  }

  WebsocketConnectionCopyWith<WebsocketConnection, WebsocketConnection,
          WebsocketConnection>
      get copyWith => _WebsocketConnectionCopyWithImpl(
          this as WebsocketConnection, $identity, $identity);
  @override
  String toString() {
    return WebsocketConnectionMapper.ensureInitialized()
        .stringifyValue(this as WebsocketConnection);
  }

  @override
  bool operator ==(Object other) {
    return WebsocketConnectionMapper.ensureInitialized()
        .equalsValue(this as WebsocketConnection, other);
  }

  @override
  int get hashCode {
    return WebsocketConnectionMapper.ensureInitialized()
        .hashValue(this as WebsocketConnection);
  }
}

extension WebsocketConnectionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebsocketConnection, $Out> {
  WebsocketConnectionCopyWith<$R, WebsocketConnection, $Out>
      get $asWebsocketConnection =>
          $base.as((v, t, t2) => _WebsocketConnectionCopyWithImpl(v, t, t2));
}

abstract class WebsocketConnectionCopyWith<$R, $In extends WebsocketConnection,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  WebsocketConnectionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _WebsocketConnectionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebsocketConnection, $Out>
    implements WebsocketConnectionCopyWith<$R, WebsocketConnection, $Out> {
  _WebsocketConnectionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebsocketConnection> $mapper =
      WebsocketConnectionMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  WebsocketConnection $make(CopyWithData data) => WebsocketConnection();

  @override
  WebsocketConnectionCopyWith<$R2, WebsocketConnection, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _WebsocketConnectionCopyWithImpl($value, $cast, t);
}
