import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart' show MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:movie_preview/models/provider/media.dart';
import 'package:movie_preview/models/view/home.dart';
import 'package:provider/provider.dart';

import '../ui/screens/home.dart';

import 'route_names.dart';

/// Wraps [screen] with a [PageRoute]
PageRoute wrapPageRoute(Widget screen, [bool useCupertinoPageRoute = true]) {
  if (useCupertinoPageRoute) {
    return CupertinoPageRoute(builder: (context) => screen);
  }
  return MaterialPageRoute(
    builder: (context) => screen,
  );
}

/// Generates Routes which will be used in the application
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.rootRoute:
    default:
      return wrapPageRoute(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MediaProvider>(
              create: (_) => MediaProvider(),
            ),
            ChangeNotifierProvider<HomeView>(
              create: (_) => HomeView(0, 0),
            ),
          ],
          child: const HomeScreen(),
        ),
      );
  }
}
