import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/app/services/clerk_service.dart';

void main() {
  group('ClerkService Simple Tests', () {
    test('should return same instance (singleton pattern)', () {
      final instance1 = ClerkService.instance;
      final instance2 = ClerkService.instance;
      
      expect(instance1, same(instance2));
    });

    test('should create ClerkService instance without error', () {
      final clerkService = ClerkService.instance;
      
      expect(clerkService, isNotNull);
      expect(clerkService, isA<ClerkService>());
    });

    test('should handle multiple instance calls', () {
      final services = List.generate(5, (index) => ClerkService.instance);
      
      for (int i = 1; i < services.length; i++) {
        expect(services[i], same(services[0]));
      }
    });
  });
}