import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_preview/commons/assets.dart';
import 'package:movie_preview/ui/components/appbar_title.dart';
import 'package:movie_preview/ui/components/searchbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex;

  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _currentIndex = 0;
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(MyAssets.avatarImage, context);
  }

  void dispose() {
    super.dispose();
    _tabController.dispose();
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
        onPressed: () {},
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
        // TODO Add button bar
        // bottom: TabBar(
        //   indicatorSize: TabBarIndicatorSize.tab,
        //   controller: _tabController,
        //   labelColor: Colors.white,
        //   unselectedLabelColor: Colors.grey,
        //   labelStyle: Theme.of(context).textTheme.button,
        //   indicator: null,
        //   indicatorPadding: EdgeInsets.zero,
        //   indicatorColor: Colors.transparent,
        //   tabs: _getButtons(['Movies', 'Shows', 'Music']),
        // ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Text('Movies'),
          Text('Shows'),
          Text('Music'),
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
