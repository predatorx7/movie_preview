import 'package:flutter/widgets.dart';
import 'package:movie_preview/models/plain/media.dart';
import 'package:movie_preview/models/repository/media.dart';

class ShowsProvider extends ValueNotifier<List<Shows>?> {
  MediaRepository? _repository;

  List<Shows>? get data => value;

  List<Shows>? get newMedia => data;
  List<Shows>? get popularMedia => data;
  List<Shows>? get trendingMedia => data;

  /// Provides media from the repository.
  ///
  /// You can use [refresh] to let users
  /// manually update data. For example, in  button widget's onPressed callback.
  ///
  /// This listens periodically for updates in data via streams from [MediaRepository] and
  /// notifies listeners if the data is new.
  ShowsProvider() : super(null) {
    _init();
  }

  Future<void> _init() async {
    _repository = await MediaRepository.create(false);
    _repository
        ?.getStream(const Duration(seconds: 30))
        .listen(_updateOnData, onError: _onErrorStream);
  }

  @override
  void dispose() {
    super.dispose();
    _repository?.dispose();
  }

  /// Asynchronously update data & notify listeners
  Future<void> refresh() async {
    await _repository?.update();
  }

  void Function()? _onDataCallback;
  void Function(dynamic _)? _onErrorCallback;

  /// Will be called if the latest recieved stream has data.
  void onData(void Function() callback) {
    _onDataCallback = callback;
  }

  /// Will be called if stream has an error.
  void onError(void Function(dynamic _) callback) {
    _onErrorCallback = callback;
  }

  void _onErrorStream(dynamic _) {
    if (_onErrorCallback != null) _onErrorCallback!(_);
  }

  /// Updates state on stream data
  void _updateOnData(List<Shows> data) {
    if (_onDataCallback != null) {
      _onDataCallback!();
    }
    value = data;
    notifyListeners();
  }
}
