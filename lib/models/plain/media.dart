import 'package:json_annotation/json_annotation.dart';
import 'package:string_validator/string_validator.dart';
import 'package:equatable/equatable.dart';

part 'media.g.dart';

enum MediaType { movie, series, music }

@JsonSerializable()
class Shows extends Equatable {
  @JsonKey(name: 'Tite')
  final String? title;
  @JsonKey(name: 'Year')
  final int? year;
  @JsonKey(name: 'imdbID')
  final String? imdbID;
  @JsonKey(name: 'Type')
  final MediaType? type;
  @JsonKey(name: 'Postr')
  final String? poster;

  Shows({
    this.title,
    this.year,
    this.imdbID,
    this.type,
    this.poster,
  })  : assert(title?.isNotEmpty ?? false),
        assert(type != null),
        assert(poster?.isNotEmpty ?? false),
        assert(isURL(poster ?? ''));

  factory Shows.fromJson(Map<String, dynamic> json) => _$ShowsFromJson(json);
  Map<String, dynamic> toJson() => _$ShowsToJson(this);

  @override
  List<Object?> get props => [
        title,
        year,
        imdbID,
        poster,
      ];
}
