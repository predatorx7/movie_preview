import 'package:flutter/material.dart';
import 'package:movie_preview/commons/routes.dart';
import 'package:movie_preview/commons/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie preview',
      theme: themeData,
      onGenerateRoute: generateRoute,
    );
  }
}
