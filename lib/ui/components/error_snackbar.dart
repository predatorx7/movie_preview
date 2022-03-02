import 'package:flutter/material.dart';

class ErrorSnackBar extends SnackBar {
  const ErrorSnackBar({Key? key})
      : super(
          key: key,
          backgroundColor: Colors.red,
          content: const Text(
            'Could not load data',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        );
}
