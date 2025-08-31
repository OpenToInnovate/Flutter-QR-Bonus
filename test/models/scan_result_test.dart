import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_qr_bonus/models/scan_result.dart';

void main() {
  group('ScanResult', () {
    test('should create a scan result with current timestamp', () {
      // Arrange
      const content = 'https://example.com';
      final beforeCreation = DateTime.now();
      
      // Act
      final result = ScanResult.now(content);
      final afterCreation = DateTime.now();
      
      // Assert
      expect(result.content, equals(content));
      expect(result.timestamp.isAfter(beforeCreation), isTrue);
      expect(result.timestamp.isBefore(afterCreation), isTrue);
    });
    
    test('should create a scan result with specific timestamp', () {
      // Arrange
      const content = 'test content';
      final timestamp = DateTime(2023, 1, 1, 12, 0, 0);
      
      // Act
      final result = ScanResult(content: content, timestamp: timestamp);
      
      // Assert
      expect(result.content, equals(content));
      expect(result.timestamp, equals(timestamp));
    });
    
    test('should convert to JSON correctly', () {
      // Arrange
      const content = 'test content';
      final timestamp = DateTime(2023, 1, 1, 12, 0, 0);
      final result = ScanResult(content: content, timestamp: timestamp);
      
      // Act
      final json = result.toJson();
      
      // Assert
      expect(json['content'], equals(content));
      expect(json['timestamp'], equals(timestamp.millisecondsSinceEpoch));
    });
    
    test('should create from JSON correctly', () {
      // Arrange
      const content = 'test content';
      final timestamp = DateTime(2023, 1, 1, 12, 0, 0);
      final json = {
        'content': content,
        'timestamp': timestamp.millisecondsSinceEpoch,
      };
      
      // Act
      final result = ScanResult.fromJson(json);
      
      // Assert
      expect(result.content, equals(content));
      expect(result.timestamp, equals(timestamp));
    });
    
    test('should be equal when content and timestamp are the same', () {
      // Arrange
      const content = 'test content';
      final timestamp = DateTime(2023, 1, 1, 12, 0, 0);
      final result1 = ScanResult(content: content, timestamp: timestamp);
      final result2 = ScanResult(content: content, timestamp: timestamp);
      
      // Act & Assert
      expect(result1, equals(result2));
      expect(result1.hashCode, equals(result2.hashCode));
    });
    
    test('should not be equal when content differs', () {
      // Arrange
      final timestamp = DateTime(2023, 1, 1, 12, 0, 0);
      final result1 = ScanResult(content: 'content1', timestamp: timestamp);
      final result2 = ScanResult(content: 'content2', timestamp: timestamp);
      
      // Act & Assert
      expect(result1, isNot(equals(result2)));
    });
    
    test('should not be equal when timestamp differs', () {
      // Arrange
      const content = 'test content';
      final result1 = ScanResult(content: content, timestamp: DateTime(2023, 1, 1, 12, 0, 0));
      final result2 = ScanResult(content: content, timestamp: DateTime(2023, 1, 1, 12, 0, 1));
      
      // Act & Assert
      expect(result1, isNot(equals(result2)));
    });
    
    test('should have correct string representation', () {
      // Arrange
      const content = 'test content';
      final timestamp = DateTime(2023, 1, 1, 12, 0, 0);
      final result = ScanResult(content: content, timestamp: timestamp);
      
      // Act
      final string = result.toString();
      
      // Assert
      expect(string, contains('ScanResult'));
      expect(string, contains(content));
      expect(string, contains(timestamp.toString()));
    });
  });
}
