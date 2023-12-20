// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tmdb_movies.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TMDBMovies _$TMDBMoviesFromJson(Map<String, dynamic> json) {
  return _TMDBMovies.fromJson(json);
}

/// @nodoc
mixin _$TMDBMovies {
  int get page => throw _privateConstructorUsedError;
  List<TMDBMovie> get results => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_results')
  int get totalResults => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pages')
  int get totalPages => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TMDBMoviesCopyWith<TMDBMovies> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMDBMoviesCopyWith<$Res> {
  factory $TMDBMoviesCopyWith(
          TMDBMovies value, $Res Function(TMDBMovies) then) =
      _$TMDBMoviesCopyWithImpl<$Res, TMDBMovies>;
  @useResult
  $Res call(
      {int page,
      List<TMDBMovie> results,
      @JsonKey(name: 'total_results') int totalResults,
      @JsonKey(name: 'total_pages') int totalPages,
      List<String> errors});
}

/// @nodoc
class _$TMDBMoviesCopyWithImpl<$Res, $Val extends TMDBMovies>
    implements $TMDBMoviesCopyWith<$Res> {
  _$TMDBMoviesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? results = null,
    Object? totalResults = null,
    Object? totalPages = null,
    Object? errors = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<TMDBMovie>,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TMDBMoviesImplCopyWith<$Res>
    implements $TMDBMoviesCopyWith<$Res> {
  factory _$$TMDBMoviesImplCopyWith(
          _$TMDBMoviesImpl value, $Res Function(_$TMDBMoviesImpl) then) =
      __$$TMDBMoviesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int page,
      List<TMDBMovie> results,
      @JsonKey(name: 'total_results') int totalResults,
      @JsonKey(name: 'total_pages') int totalPages,
      List<String> errors});
}

/// @nodoc
class __$$TMDBMoviesImplCopyWithImpl<$Res>
    extends _$TMDBMoviesCopyWithImpl<$Res, _$TMDBMoviesImpl>
    implements _$$TMDBMoviesImplCopyWith<$Res> {
  __$$TMDBMoviesImplCopyWithImpl(
      _$TMDBMoviesImpl _value, $Res Function(_$TMDBMoviesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? results = null,
    Object? totalResults = null,
    Object? totalPages = null,
    Object? errors = null,
  }) {
    return _then(_$TMDBMoviesImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<TMDBMovie>,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TMDBMoviesImpl implements _TMDBMovies {
  _$TMDBMoviesImpl(
      {required this.page,
      required final List<TMDBMovie> results,
      @JsonKey(name: 'total_results') required this.totalResults,
      @JsonKey(name: 'total_pages') required this.totalPages,
      final List<String> errors = const []})
      : _results = results,
        _errors = errors;

  factory _$TMDBMoviesImpl.fromJson(Map<String, dynamic> json) =>
      _$$TMDBMoviesImplFromJson(json);

  @override
  final int page;
  final List<TMDBMovie> _results;
  @override
  List<TMDBMovie> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  @JsonKey(name: 'total_results')
  final int totalResults;
  @override
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final List<String> _errors;
  @override
  @JsonKey()
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  String toString() {
    return 'TMDBMovies(page: $page, results: $results, totalResults: $totalResults, totalPages: $totalPages, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TMDBMoviesImpl &&
            (identical(other.page, page) || other.page == page) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      page,
      const DeepCollectionEquality().hash(_results),
      totalResults,
      totalPages,
      const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TMDBMoviesImplCopyWith<_$TMDBMoviesImpl> get copyWith =>
      __$$TMDBMoviesImplCopyWithImpl<_$TMDBMoviesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TMDBMoviesImplToJson(
      this,
    );
  }
}

abstract class _TMDBMovies implements TMDBMovies {
  factory _TMDBMovies(
      {required final int page,
      required final List<TMDBMovie> results,
      @JsonKey(name: 'total_results') required final int totalResults,
      @JsonKey(name: 'total_pages') required final int totalPages,
      final List<String> errors}) = _$TMDBMoviesImpl;

  factory _TMDBMovies.fromJson(Map<String, dynamic> json) =
      _$TMDBMoviesImpl.fromJson;

  @override
  int get page;
  @override
  List<TMDBMovie> get results;
  @override
  @JsonKey(name: 'total_results')
  int get totalResults;
  @override
  @JsonKey(name: 'total_pages')
  int get totalPages;
  @override
  List<String> get errors;
  @override
  @JsonKey(ignore: true)
  _$$TMDBMoviesImplCopyWith<_$TMDBMoviesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
