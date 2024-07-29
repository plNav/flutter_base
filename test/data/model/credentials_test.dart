

import 'package:baccus_kitchen/data/model/credentials.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Credentials', () {
    test('should be instantiated with url, user, and pass', () {
      const credentials = Credentials(url: 'http://example.com', user: 'username', pass: 'password');

      expect(credentials.url, 'http://example.com');
      expect(credentials.user, 'username');
      expect(credentials.pass, 'password');
    });

    test('should return the sum of two numbers', () {
      const credentials = Credentials(url: 'http://example.com', user: 'username', pass: 'password');
      final result = credentials.sum(2, 3);

      expect(result, 5);
    });
  });
}
