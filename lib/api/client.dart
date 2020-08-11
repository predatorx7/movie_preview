import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class MediaApiClient {
  // This class is not meant to be instantiated.
  MediaApiClient._();

  // omdbAPI url
  static const url = 'http://www.omdbapi.com/?s=Movies&apikey=5661d041';

  static const Map<String, String> headers = {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  };

  /// Sends an HTTP GET request to the Restful API [url] and returns the response body.
  static Future<String> fetch([
    http.Client client,
    Duration timeoutDuration,
  ]) async {
    client ??= http.Client();

    http.Response response;

    try {
      response = await client.get(url, headers: headers).timeout(
            timeoutDuration ?? Duration(seconds: 10),
          );
      client.close();
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
          'Failed GET response with status code ${response.statusCode} with reason ${response.reasonPhrase}');
    }
  }
}
