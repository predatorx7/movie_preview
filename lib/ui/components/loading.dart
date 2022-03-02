import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget {
  final bool useScaffold;
  final bool useWhiteBackground;
  final double? value;
  const CircularLoading({
    Key? key,
    this.useScaffold = true,
    this.useWhiteBackground = true,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Center(
      child: CircularProgressIndicator(
        strokeWidth: 3,
        value: value,
      ),
    );
    if (useScaffold) {
      child = Scaffold(body: child);
    } else if (useWhiteBackground) {
      child = DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: child,
      );
    }
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.lightGreen,
        scaffoldBackgroundColor: Colors.yellow,
      ),
      child: child,
    );
  }
}
