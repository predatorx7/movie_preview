import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_preview/models/plain/media.dart';

import '../err_utils.dart';

void mediaJsonTest() {
  final Shows media = Shows(
    title: 'Teen Titans GO! to the Movies',
    year: 2018,
    imdbID: 'tt7424200',
    type: MediaType.movie,
    poster:
        'https://m.media-amazon.com/images/M/MV5BOTZhMTIwZDUtYjZjZS00MmViLTg3NzEtNWE5NzI1NDUwNDJmXkEyXkFqcGdeQXVyODQxMTI4MjM@._V1_SX300.jpg',
  );

  final mediaJson = encodeToString(media);

  final otherMedia =
      Shows.fromJson(json.decode(mediaJson) as Map<String, dynamic>);

  test('for Media', () {
    expect(otherMedia.imdbID, media.imdbID);
    expect(otherMedia.title, media.title);
    expect(otherMedia.year, media.year);
    expect(otherMedia.type, media.type);
    expect(otherMedia.poster, media.poster);

    expect(encodeToString(otherMedia), equals(mediaJson));

    expect(() {
      Shows();
    }, throwsAssertionError);

    expect(() {
      Shows _ = Shows(
          title: 'Teen Titans GO! to the Movies',
          year: 2018,
          imdbID: 'tt7424200',
          type: MediaType.movie,
          poster: 'invalid-html');
    }, throwsAssertionError);
  });
  test('equality of Media objects', () {
    final Shows anotherMedia = Shows(
      title: 'Some movie',
      year: 2019,
      imdbID: 'tt7424201',
      type: MediaType.movie,
      poster:
          'https://m.media-amazon.com/images/M/MV5BOTZhMTIwZDUtYjZjZS00MmViLTg3NzEtNWE5NzI1NDUwNDJmXkEyXkFqcGdeQXVyODQxMTI4MjM@._V1_SX300.jpg',
    );
    expect(media == otherMedia, true);
    expect(media != anotherMedia, true);

    final List<Shows> mediaList = <Shows>[media, otherMedia];
    final List<Shows> otherList = <Shows>[media, otherMedia];
    final List<Shows> anotherList = <Shows>[media, anotherMedia];

    Function eq = const ListEquality().equals;

    expect(eq(mediaList, otherList), true);
    expect(eq(mediaList, anotherList), false);
  });
}
