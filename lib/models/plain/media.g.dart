// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shows _$MediaFromJson(Map<String, dynamic> json) => Shows(
      title: json['Title'] as String?,
      year: json['Year'] as String?,
      imdbID: json['imdbID'] as String?,
      type: $enumDecodeNullable(_$MediaTypeEnumMap, json['Type']),
      poster: json['Poster'] as String?,
    );

Map<String, dynamic> _$MediaToJson(Shows instance) => <String, dynamic>{
      'Title': instance.title,
      'Year': instance.year,
      'imdbID': instance.imdbID,
      'Type': _$MediaTypeEnumMap[instance.type],
      'Poster': instance.poster,
    };

const _$MediaTypeEnumMap = {
  MediaType.movie: 'movie',
  MediaType.series: 'series',
  MediaType.music: 'music',
};
