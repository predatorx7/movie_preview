import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http show Client, Response;
import 'package:mockito/mockito.dart';
import 'package:movie_preview/api/client.dart';
import 'package:movie_preview/models/plain/media.dart';
import 'package:movie_preview/models/repository/media.dart';

const _responseMap = {
  "Search": [
    {
      "Title": "Teen Titans GO! to the Movies",
      "Year": "2018",
      "imdbID": "tt7424200",
      "Type": "movie",
      "Poster":
          "https://m.media-amazon.com/images/M/MV5BOTZhMTIwZDUtYjZjZS00MmViLTg3NzEtNWE5NzI1NDUwNDJmXkEyXkFqcGdeQXVyODQxMTI4MjM@._V1_SX300.jpg"
    },
    {
      "Title": "Home Movies",
      "Year": "1999–2004",
      "imdbID": "tt0197159",
      "Type": "series",
      "Poster":
          "https://m.media-amazon.com/images/M/MV5BZWViOTRmMGUtYWY3ZS00ZTY0LWE1YjktOGY3NDhhNmIyOTk5XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg"
    },
  ]
};

class MockClient extends Mock implements http.Client {
  /// A successful [http.Response]
  Future<http.Response> fetchSuccessful(Invocation _) async {
    final String testValue = json.encode(_responseMap);
    return http.Response(testValue, 200, headers: MediaApiClient.headers);
  }

  /// A successful [http.Response] but delayed
  Future<http.Response> fetchSuccessfulDelayed(
      Invocation _, Duration duration) async {
    await Future.delayed(duration);
    final String testValue = json.encode(_responseMap);
    return http.Response(testValue, 200, headers: MediaApiClient.headers);
  }

  /// An unsuccessful [http.Response] which throws a [HttpException] `Not Found`
  /// Exception with status code `404`
  Future<http.Response> fetchNotFound(Invocation _) async {
    return http.Response('Not Found', 404,
        headers: MediaApiClient.headers,
        reasonPhrase: 'Mock 404 Not Found error');
  }
}

void mediaApiClientTest() {
  MockClient? _mockClient;
  setUpAll(() {
    _mockClient = MockClient();
  });
  tearDownAll(() {
    _mockClient?.close();
    _mockClient = null;
  });
  test('makes successful api calls', () async {
    final _client = _mockClient!;

    // A successful mocked response
    when(_client.get(MediaApiClient.url, headers: MediaApiClient.headers))
        .thenAnswer(_client.fetchSuccessful);
    var x = await MediaRepository.fetch(_client);

    expect(x, isA<List<Media>>());
    expect(x?.isNotEmpty, true);
    expect(x?.length, equals(2));
  });

  test('throws an HttpException if the http call completes with an error',
      () async {
    final _client = _mockClient!;

    // Returns an unsuccessful response
    when(_client.get(MediaApiClient.url, headers: MediaApiClient.headers))
        .thenAnswer(_client.fetchNotFound);

    expect(
        MediaRepository.fetch(_client), throwsA(isInstanceOf<HttpException>()));
  });
  test(
      'throws a TimeoutException if the async http call takes more time then the timeout duration',
      () async {
    final _client = _mockClient!;
    const Duration timeoutDuration = Duration(seconds: 1);
    final Duration delayDuration = timeoutDuration * 2;
    // Returns an successful response but delayed
    when(_client.get(MediaApiClient.url, headers: MediaApiClient.headers))
        .thenAnswer(
      (_) => _client.fetchSuccessfulDelayed(_, delayDuration),
    );
    expect(
      MediaRepository.fetch(_client, timeoutDuration),
      throwsA(isInstanceOf<TimeoutException>()),
    );
  });
}
