import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http show Client;
import 'package:movie_preview/services/show.dart';
import 'package:movie_preview/models/plain/media.dart';

/// A repository that periodically updates data and adds it to a stream
class MediaRepository {
  /// Create a media repository with initial data in [media] empty.
  ///
  /// Initial [media] is empty. [update] must be called to do fetch api calls & update [media]
  MediaRepository._();

  /// Asynchronusly create a media repository & update it's [media].
  static Future<MediaRepository> create(bool update) async {
    final value = MediaRepository._();
    if (update) await value.update();
    return value;
  }

  /// fetches response from api client & creates a list of [Shows].
  static Future<List<Shows>?> fetch([
    http.Client? client,
    Duration? timeoutDuration,
  ]) async {
    final String _response =
        await ShowsService.fetch(client, timeoutDuration);
    final Map<String, dynamic> _responseJson = json.decode(_response);
    final List<dynamic> _mediaMap = _responseJson['Search'] as List<dynamic>;
    final List<Shows> _media = <Shows>[];
    for (final element in _mediaMap) {
      _media.add(Shows.fromJson(element));
    }
    return _media;
  }

  StreamController<List<Shows>>? _controller;
  Timer? _timer;
  List<Shows> _oldDate = [];
  Duration _interval = Duration.zero;

  /// Updates [media] with data fetched from the api client
  Future<void> update() async {
    _fetchDataForStream(null);
  }

  Function eq = const ListEquality().equals;

  Future<void> _fetchDataForStream(_) async {
    final _data = await fetch().catchError((_) {
      _controller?.addError(_);
    });

    if (_data == null) {
      _controller?.addError(Exception('[MediaRepository] Data is null'));
      return;
    }

    if (!eq(_oldDate, _data)) {
      // if old and new lists are not equal
      _oldDate = _data;
      _controller?.add(_oldDate);
    }
  }

  /// Creates a new repeating timer which periodically fetches data
  void startStream() {
    _timer = Timer.periodic(_interval, _fetchDataForStream);
  }

  /// Initializes stream controller.
  void initialize(Duration interval) {
    _interval = interval;
    _controller = StreamController<List<Shows>>(
        onListen: startStream,
        onPause: stopStream,
        onResume: startStream,
        onCancel: dispose);
  }

  /// Pause periodic fetching of data for stream
  void stopStream() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }

  /// Close & dispose resources.
  ///
  /// You must invoke [initialize] to reuse this repository's stream.
  void dispose() {
    stopStream();
    _timer?.cancel();
    _controller?.close();
    _controller = null;
  }

  /// Initializes & returns the stream controller.
  Stream<List<Shows>> getStream(Duration duration) {
    initialize(duration);
    _fetchDataForStream(null);
    return _controller!.stream;
  }

  /// The stream controller responsible for managing streams in this repository
  StreamController<List<Shows>>? get streamController => _controller;
}
