import 'dart:async';
import 'dart:convert';
import 'package:movie_preview/api/client.dart';
import 'package:movie_preview/models/plain/media.dart';

class MediaRepository {
  /// Create a media repository with initial data in [media] empty.
  ///
  /// Initial [media] is empty. [update] must be called to do fetch api calls & update [media]
  MediaRepository._();

  /// We use the same api uri, thus to prevent redundant api calls, we cache a singleton instance in this variable
  static MediaRepository _cache;

  /// Async factory method to create a media repository & update it's [media].
  static Future<MediaRepository> create() async {
    if (_cache != null) return _cache;
    _cache = MediaRepository._();
    await _cache.update();
    return _cache;
  }

  List<Media> _media = <Media>[];

  List<Media> get media => _media;

  /// fetches response from api client & creates a list of [Media].
  static Future<List<Media>> fetch() async {
    final String _response = await MediaApiClient.fetch();
    final Map<String, dynamic> _responseJson = json.decode(_response);
    final List<dynamic> _mediaMap = _responseJson['Search'] as List<dynamic>;
    final List<Media> _media = <Media>[];
    _mediaMap.forEach((element) {
      _media.add(Media.fromJson(element));
    });
    return _media;
  }

  StreamController<List<Media>> _controller;
  Timer _timer;
  List<Media> _oldDate;
  Duration _interval;

  /// Updates [media] with data fetched from the api client
  Future<void> update() async {
    _media = await fetch();
  }

  void _fetchDataForStream(_) async {
    final _data = await fetch().catchError((_) {
      _controller.addError(_);
    });
    if (_oldDate != _data) {
      _oldDate = _data;
      _media = _oldDate;
      _controller.add(_oldDate);
    }
  }

  void startStream() {
    _timer = Timer.periodic(_interval, _fetchDataForStream);
  }

  void initialize(Duration interval) {
    _interval = interval;
    _controller = StreamController<List<Media>>(
        onListen: startStream,
        onPause: stopStream,
        onResume: startStream,
        onCancel: dispose);
  }

  void stopStream() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  void dispose() {
    stopStream();
    _timer.cancel();
    _controller.close();
    _controller = null;
  }

  Stream<List<Media>> get stream => _controller.stream;
  StreamController<List<Media>> get streamController => _controller;
}
