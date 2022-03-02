import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class ShowsService {
  // This class is not meant to be instantiated.
  ShowsService._();

  /// omdbAPI's GET url
  ///
  /// SAME AS
  /// ```dart
  /// Uri.https(
  ///  'www.omdbapi.com',
  ///  '/',
  ///  {'s': 'Movies', 'apikey': '5661d041'},
  /// );
  /// ```
  static final url = Uri.parse(
    'https://www.omdbapi.com/?s=Movies&apikey=5661d041',
  );

  static const Map<String, String> headers = {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  };

  /// Sends an HTTP GET request to the Restful API [url] and returns the response body.
  static Future<String> fetch([
    http.Client? client,
    Duration? timeoutDuration,
  ]) async {
    DateTime requestTime = DateTime.now();
    print('[MediaApiClient] fetch call requested at $requestTime');
    client ??= http.Client();

    http.Response response;

    try {
      response = await client.get(url, headers: headers).timeout(
            timeoutDuration ?? const Duration(seconds: 10),
          );
      Duration _durationElapsed = DateTime.now().difference(requestTime);
      print('[MediaApiClient] fetch completed in $_durationElapsed');
    } on TimeoutException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to load media $e');
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw HttpException(
        'Failed GET response with status code ${response.statusCode} with reason ${response.reasonPhrase}',
      );
    }
  }
}
