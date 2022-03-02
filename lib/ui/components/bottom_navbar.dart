import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_preview/models/notifiers/home.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _homeView = Provider.of<TabIndexNotifier>(context);

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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(EvaIcons.star),
          label: 'star',
        ),
        BottomNavigationBarItem(
          icon: Icon(EvaIcons.bookmark),
          label: 'bookmark',
        ),
        BottomNavigationBarItem(
          icon: Icon(EvaIcons.menu),
          label: 'menu',
        ),
      ],
    );
  }
}
