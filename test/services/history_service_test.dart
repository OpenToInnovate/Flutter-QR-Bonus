import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_qr_bonus/services/history_service.dart';

void main() {
  group('HistoryService', () {
    late HistoryService historyService;

    setUp(() {
      // Clear SharedPreferences before each test
      SharedPreferences.setMockInitialValues({});
      historyService = HistoryService();
    });

    test('should initialize with empty history', () async {
      // Act
      await historyService.initialize();

      // Assert
      expect(historyService.isEmpty, isTrue);
      expect(historyService.length, equals(0));
      expect(historyService.latest, isNull);
    });

    test('should add result to history', () async {
      // Arrange
      await historyService.initialize();
      const content = 'test content';

      // Act
      await historyService.addResult(content);

      // Assert
      expect(historyService.isEmpty, isFalse);
      expect(historyService.length, equals(1));
      expect(historyService.latest?.content, equals(content));
    });

    test('should move duplicate to top when adding', () async {
      // Arrange
      await historyService.initialize();
      const content1 = 'content1';
      const content2 = 'content2';
      const duplicateContent = 'content1';

      // Act
      await historyService.addResult(content1);
      await historyService.addResult(content2);
      await historyService.addResult(duplicateContent);

      // Assert
      expect(historyService.length, equals(2));
      expect(historyService.latest?.content, equals(duplicateContent));
      expect(historyService.history[1].content, equals(content2));
    });

    test('should clear history', () async {
      // Arrange
      await historyService.initialize();
      await historyService.addResult('content1');
      await historyService.addResult('content2');

      // Act
      await historyService.clear();

      // Assert
      expect(historyService.isEmpty, isTrue);
      expect(historyService.length, equals(0));
      expect(historyService.latest, isNull);
    });

    test('should promote item to top', () async {
      // Arrange
      await historyService.initialize();
      await historyService.addResult('content1');
      await historyService.addResult('content2');
      await historyService.addResult('content3');

      // Act
      await historyService.promoteToTop(2); // Promote 'content1' to top

      // Assert
      expect(historyService.latest?.content, equals('content1'));
      expect(historyService.history[1].content, equals('content3'));
      expect(historyService.history[2].content, equals('content2'));
    });

    test('should remove item at index', () async {
      // Arrange
      await historyService.initialize();
      await historyService.addResult('content1');
      await historyService.addResult('content2');
      await historyService.addResult('content3');

      // Act
      await historyService.removeAt(1); // Remove 'content2'

      // Assert
      expect(historyService.length, equals(2));
      expect(historyService.latest?.content, equals('content1'));
      expect(historyService.history[1].content, equals('content3'));
    });

    test('should handle invalid index gracefully', () async {
      // Arrange
      await historyService.initialize();
      await historyService.addResult('content1');

      // Act & Assert - should not throw
      await historyService.removeAt(-1);
      await historyService.removeAt(10);
      await historyService.promoteToTop(-1);
      await historyService.promoteToTop(10);

      // History should remain unchanged
      expect(historyService.length, equals(1));
      expect(historyService.latest?.content, equals('content1'));
    });

    test('should persist and restore history', () async {
      // Arrange
      await historyService.initialize();
      await historyService.addResult('content1');
      await historyService.addResult('content2');

      // Create a new service instance to simulate app restart
      final newHistoryService = HistoryService();

      // Act
      await newHistoryService.initialize();

      // Assert
      expect(newHistoryService.length, equals(2));
      expect(newHistoryService.latest?.content, equals('content2'));
      expect(newHistoryService.history[1].content, equals('content1'));
    });

    test('should limit history size', () async {
      // Arrange
      await historyService.initialize();

      // Act - Add more than maxHistoryItems (100)
      for (int i = 0; i < 105; i++) {
        await historyService.addResult('content$i');
      }

      // Assert
      expect(historyService.length, equals(100));
      expect(historyService.latest?.content, equals('content104'));
    });
  });
}
