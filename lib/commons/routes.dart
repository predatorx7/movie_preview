import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart' show MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:movie_preview/models/provider/media.dart';
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
    case RouteNames.RootRoute:
    default:
      return wrapPageRoute(
        ChangeNotifierProvider(
          create: (_) => MediaNotifier(),
          child: HomeScreen(),
        ),
      );
  }
}
