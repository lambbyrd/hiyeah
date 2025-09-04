import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/resources/pages/home_page.dart';

void main() {
  group('HomePage Widget Tests', () {
    testWidgets('should create HomePage instance', (WidgetTester tester) async {
      expect(() => HomePage(), returnsNormally);
    });

    testWidgets('should render basic structure', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should contain floating action button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
    });

    testWidgets('should render app name from environment', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );
      
      await tester.pumpAndSettle();

      expect(find.byType(Text), findsAtLeastNWidgets(1));
    });

    testWidgets('should contain framework version text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );
      
      await tester.pumpAndSettle();

      expect(find.textContaining('Framework Version'), findsOneWidget);
    });

    testWidgets('should render list tiles for navigation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );
      
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsAtLeastNWidgets(1));
    });

    testWidgets('should handle floating action button tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );
      
      await tester.pumpAndSettle();

      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);
      
      await tester.tap(fab);
      await tester.pumpAndSettle();
    });

    testWidgets('should render logo widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );
      
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsAtLeastNWidgets(1));
    });

    testWidgets('should have proper scaffold structure', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );
      
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Column), findsAtLeastNWidgets(1));
      expect(find.byType(Container), findsAtLeastNWidgets(1));
    });

    testWidgets('should contain navigation items', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );
      
      await tester.pumpAndSettle();

      expect(find.text('Play Game'), findsOneWidget);
      expect(find.text('Clear Authentication'), findsOneWidget);
      expect(find.text('Documentation'), findsOneWidget);
      expect(find.text('Github'), findsOneWidget);
    });

    testWidgets('should handle list tile taps', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
          routes: {
            '/game': (context) => const Scaffold(body: Text('Game Page')),
          },
        ),
      );
      
      await tester.pumpAndSettle();

      final playGameTile = find.text('Play Game');
      expect(playGameTile, findsOneWidget);
      
      await tester.tap(playGameTile);
      await tester.pumpAndSettle();
    });
  });
}