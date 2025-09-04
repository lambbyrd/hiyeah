import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/resources/widgets/logo_widget.dart';
import 'package:flutter_app/resources/widgets/theme_toggle_widget.dart';
import 'package:flutter_app/resources/widgets/loader_widget.dart';

void main() {
  group('Custom Widget Tests', () {
    group('Logo Widget', () {
      testWidgets('should render logo with default dimensions', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Logo(),
            ),
          ),
        );

        expect(find.byType(Logo), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);
      });

      testWidgets('should render logo with custom dimensions', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Logo(
                height: 150,
                width: 150,
              ),
            ),
          ),
        );

        expect(find.byType(Logo), findsOneWidget);
        
        final logoWidget = tester.widget<Logo>(find.byType(Logo));
        expect(logoWidget.height, equals(150));
        expect(logoWidget.width, equals(150));
      });

      testWidgets('should handle null dimensions', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Logo(
                height: null,
                width: null,
              ),
            ),
          ),
        );

        expect(find.byType(Logo), findsOneWidget);
        
        final logoWidget = tester.widget<Logo>(find.byType(Logo));
        expect(logoWidget.height, isNull);
        expect(logoWidget.width, isNull);
      });
    });

    group('ThemeToggle Widget', () {
      testWidgets('should render theme toggle widget', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ThemeToggle(),
            ),
          ),
        );

        expect(find.byType(ThemeToggle), findsOneWidget);
      });

      testWidgets('should contain switch and text elements', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ThemeToggle(),
            ),
          ),
        );

        expect(find.byType(Column), findsAtLeastNWidgets(1));
        expect(find.byType(Text), findsAtLeastNWidgets(1));
      });
    });

    group('Loader', () {
      testWidgets('should render loader widget', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Loader(),
            ),
          ),
        );

        expect(find.byType(Loader), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('should render centered loader', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Loader(),
            ),
          ),
        );

        expect(find.byType(Loader), findsOneWidget);
        expect(find.byType(Center), findsOneWidget);
      });
    });

    group('Widget Properties', () {
      testWidgets('should create widgets without errors', (WidgetTester tester) async {
        expect(() => const Logo(), returnsNormally);
        expect(() => const ThemeToggle(), returnsNormally);
        expect(() => const Loader(), returnsNormally);
      });

      testWidgets('should handle widget tree properly', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Logo(),
                    SizedBox(height: 10),
                    ThemeToggle(),
                    SizedBox(height: 10),
                    Loader(),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(Logo), findsOneWidget);
        expect(find.byType(ThemeToggle), findsOneWidget);
        expect(find.byType(Loader), findsOneWidget);
        expect(find.byType(Column), findsAtLeastNWidgets(1));
      });
    });
  });
}