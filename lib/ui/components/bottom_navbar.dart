import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_preview/models/view/home.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _homeView = Provider.of<HomeView>(context);
    return BottomNavigationBar(
      currentIndex: _homeView.bottomBarIndex,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      type: BottomNavigationBarType.fixed,
      onTap: (int i) {
        if (i != 3) {
          _homeView.setBottomBarIndex(i);
        } else {
          Scaffold.of(context).openEndDrawer();
        }
      },
      items: {
        'home': Icons.home,
        'star': EvaIcons.star,
        'bookmark': EvaIcons.bookmark,
        'menu': EvaIcons.menu
      }
          .map((k, v) => MapEntry(
              k,
              BottomNavigationBarItem(
                icon: Icon(v),
                title: Text(k),
              )))
          .values
          .toList(),
    );
  }
}
