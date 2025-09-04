import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/app/controllers/home_controller.dart';

void main() {
  group('HomeController Tests', () {
    late HomeController controller;

    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    setUp(() {
      controller = HomeController();
    });

    test('should create HomeController instance', () {
      expect(controller, isNotNull);
      expect(controller, isA<HomeController>());
    });

    group('URL launching methods', () {
      test('should handle onTapDocumentation method call', () async {
        expect(() async => await controller.onTapDocumentation(), returnsNormally);
      });

      test('should handle onTapGithub method call', () async {
        expect(() async => await controller.onTapGithub(), returnsNormally);
      });

      test('should handle onTapChangeLog method call', () async {
        expect(() async => await controller.onTapChangeLog(), returnsNormally);
      });

      test('should handle onTapYouTube method call', () async {
        expect(() async => await controller.onTapYouTube(), returnsNormally);
      });

      test('should handle onTapX method call', () async {
        expect(() async => await controller.onTapX(), returnsNormally);
      });
    });

    group('method existence', () {
      test('should have all required methods', () {
        expect(controller.onTapDocumentation, isNotNull);
        expect(controller.onTapGithub, isNotNull);
        expect(controller.onTapChangeLog, isNotNull);
        expect(controller.onTapYouTube, isNotNull);
        expect(controller.onTapX, isNotNull);
      });
    });
  });
}