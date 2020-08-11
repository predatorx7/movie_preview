import 'package:flutter/material.dart';
import 'package:movie_preview/models/view/home.dart';
import 'package:movie_preview/ui/components/appbar_title.dart';
import 'package:movie_preview/ui/components/bottom_navbar.dart';
import 'package:movie_preview/ui/components/dummy.dart';
import 'package:movie_preview/ui/components/searchbar.dart';
import 'package:movie_preview/ui/components/titleview.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  HomeView view;

  List<Widget> _buildButtonBar(List<String> labels) {
    List<Widget> _buttons = <Widget>[];
    for (var i = 0; i < labels.length; i++) {
      final bool isButtonSelected = view.tabIndex == i;
      final _textStyle = TextStyle(
          color: isButtonSelected ? Colors.white : Colors.grey,
          fontSize: isButtonSelected ? 14 : 12);
      final Color _buttonColor =
          isButtonSelected ? Colors.pink : Colors.grey.shade900;
      final _padding = isButtonSelected
          ? const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10)
          : EdgeInsets.zero;
      Widget child = Container(
        padding: isButtonSelected ? const EdgeInsets.all(8) : EdgeInsets.zero,
        decoration: !isButtonSelected
            ? null
            : BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
        child: FlatButton(
          onPressed: () {
            view.setTabIndex(i);
          },
          padding: EdgeInsets.symmetric(horizontal: 16),
          color: _buttonColor,
          child: Padding(
            padding: _padding,
            child: Text(
              labels[i],
              style: _textStyle,
            ),
          ),
        ),
      );
      _buttons.add(child);
    }
    return _buttons;
  }

  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    view = Provider.of<HomeView>(context);
  }

  void dispose() {
    super.dispose();
    view.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabChildren = [
      TitleView(),
      TitleView(),
      Dummy('Music'),
    ];

    final Widget home = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            layoutBehavior: ButtonBarLayoutBehavior.constrained,
            children: _buildButtonBar(['Movies', 'Shows', 'Music']),
          ),
        ),
        tabChildren[view.tabIndex],
      ],
    );

    final List<Widget> children = <Widget>[
      home,
      Dummy('star'),
      Dummy('bookmark'),
      Dummy('star')
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: AppbarTitle(),
        actions: [
          SearchBar(),
        ],
      ),
      body: children[view.bottomBarIndex],
      endDrawer: Drawer(
        child: Dummy('Drawer'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
