// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'search_result_item.dart';

class SearchStatusMapper extends EnumMapper<SearchStatus> {
  SearchStatusMapper._();

  static SearchStatusMapper? _instance;
  static SearchStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SearchStatusMapper._());
    }
    return _instance!;
  }

  static SearchStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SearchStatus decode(dynamic value) {
    switch (value) {
      case 'Started':
        return SearchStatus.started;
      case 'Completed':
        return SearchStatus.completed;
      case 'Error':
        return SearchStatus.error;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SearchStatus self) {
    switch (self) {
      case SearchStatus.started:
        return 'Started';
      case SearchStatus.completed:
        return 'Completed';
      case SearchStatus.error:
        return 'Error';
    }
  }
}

extension SearchStatusMapperExtension on SearchStatus {
  String toValue() {
    SearchStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SearchStatus>(this) as String;
  }
}

class SearchOptionsMapper extends ClassMapperBase<SearchOptions> {
  SearchOptionsMapper._();

  static SearchOptionsMapper? _instance;
  static SearchOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SearchOptionsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SearchOptions';

  static String _$query(SearchOptions v) => v.query;
  static const Field<SearchOptions, String> _f$query = Field('query', _$query);
  static bool _$caseSensitive(SearchOptions v) => v.caseSensitive;
  static const Field<SearchOptions, bool> _f$caseSensitive =
      Field('caseSensitive', _$caseSensitive, key: 'case_sensitive');

  @override
  final MappableFields<SearchOptions> fields = const {
    #query: _f$query,
    #caseSensitive: _f$caseSensitive,
  };

  static SearchOptions _instantiate(DecodingData data) {
    return SearchOptions(
        query: data.dec(_f$query), caseSensitive: data.dec(_f$caseSensitive));
  }

  @override
  final Function instantiate = _instantiate;

  static SearchOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SearchOptions>(map);
  }

  static SearchOptions fromJson(String json) {
    return ensureInitialized().decodeJson<SearchOptions>(json);
  }
}

mixin SearchOptionsMappable {
  String toJson() {
    return SearchOptionsMapper.ensureInitialized()
        .encodeJson<SearchOptions>(this as SearchOptions);
  }

  Map<String, dynamic> toMap() {
    return SearchOptionsMapper.ensureInitialized()
        .encodeMap<SearchOptions>(this as SearchOptions);
  }

  SearchOptionsCopyWith<SearchOptions, SearchOptions, SearchOptions>
      get copyWith => _SearchOptionsCopyWithImpl(
          this as SearchOptions, $identity, $identity);
  @override
  String toString() {
    return SearchOptionsMapper.ensureInitialized()
        .stringifyValue(this as SearchOptions);
  }

  @override
  bool operator ==(Object other) {
    return SearchOptionsMapper.ensureInitialized()
        .equalsValue(this as SearchOptions, other);
  }

  @override
  int get hashCode {
    return SearchOptionsMapper.ensureInitialized()
        .hashValue(this as SearchOptions);
  }
}

extension SearchOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SearchOptions, $Out> {
  SearchOptionsCopyWith<$R, SearchOptions, $Out> get $asSearchOptions =>
      $base.as((v, t, t2) => _SearchOptionsCopyWithImpl(v, t, t2));
}

abstract class SearchOptionsCopyWith<$R, $In extends SearchOptions, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? query, bool? caseSensitive});
  SearchOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SearchOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SearchOptions, $Out>
    implements SearchOptionsCopyWith<$R, SearchOptions, $Out> {
  _SearchOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SearchOptions> $mapper =
      SearchOptionsMapper.ensureInitialized();
  @override
  $R call({String? query, bool? caseSensitive}) => $apply(FieldCopyWithData({
        if (query != null) #query: query,
        if (caseSensitive != null) #caseSensitive: caseSensitive
      }));
  @override
  SearchOptions $make(CopyWithData data) => SearchOptions(
      query: data.get(#query, or: $value.query),
      caseSensitive: data.get(#caseSensitive, or: $value.caseSensitive));

  @override
  SearchOptionsCopyWith<$R2, SearchOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SearchOptionsCopyWithImpl($value, $cast, t);
}

class SearchResultMapper extends ClassMapperBase<SearchResult> {
  SearchResultMapper._();

  static SearchResultMapper? _instance;
  static SearchResultMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SearchResultMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SearchResult';

  static Uri _$filePath(SearchResult v) => v.filePath;
  static const Field<SearchResult, Uri> _f$filePath =
      Field('filePath', _$filePath, key: 'file_path');
  static int _$lineNumber(SearchResult v) => v.lineNumber;
  static const Field<SearchResult, int> _f$lineNumber =
      Field('lineNumber', _$lineNumber, key: 'line_number');
  static String _$lineContent(SearchResult v) => v.lineContent;
  static const Field<SearchResult, String> _f$lineContent =
      Field('lineContent', _$lineContent, key: 'line_content');

  @override
  final MappableFields<SearchResult> fields = const {
    #filePath: _f$filePath,
    #lineNumber: _f$lineNumber,
    #lineContent: _f$lineContent,
  };

  static SearchResult _instantiate(DecodingData data) {
    return SearchResult(
        filePath: data.dec(_f$filePath),
        lineNumber: data.dec(_f$lineNumber),
        lineContent: data.dec(_f$lineContent));
  }

  @override
  final Function instantiate = _instantiate;

  static SearchResult fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SearchResult>(map);
  }

  static SearchResult fromJson(String json) {
    return ensureInitialized().decodeJson<SearchResult>(json);
  }
}

mixin SearchResultMappable {
  String toJson() {
    return SearchResultMapper.ensureInitialized()
        .encodeJson<SearchResult>(this as SearchResult);
  }

  Map<String, dynamic> toMap() {
    return SearchResultMapper.ensureInitialized()
        .encodeMap<SearchResult>(this as SearchResult);
  }

  SearchResultCopyWith<SearchResult, SearchResult, SearchResult> get copyWith =>
      _SearchResultCopyWithImpl(this as SearchResult, $identity, $identity);
  @override
  String toString() {
    return SearchResultMapper.ensureInitialized()
        .stringifyValue(this as SearchResult);
  }

  @override
  bool operator ==(Object other) {
    return SearchResultMapper.ensureInitialized()
        .equalsValue(this as SearchResult, other);
  }

  @override
  int get hashCode {
    return SearchResultMapper.ensureInitialized()
        .hashValue(this as SearchResult);
  }
}

extension SearchResultValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SearchResult, $Out> {
  SearchResultCopyWith<$R, SearchResult, $Out> get $asSearchResult =>
      $base.as((v, t, t2) => _SearchResultCopyWithImpl(v, t, t2));
}

abstract class SearchResultCopyWith<$R, $In extends SearchResult, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Uri? filePath, int? lineNumber, String? lineContent});
  SearchResultCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SearchResultCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SearchResult, $Out>
    implements SearchResultCopyWith<$R, SearchResult, $Out> {
  _SearchResultCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SearchResult> $mapper =
      SearchResultMapper.ensureInitialized();
  @override
  $R call({Uri? filePath, int? lineNumber, String? lineContent}) =>
      $apply(FieldCopyWithData({
        if (filePath != null) #filePath: filePath,
        if (lineNumber != null) #lineNumber: lineNumber,
        if (lineContent != null) #lineContent: lineContent
      }));
  @override
  SearchResult $make(CopyWithData data) => SearchResult(
      filePath: data.get(#filePath, or: $value.filePath),
      lineNumber: data.get(#lineNumber, or: $value.lineNumber),
      lineContent: data.get(#lineContent, or: $value.lineContent));

  @override
  SearchResultCopyWith<$R2, SearchResult, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SearchResultCopyWithImpl($value, $cast, t);
}

class SearchResultItemMapper extends ClassMapperBase<SearchResultItem> {
  SearchResultItemMapper._();

  static SearchResultItemMapper? _instance;
  static SearchResultItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SearchResultItemMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SearchResultItem';

  static String _$path(SearchResultItem v) => v.path;
  static const Field<SearchResultItem, String> _f$path = Field('path', _$path);
  static int _$lineNumber(SearchResultItem v) => v.lineNumber;
  static const Field<SearchResultItem, int> _f$lineNumber =
      Field('lineNumber', _$lineNumber);
  static String _$content(SearchResultItem v) => v.content;
  static const Field<SearchResultItem, String> _f$content =
      Field('content', _$content);

  @override
  final MappableFields<SearchResultItem> fields = const {
    #path: _f$path,
    #lineNumber: _f$lineNumber,
    #content: _f$content,
  };

  static SearchResultItem _instantiate(DecodingData data) {
    return SearchResultItem(
        path: data.dec(_f$path),
        lineNumber: data.dec(_f$lineNumber),
        content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static SearchResultItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SearchResultItem>(map);
  }

  static SearchResultItem fromJson(String json) {
    return ensureInitialized().decodeJson<SearchResultItem>(json);
  }
}

mixin SearchResultItemMappable {
  String toJson() {
    return SearchResultItemMapper.ensureInitialized()
        .encodeJson<SearchResultItem>(this as SearchResultItem);
  }

  Map<String, dynamic> toMap() {
    return SearchResultItemMapper.ensureInitialized()
        .encodeMap<SearchResultItem>(this as SearchResultItem);
  }

  SearchResultItemCopyWith<SearchResultItem, SearchResultItem, SearchResultItem>
      get copyWith => _SearchResultItemCopyWithImpl(
          this as SearchResultItem, $identity, $identity);
  @override
  String toString() {
    return SearchResultItemMapper.ensureInitialized()
        .stringifyValue(this as SearchResultItem);
  }

  @override
  bool operator ==(Object other) {
    return SearchResultItemMapper.ensureInitialized()
        .equalsValue(this as SearchResultItem, other);
  }

  @override
  int get hashCode {
    return SearchResultItemMapper.ensureInitialized()
        .hashValue(this as SearchResultItem);
  }
}

extension SearchResultItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SearchResultItem, $Out> {
  SearchResultItemCopyWith<$R, SearchResultItem, $Out>
      get $asSearchResultItem =>
          $base.as((v, t, t2) => _SearchResultItemCopyWithImpl(v, t, t2));
}

abstract class SearchResultItemCopyWith<$R, $In extends SearchResultItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? path, int? lineNumber, String? content});
  SearchResultItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SearchResultItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SearchResultItem, $Out>
    implements SearchResultItemCopyWith<$R, SearchResultItem, $Out> {
  _SearchResultItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SearchResultItem> $mapper =
      SearchResultItemMapper.ensureInitialized();
  @override
  $R call({String? path, int? lineNumber, String? content}) =>
      $apply(FieldCopyWithData({
        if (path != null) #path: path,
        if (lineNumber != null) #lineNumber: lineNumber,
        if (content != null) #content: content
      }));
  @override
  SearchResultItem $make(CopyWithData data) => SearchResultItem(
      path: data.get(#path, or: $value.path),
      lineNumber: data.get(#lineNumber, or: $value.lineNumber),
      content: data.get(#content, or: $value.content));

  @override
  SearchResultItemCopyWith<$R2, SearchResultItem, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SearchResultItemCopyWithImpl($value, $cast, t);
}
