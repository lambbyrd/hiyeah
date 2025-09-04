import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/app/models/user.dart';

void main() {
  group('User Model Tests', () {
    test('should create user from JSON correctly', () {
      final json = {
        'name': 'John Doe',
        'email': 'john.doe@example.com',
      };

      final user = User.fromJson(json);

      expect(user.name, equals('John Doe'));
      expect(user.email, equals('john.doe@example.com'));
    });

    test('should handle null values in JSON', () {
      final json = <String, dynamic>{};

      final user = User.fromJson(json);

      expect(user.name, isNull);
      expect(user.email, isNull);
    });

    test('should convert user to JSON correctly', () {
      final user = User()
        ..name = 'Jane Smith'
        ..email = 'jane.smith@example.com';

      final json = user.toJson();

      expect(json['name'], equals('Jane Smith'));
      expect(json['email'], equals('jane.smith@example.com'));
    });

    test('should convert user with null values to JSON correctly', () {
      final user = User();

      final json = user.toJson();

      expect(json['name'], isNull);
      expect(json['email'], isNull);
    });

    test('should have correct storage key', () {
      expect(User.key, equals('user'));
    });

    test('should create empty user with correct key', () {
      final user = User();
      
      expect(user.name, isNull);
      expect(user.email, isNull);
    });
  });
}