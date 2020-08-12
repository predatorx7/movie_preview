import 'package:flutter/material.dart';

class ErrorSnackBar extends SnackBar {
  ErrorSnackBar()
      : super(
          backgroundColor: Colors.red,
          content: Text(
            'Could not load data',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        );
}
