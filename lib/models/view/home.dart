import 'package:flutter/widgets.dart';

class HomeView with ChangeNotifier {
  HomeView(int tabIndex, int bottomIndex)
      : _tabIndex = tabIndex,
        _bottomBarIndex = bottomIndex;

  int _tabIndex;

  int get tabIndex => _tabIndex;

  void setTabIndex(int tabIndex) {
    _tabIndex = tabIndex;
    notifyListeners();
  }

  int _bottomBarIndex;

  int get bottomBarIndex => _bottomBarIndex;

  void setBottomBarIndex(int bottomBarIndex) {
    _bottomBarIndex = bottomBarIndex;
    notifyListeners();
  }
}
