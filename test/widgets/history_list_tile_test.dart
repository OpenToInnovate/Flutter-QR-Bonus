import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_qr_bonus/widgets/history_list_tile.dart';
import 'package:flutter_qr_bonus/models/scan_result.dart';

void main() {
  group('HistoryListTile', () {
    late ScanResult testResult;
    late bool tapPressed;
    late bool copyPressed;
    late bool sharePressed;

    setUp(() {
      testResult = ScanResult.now('https://example.com');
      tapPressed = false;
      copyPressed = false;
      sharePressed = false;
    });

    Widget createWidget() {
      return MaterialApp(
        home: Scaffold(
          body: HistoryListTile(
            result: testResult,
            index: 0,
            onTap: () => tapPressed = true,
            onCopy: () => copyPressed = true,
            onShare: () => sharePressed = true,
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

    testWidgets('should display history icon', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidget());

      // Assert
      expect(find.byIcon(Icons.history), findsOneWidget);
    });

    testWidgets('should display copy and share icons',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidget());

      // Assert
      expect(find.byIcon(Icons.copy), findsOneWidget);
      expect(find.byIcon(Icons.share), findsOneWidget);
    });

    testWidgets('should call onTap when tile is tapped',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidget());

      // Act
      await tester.tap(find.byType(ListTile));
      await tester.pump();

      // Assert
      expect(tapPressed, isTrue);
      expect(copyPressed, isFalse);
      expect(sharePressed, isFalse);
    });

    testWidgets('should call onCopy when copy icon is pressed',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidget());

      // Act
      await tester.tap(find.byIcon(Icons.copy));
      await tester.pump();

      // Assert
      expect(copyPressed, isTrue);
      expect(tapPressed, isFalse);
      expect(sharePressed, isFalse);
    });

    testWidgets('should call onShare when share icon is pressed',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidget());

      // Act
      await tester.tap(find.byIcon(Icons.share));
      await tester.pump();

      // Assert
      expect(sharePressed, isTrue);
      expect(tapPressed, isFalse);
      expect(copyPressed, isFalse);
    });

    testWidgets('should display timestamp', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidget());

      // Assert
      expect(find.textContaining('ago'), findsOneWidget);
    });

    testWidgets('should display "Just now" for recent result',
        (WidgetTester tester) async {
      // Arrange
      final recentResult = ScanResult.now('recent content');
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HistoryListTile(
            result: recentResult,
            index: 0,
            onTap: () {},
            onCopy: () {},
            onShare: () {},
          ),
        ),
      ));

      // Assert
      expect(find.text('Just now'), findsOneWidget);
    });

    testWidgets('should display "1 minute ago" for 1 minute old result',
        (WidgetTester tester) async {
      // Arrange
      final oldResult = ScanResult(
        content: 'old content',
        timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
      );
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HistoryListTile(
            result: oldResult,
            index: 0,
            onTap: () {},
            onCopy: () {},
            onShare: () {},
          ),
        ),
      ));

      // Assert
      expect(find.text('1 minute ago'), findsOneWidget);
    });

    testWidgets('should display "2 minutes ago" for 2 minutes old result',
        (WidgetTester tester) async {
      // Arrange
      final oldResult = ScanResult(
        content: 'old content',
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      );
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HistoryListTile(
            result: oldResult,
            index: 0,
            onTap: () {},
            onCopy: () {},
            onShare: () {},
          ),
        ),
      ));

      // Assert
      expect(find.text('2 minutes ago'), findsOneWidget);
    });

    testWidgets('should display "1 hour ago" for 1 hour old result',
        (WidgetTester tester) async {
      // Arrange
      final oldResult = ScanResult(
        content: 'old content',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      );
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HistoryListTile(
            result: oldResult,
            index: 0,
            onTap: () {},
            onCopy: () {},
            onShare: () {},
          ),
        ),
      ));

      // Assert
      expect(find.text('1 hour ago'), findsOneWidget);
    });

    testWidgets('should display "2 hours ago" for 2 hours old result',
        (WidgetTester tester) async {
      // Arrange
      final oldResult = ScanResult(
        content: 'old content',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      );
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HistoryListTile(
            result: oldResult,
            index: 0,
            onTap: () {},
            onCopy: () {},
            onShare: () {},
          ),
        ),
      ));

      // Assert
      expect(find.text('2 hours ago'), findsOneWidget);
    });

    testWidgets('should display "1 day ago" for 1 day old result',
        (WidgetTester tester) async {
      // Arrange
      final oldResult = ScanResult(
        content: 'old content',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      );
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HistoryListTile(
            result: oldResult,
            index: 0,
            onTap: () {},
            onCopy: () {},
            onShare: () {},
          ),
        ),
      ));

      // Assert
      expect(find.text('1 day ago'), findsOneWidget);
    });

    testWidgets('should display "2 days ago" for 2 days old result',
        (WidgetTester tester) async {
      // Arrange
      final oldResult = ScanResult(
        content: 'old content',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
      );
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HistoryListTile(
            result: oldResult,
            index: 0,
            onTap: () {},
            onCopy: () {},
            onShare: () {},
          ),
        ),
      ));

      // Assert
      expect(find.text('2 days ago'), findsOneWidget);
    });

    testWidgets('should truncate long content with ellipsis',
        (WidgetTester tester) async {
      // Arrange
      final longContent = 'a' * 100; // Very long content
      final longResult = ScanResult.now(longContent);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HistoryListTile(
            result: longResult,
            index: 0,
            onTap: () {},
            onCopy: () {},
            onShare: () {},
          ),
        ),
      ));

      // Assert
      final textWidget = tester.widget<Text>(find.byType(Text).first);
      expect(textWidget.overflow, equals(TextOverflow.ellipsis));
      expect(textWidget.maxLines, equals(2));
    });
  });
}
