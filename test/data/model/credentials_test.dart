

import 'package:baccus_kitchen/data/model/environment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Credentials', () {
    test('should be instantiated with url, user, and pass', () {
      const credentials = Environment(baseUrl: 'http://example.com', user: 'username', pass: 'password');

      expect(credentials.baseUrl, 'http://example.com');
      expect(credentials.user, 'username');
      expect(credentials.pass, 'password');
    });

    test('should return the sum of two numbers', () {
      const credentials = Environment(baseUrl: 'http://example.com', user: 'username', pass: 'password');
      final result = credentials.sum(2, 3);

      expect(result, 5);
    });
  });
}
