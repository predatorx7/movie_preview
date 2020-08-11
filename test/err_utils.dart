import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

void errPrint(Object object, bool shouldPrint) {
  String statement = '=== errPrint ===\n\n';
  if (object is List) {
    statement += object.join('\n\n');
  } else {
    statement += object.toString();
  }
  expect(shouldPrint, false, reason: statement);
}

String encodeToString(Object object) =>
    const JsonEncoder.withIndent(' ').convert(object);
