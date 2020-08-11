import 'package:flutter/widgets.dart';
import 'package:movie_preview/models/plain/media.dart';
import 'package:movie_preview/models/repository/media.dart';

class MediaNotifier extends ChangeNotifier {
  MediaRepository _repository;

  List<Media> _data;

  List<Media> get data => _data;

  MediaNotifier() {
    _init();
  }

  void _init() async {
    _repository = await MediaRepository.create();
    _data = _repository.media;
    _repository.initialize(Duration(seconds: 30));
    _repository.stream.listen(_updateOnData);
  }

  @override
  void dispose() {
    super.dispose();
    _repository.dispose();
    _data = null;
  }

  void refresh() async {
    _repository.update();
    _data = _repository.media;
    notifyListeners();
  }

  void _updateOnData(List<Media> data) {
    _data = data;
    notifyListeners();
  }

  List<Media> get newMedia => data;
  List<Media> get popularMedia => data;
  List<Media> get trendingMedia => data;
}
