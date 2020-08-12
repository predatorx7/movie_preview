import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_preview/models/plain/media.dart';

import '../err_utils.dart';

void mediaJsonTest() {
  final Media media = Media(
    title: 'Teen Titans GO! to the Movies',
    year: '2018',
    imdbID: 'tt7424200',
    type: MediaType.movie,
    poster:
        'https://m.media-amazon.com/images/M/MV5BOTZhMTIwZDUtYjZjZS00MmViLTg3NzEtNWE5NzI1NDUwNDJmXkEyXkFqcGdeQXVyODQxMTI4MjM@._V1_SX300.jpg',
  );

  final mediaJson = encodeToString(media);

  final otherMedia =
      Media.fromJson(json.decode(mediaJson) as Map<String, dynamic>);

  test('for Media', () {
    expect(otherMedia.imdbID, media.imdbID);
    expect(otherMedia.title, media.title);
    expect(otherMedia.year, media.year);
    expect(otherMedia.type, media.type);
    expect(otherMedia.poster, media.poster);

    expect(encodeToString(otherMedia), equals(mediaJson));

    expect(() {
      Media();
    }, throwsAssertionError);

    expect(() {
      Media _ = Media(
          title: 'Teen Titans GO! to the Movies',
          year: '2018',
          imdbID: 'tt7424200',
          type: MediaType.movie,
          poster: 'invalid-html');
    }, throwsAssertionError);
  });
  test('equality of Media objects', () {
    final Media anotherMedia = Media(
      title: 'Some movie',
      year: '2019',
      imdbID: 'tt7424201',
      type: MediaType.movie,
      poster:
          'https://m.media-amazon.com/images/M/MV5BOTZhMTIwZDUtYjZjZS00MmViLTg3NzEtNWE5NzI1NDUwNDJmXkEyXkFqcGdeQXVyODQxMTI4MjM@._V1_SX300.jpg',
    );
    expect(media == otherMedia, true);
    expect(media != anotherMedia, true);

    final List<Media> mediaList = <Media>[media, otherMedia];
    final List<Media> otherList = <Media>[media, otherMedia];
    final List<Media> anotherList = <Media>[media, anotherMedia];

    Function eq = const ListEquality().equals;

    expect(eq(mediaList, otherList), true);
    expect(eq(mediaList, anotherList), false);
  });
}
