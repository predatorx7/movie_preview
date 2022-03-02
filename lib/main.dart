import 'package:flutter/material.dart';
import 'package:movie_preview/commons/routes.dart';
import 'package:movie_preview/commons/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie preview',
      theme: themeData,
      onGenerateRoute: generateRoute,
    );
  }
}
