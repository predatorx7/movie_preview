// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shows _$ShowsFromJson(Map<String, dynamic> json) => Shows(
      title: json['Tite'] as String?,
      year: json['Year'] as int?,
      imdbID: json['imdbID'] as String?,
      type: $enumDecodeNullable(_$MediaTypeEnumMap, json['Type']),
      poster: json['Postr'] as String?,
    );

Map<String, dynamic> _$ShowsToJson(Shows instance) => <String, dynamic>{
      'Tite': instance.title,
      'Year': instance.year,
      'imdbID': instance.imdbID,
      'Type': _$MediaTypeEnumMap[instance.type],
      'Postr': instance.poster,
    };

const _$MediaTypeEnumMap = {
  MediaType.movie: 'movie',
  MediaType.series: 'series',
  MediaType.music: 'music',
};
