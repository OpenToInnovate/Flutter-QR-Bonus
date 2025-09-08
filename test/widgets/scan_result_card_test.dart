import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_qr_bonus/widgets/scan_result_card.dart';
import 'package:flutter_qr_bonus/models/scan_result.dart';

void main() {
  group('ScanResultCard', () {
    late ScanResult testResult;
    late bool copyPressed;
    late bool sharePressed;

    setUp(() {
      testResult = ScanResult.now('https://example.com');
      copyPressed = false;
      sharePressed = false;
    });

    Widget createWidget({bool isLatest = false}) {
      return MaterialApp(
        home: Scaffold(
          body: ScanResultCard(
            result: testResult,
            onCopy: () => copyPressed = true,
            onShare: () => sharePressed = true,
            isLatest: isLatest,
          ),
        ),
      );
    }

    testWidgets('should display scan result content',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidget());

      // Assert
      expect(find.text('https://example.com'), findsOneWidget);
    });

    testWidgets('should display "Latest result" for latest result',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidget(isLatest: true));

      // Assert
      expect(find.text('Latest result'), findsOneWidget);
    });

    testWidgets('should display "Scan result" for non-latest result',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidget(isLatest: false));

      // Assert
      expect(find.text('Scan result'), findsOneWidget);
    });

    testWidgets('should have copy and share buttons',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidget());

      // Assert
      expect(find.text('Copy'), findsOneWidget);
      expect(find.text('Share'), findsOneWidget);
      expect(find.byIcon(Icons.copy), findsOneWidget);
      expect(find.byIcon(Icons.share), findsOneWidget);
    });

    testWidgets('should call onCopy when copy button is pressed',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidget());

      // Act
      await tester.tap(find.text('Copy'));
      await tester.pump();

      // Assert
      expect(copyPressed, isTrue);
      expect(sharePressed, isFalse);
    });

    testWidgets('should call onShare when share button is pressed',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidget());

      // Act
      await tester.tap(find.text('Share'));
      await tester.pump();

      // Assert
      expect(sharePressed, isTrue);
      expect(copyPressed, isFalse);
    });

    testWidgets('should display timestamp for non-latest result',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidget(isLatest: false));

      // Assert
      expect(find.textContaining('ago'), findsOneWidget);
    });

    testWidgets('should not display timestamp for latest result',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidget(isLatest: true));

      // Assert
      expect(find.textContaining('ago'), findsNothing);
    });

    testWidgets('should have higher elevation for latest result',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidget(isLatest: true));
      final card = tester.widget<Card>(find.byType(Card));

      // Assert
      expect(card.elevation, equals(2));
    });

    testWidgets('should have lower elevation for non-latest result',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidget(isLatest: false));
      final card = tester.widget<Card>(find.byType(Card));

      // Assert
      expect(card.elevation, equals(1));
    });

    testWidgets('should make text selectable', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidget());

      // Assert
      expect(find.byType(SelectableText), findsOneWidget);
    });
  });
}
