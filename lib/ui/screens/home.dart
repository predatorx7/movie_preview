import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_preview/commons/assets.dart';
import 'package:movie_preview/models/provider/media.dart';
import 'package:movie_preview/ui/components/appbar_title.dart';
import 'package:movie_preview/ui/components/searchbar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex;
  MediaNotifier provider;

  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _currentIndex = 0;
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of<MediaNotifier>(context);
    precacheImage(MyAssets.avatarImage, context);
  }

  void dispose() {
    super.dispose();
    _tabController.dispose();
    provider.dispose();
  }

  List<Widget> _getButtons(List<String> labels) {
    List<Widget> _buttons = <Widget>[];
    for (var i = 0; i < labels.length; i++) {
      final bool isButtonSelected = _tabController.index == i;
      final _textStyle = TextStyle(
          color: isButtonSelected ? Colors.pink : Colors.grey,
          fontSize: isButtonSelected ? 14 : 12);
      final _padding = isButtonSelected
          ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10)
          : EdgeInsets.zero;
      Widget child = FlatButton(
        onPressed: () {
          setState(() {
            _tabController.index = i;
          });
        },
        child: Padding(
          padding: _padding,
          child: Text(
            labels[i],
            style: _textStyle,
          ),
        ),
      );
      _buttons.add(child);
    }
    return _buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: AppbarTitle(),
        actions: [
          SearchBar(),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonBar(
            children: _getButtons(['Movies', 'Shows', 'Music']),
          ),
          TabBarView(
            controller: _tabController,
            children: [
              Text('Movies'),
              Text('Shows'),
              Text('Music'),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        onTap: (int i) => setState(() {
          _currentIndex = i;
        }),
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
      ),
    );
  }
}
