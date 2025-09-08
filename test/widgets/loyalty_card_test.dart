import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_qr_bonus/widgets/loyalty_card.dart';

void main() {
  group('LoyaltyCard', () {
    testWidgets('displays brand and content', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoyaltyCard(
              content: '1234567890123456',
              brand: 'Test Brand',
              cardColor: 0xFF6B46C1,
            ),
          ),
        ),
      );

      expect(find.text('Test Brand'), findsOneWidget);
      expect(find.text('1234....3456'), findsOneWidget);
    });

    testWidgets('handles special brand display text for nectar',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoyaltyCard(
              content: '1234567890',
              brand: 'Nectar',
              cardColor: 0xFF6B46C1,
            ),
          ),
        ),
      );

      expect(find.text('nectar'), findsOneWidget);
    });

    testWidgets('handles special brand display text for Tesco',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoyaltyCard(
              content: '1234567890',
              brand: 'Tesco',
              cardColor: 0xFF1E40AF,
            ),
          ),
        ),
      );

      expect(find.text('TESCO'), findsOneWidget);
    });

    testWidgets('handles special brand display text for Marks & Spencer',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoyaltyCard(
              content: '1234567890',
              brand: 'Marks & Spencer',
              cardColor: 0xFF064E3B,
            ),
          ),
        ),
      );

      expect(find.text('M&S'), findsOneWidget);
    });

    testWidgets('handles special brand display text for Waitrose & Partners',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoyaltyCard(
              content: '1234567890',
              brand: 'Waitrose & Partners',
              cardColor: 0xFF059669,
            ),
          ),
        ),
      );

      expect(find.text('WAITROSE\n& PARTNERS'), findsOneWidget);
    });

    testWidgets('displays short content as-is', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoyaltyCard(
              content: '12345',
              brand: 'Test Brand',
              cardColor: 0xFF6B46C1,
            ),
          ),
        ),
      );

      expect(find.text('12345'), findsOneWidget);
    });

    testWidgets('formats long numeric content correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoyaltyCard(
              content: '1234567890123456789',
              brand: 'Test Brand',
              cardColor: 0xFF6B46C1,
            ),
          ),
        ),
      );

      expect(find.text('1234....6789'), findsOneWidget);
    });

    testWidgets('formats content with non-digits correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoyaltyCard(
              content: '1234-5678-9012-3456-7890',
              brand: 'Test Brand',
              cardColor: 0xFF6B46C1,
            ),
          ),
        ),
      );

      expect(find.text('1234....7890'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoyaltyCard(
              content: '1234567890',
              brand: 'Test Brand',
              cardColor: 0xFF6B46C1,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(LoyaltyCard));
      expect(tapped, isTrue);
    });

    testWidgets('calls onLongPress when long pressed',
        (WidgetTester tester) async {
      bool longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoyaltyCard(
              content: '1234567890',
              brand: 'Test Brand',
              cardColor: 0xFF6B46C1,
              onLongPress: () {
                longPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.longPress(find.byType(LoyaltyCard));
      expect(longPressed, isTrue);
    });

    testWidgets('has correct color from cardColor parameter',
        (WidgetTester tester) async {
      const testColor = 0xFF123456;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoyaltyCard(
              content: '1234567890',
              brand: 'Test Brand',
              cardColor: testColor,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(LoyaltyCard),
              matching: find.byType(Container),
            )
            .first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(const Color(testColor)));
    });
  });
}
