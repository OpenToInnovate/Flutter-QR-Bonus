import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_qr_bonus/pages/card_detail_page.dart';
import 'package:flutter_qr_bonus/models/scan_result.dart';

void main() {
  group('CardDetailPage', () {
    late ScanResult testResult;

    setUp(() {
      testResult = ScanResult(
        content: '2994058389103',
        timestamp: DateTime.now(),
      );
    });

    testWidgets('displays app bar with store name and Edit button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CardDetailPage(result: testResult),
        ),
      );

      // Should have Nectar as default store name
      expect(find.text('Nectar'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);
    });

    testWidgets('displays card with barcode and numbers',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CardDetailPage(result: testResult),
        ),
      );

      // Should display formatted primary number
      expect(find.text('2994 0583 8910 3'), findsOneWidget);

      // Should display secondary number
      expect(find.text('2994058389103'), findsOneWidget);

      // Should have barcode visualization
      expect(find.byType(CustomPaint), findsOneWidget);
    });

    testWidgets('displays action buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CardDetailPage(result: testResult),
        ),
      );

      expect(find.text('Card Pictures'), findsOneWidget);
      expect(find.text('Notes'), findsOneWidget);
      expect(find.text('Share Card'), findsOneWidget);

      expect(find.byIcon(Icons.photo_library), findsOneWidget);
      expect(find.byIcon(Icons.note), findsOneWidget);
      expect(find.byIcon(Icons.share), findsOneWidget);
    });

    testWidgets('card pictures button shows placeholder message',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CardDetailPage(result: testResult),
        ),
      );

      await tester.tap(find.text('Card Pictures'));
      await tester.pump();

      expect(
          find.text('Card pictures functionality coming soon'), findsOneWidget);
    });

    testWidgets('notes button shows placeholder message',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CardDetailPage(result: testResult),
        ),
      );

      await tester.tap(find.text('Notes'));
      await tester.pump();

      expect(find.text('Notes functionality coming soon'), findsOneWidget);
    });

    testWidgets('edit button shows placeholder message',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CardDetailPage(result: testResult),
        ),
      );

      await tester.tap(find.text('Edit'));
      await tester.pump();

      expect(find.text('Edit functionality coming soon'), findsOneWidget);
    });

    testWidgets('formats short numbers correctly', (WidgetTester tester) async {
      final shortResult = ScanResult(
        content: '12345',
        timestamp: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CardDetailPage(result: shortResult),
        ),
      );

      expect(find.text('12345'), findsOneWidget);
    });

    testWidgets('handles different store brands correctly',
        (WidgetTester tester) async {
      final tescoResult = ScanResult(
        content: 'tesco card number',
        timestamp: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CardDetailPage(result: tescoResult),
        ),
      );

      // Should still default to Nectar since content doesn't match known stores
      expect(find.text('Nectar'), findsOneWidget);
      expect(find.text('nectar'), findsOneWidget);
    });

    testWidgets('has correct theme colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CardDetailPage(result: testResult),
        ),
      );

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, equals(Colors.black));

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, equals(const Color(0xFF2D2D2D)));
    });

    testWidgets('back button navigates back', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CardDetailPage(result: testResult),
                ),
              ),
              child: const Text('Go to Card Detail'),
            ),
          ),
        ),
      );

      // Navigate to card detail page
      await tester.tap(find.text('Go to Card Detail'));
      await tester.pumpAndSettle();

      expect(find.byType(CardDetailPage), findsOneWidget);

      // Tap back button
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.byType(CardDetailPage), findsNothing);
    });
  });

  group('BarcodePainter', () {
    testWidgets('renders barcode visualization', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              painter: BarcodePainter(),
              size: const Size(200, 60),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });
}
