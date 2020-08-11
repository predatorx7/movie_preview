import 'package:flutter_test/flutter_test.dart';

import 'api/media.dart';
import 'objects/media.dart';

void main() {
  group('JsonSerializable tests for', () {
    mediaJsonTest();
  });
  group('fetch using MediaAPIClient', () {
    mediaApiClientTest();
  });
}
