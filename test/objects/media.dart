import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_preview/models/plain/media.dart';

import '../err_utils.dart';

void mediaJsonTest() {
  test('for Media', () {
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
}
