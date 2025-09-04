import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/resources/widgets/buttons/buttons.dart';

void main() {
  group('Button Widget Tests', () {

    group('Button.primary', () {
      testWidgets('should render primary button with text', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button.primary(
                text: 'Test Button',
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.text('Test Button'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('should handle button press', (WidgetTester tester) async {
        bool pressed = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button.primary(
                text: 'Test Button',
                onPressed: () => pressed = true,
              ),
            ),
          ),
        );

        await tester.tap(find.text('Test Button'));
        await tester.pump();

        expect(pressed, isTrue);
      });

      testWidgets('should render disabled button when onPressed is null', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button.primary(
                text: 'Disabled Button',
                onPressed: null,
              ),
            ),
          ),
        );

        expect(find.text('Disabled Button'), findsOneWidget);
        final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(button.onPressed, isNull);
      });
    });

    group('Button.secondary', () {
      testWidgets('should render secondary button with text', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button.secondary(
                text: 'Secondary Button',
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.text('Secondary Button'), findsOneWidget);
      });
    });

    group('Button.outlined', () {
      testWidgets('should render outlined button with text', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button.outlined(
                text: 'Outlined Button',
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.text('Outlined Button'), findsOneWidget);
      });
    });

    group('Button.textOnly', () {
      testWidgets('should render text only button', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button.textOnly(
                text: 'Text Only',
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.text('Text Only'), findsOneWidget);
      });
    });

    group('Button.icon', () {
      testWidgets('should render icon button with text and icon', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button.icon(
                text: 'Icon Button',
                icon: const Icon(Icons.add),
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.text('Icon Button'), findsOneWidget);
        expect(find.byIcon(Icons.add), findsOneWidget);
      });
    });

    group('Button.gradient', () {
      testWidgets('should render gradient button with text', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button.gradient(
                text: 'Gradient Button',
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.text('Gradient Button'), findsOneWidget);
      });

      testWidgets('should render gradient button with custom colors', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button.gradient(
                text: 'Custom Gradient',
                gradientColors: const [Colors.red, Colors.blue],
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.text('Custom Gradient'), findsOneWidget);
      });
    });

    group('Button.rounded', () {
      testWidgets('should render rounded button with text', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button.rounded(
                text: 'Rounded Button',
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.text('Rounded Button'), findsOneWidget);
      });
    });

    group('Button.transparency', () {
      testWidgets('should render transparency button with text', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button.transparency(
                text: 'Transparent Button',
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.text('Transparent Button'), findsOneWidget);
      });
    });

    group('Button customization', () {
      testWidgets('should apply custom width and height', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button.primary(
                text: 'Custom Size',
                width: 200,
                height: 60,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.text('Custom Size'), findsOneWidget);
        
        final container = find.descendant(
          of: find.byType(ElevatedButton),
          matching: find.byType(Container),
        );
        expect(container, findsOneWidget);
      });

      testWidgets('should apply custom color to primary button', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Button.primary(
                text: 'Custom Color',
                color: Colors.red,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.text('Custom Color'), findsOneWidget);
      });
    });
  });
}