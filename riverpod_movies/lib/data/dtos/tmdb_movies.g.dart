// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TMDBMoviesImpl _$$TMDBMoviesImplFromJson(Map<String, dynamic> json) =>
    _$TMDBMoviesImpl(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => TMDBMovie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: json['total_results'] as int,
      totalPages: json['total_pages'] as int,
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TMDBMoviesImplToJson(_$TMDBMoviesImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
      'errors': instance.errors,
    };
