import 'package:flutter/material.dart';

class Dummy extends StatelessWidget {
  final String label;

  const Dummy(
    this.label, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(label),
    );
  }
}
