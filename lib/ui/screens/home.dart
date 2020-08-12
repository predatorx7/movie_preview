import 'package:flutter/material.dart';
import 'package:movie_preview/commons/styles.dart';
import 'package:movie_preview/models/provider/media.dart';
import 'package:movie_preview/models/view/home.dart';
import 'package:movie_preview/ui/components/appbar_title.dart';
import 'package:movie_preview/ui/components/bottom_navbar.dart';
import 'package:movie_preview/ui/components/dummy.dart';
import 'package:movie_preview/ui/components/error_snackbar.dart';
import 'package:movie_preview/ui/components/loading_dialog.dart';
import 'package:movie_preview/ui/components/searchbar.dart';
import 'package:movie_preview/ui/components/titleview.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeView view;
  Loading loadingDialog = Loading();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  /// creates a list of Buttons where selected button is emphasized with
  /// a unique style, size, color & padding
  List<Widget> _buildButtonBar(List<String> labels) {
    List<Widget> _buttons = <Widget>[];
    for (var i = 0; i < labels.length; i++) {
      final bool isButtonSelected = view.tabIndex == i;
      // use a white label with a bigger fontSize if button is selected, else keep it grey & smaller size
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
        decoration: !isButtonSelected ? null : boxDecorationWithPinkShadow,
        child: FlatButton(
          onPressed: () {
            // on tap, change current tab index to this button's index
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

  void _showErrorScaffold() {
    key.currentState.showSnackBar(
      ErrorSnackBar(),
    );
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Show loading dialog before data is loaded;
      loadingDialog.show(context);
      // To avoid loading dialog not getting dismissed, we must call Loading.hide() after a while
      Future.delayed(Duration(seconds: 15), () {
        loadingDialog.hide();
      });
    });
    var provider = Provider.of<MediaProvider>(context, listen: false);
    // If application life cycle changes, the state update could be skipped
    // and the loading dialog will not hide but the stream may keep running.
    //
    // To avoid loading dialog not getting dismissed, we must call Loading.hide() everytime
    // we recieve data as a workaround for not using life cycle manager
    provider.onData(() {
      loadingDialog.hide();
    });
    provider.onError((_) {
      // either the timer ran out or an unexpected exception was thrown (404 maybe)
      _showErrorScaffold();
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    view = Provider.of<HomeView>(context);
  }

  void dispose() {
    super.dispose();
    view.dispose();
    loadingDialog = null;
    // dispose repository and media provider
    Provider.of<MediaProvider>(context, listen: false).dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabChildren = [
      TitleView(),
      TitleView(),
      Expanded(child: Dummy('Music')),
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
      key: key,
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
