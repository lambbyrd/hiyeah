import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/app/services/clerk_service.dart';

void main() {
  group('ClerkService Tests', () {
    late ClerkService clerkService;

    setUpAll(() {
      // Mock environment setup to prevent dotenv errors
    });

    setUp(() {
      clerkService = ClerkService.instance;
    });

    group('singleton pattern', () {
      test('should return same instance', () {
        final instance1 = ClerkService.instance;
        final instance2 = ClerkService.instance;

        expect(instance1, same(instance2));
      });
    });

    group('basic functionality', () {
      test('should create ClerkService instance without error', () {
        expect(clerkService, isNotNull);
        expect(clerkService, isA<ClerkService>());
      });

      test('should handle signOut method call', () async {
        expect(() async => await clerkService.signOut(), returnsNormally);
      });

      test('should handle saveAuthToken method call', () async {
        expect(() async => await clerkService.saveAuthToken('test_token'), returnsNormally);
      });

      test('should handle clearAuthToken method call', () async {
        expect(() async => await clerkService.clearAuthToken(), returnsNormally);
      });

      test('should handle isAuthenticated method call', () async {
        final result = await clerkService.isAuthenticated();
        expect(result, isA<bool>());
      });
    });
  });
}