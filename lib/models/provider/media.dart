import 'package:flutter/widgets.dart';
import 'package:movie_preview/models/plain/media.dart';
import 'package:movie_preview/models/repository/media.dart';

class MediaNotifier extends ChangeNotifier {
  MediaRepository _repository;

  List<Media> get data => _repository?.media ?? <Media>[];

  MediaNotifier() {
    _init();
  }

  void _init() async {
    _repository = await MediaRepository.create();
    _repository.initialize(Duration(seconds: 30));
    _repository.stream.listen(_updateOnData);
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

  /// Updates state on stream data
  void _updateOnData(List<Media> data) {
    notifyListeners();
  }

  List<Media> get newMedia => data;
  List<Media> get popularMedia => data;
  List<Media> get trendingMedia => data;
}
