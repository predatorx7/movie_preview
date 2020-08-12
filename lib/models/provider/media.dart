import 'package:flutter/widgets.dart';
import 'package:movie_preview/models/plain/media.dart';
import 'package:movie_preview/models/repository/media.dart';

class MediaProvider extends ChangeNotifier {
  MediaRepository _repository;
  bool _hadData = false;

  List<Media> get data => _repository?.media ?? <Media>[];

  /// Provides media from the repository.
  ///
  /// You can use [refresh] to let users
  /// manually update data. For example, in  button widget's onPressed callback.
  ///
  /// This listens periodically for updates in data via streams from [MediaRepository] and
  /// notifies listeners if the data is new.
  MediaProvider() {
    _init();
  }

  Future<void> _init() async {
    _repository = await MediaRepository.create(false);
    _repository
        .getStream(Duration(seconds: 30))
        .listen(_updateOnData, onError: _onErrorStream);
  }

  @override
  void dispose() {
    super.dispose();
    _repository.dispose();
  }

  /// Asynchronously update data & notify listeners
  Future<void> refresh() async {
    await _repository.update();
    notifyListeners();
  }

  void Function() _onDataCallback;
  void Function(dynamic _) _onErrorCallback;

  /// Will be called if the latest recieved stream has data.
  void onData(void Function() callback) {
    _onDataCallback = callback;
  }

  /// Will be called if stream has an error.
  void onError(void Function(dynamic _) callback) {
    _onErrorCallback = callback;
  }

  bool _hadError = false;

  void _onErrorStream(dynamic _) {
    _hadError = true;
    if (_onErrorCallback != null) _onErrorCallback(_);
  }

  /// Updates state on stream data
  void _updateOnData(List<Media> data) {
    final bool _hasData = data != null;
    if (/*!_hadData && */ _hasData && _onDataCallback != null) {
      _onDataCallback();
    }
    _hadData = _hasData;
    _hadError = false;
    notifyListeners();
  }

  List<Media> get newMedia => data;
  List<Media> get popularMedia => data;
  List<Media> get trendingMedia => data;
}
