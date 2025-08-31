import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_qr_bonus/services/share_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('ShareService', () {
    late ShareService shareService;
    
    setUp(() {
      shareService = ShareService();
    });
    
    test('should share text with default subject', () async {
      // Arrange
      const testText = 'test share content';
      
      // Act & Assert - Should not throw
      expect(() => shareService.shareText(testText), returnsNormally);
    });
    
    test('should share text with custom subject', () async {
      // Arrange
      const testText = 'test share content';
      const customSubject = 'Custom Subject';
      
      // Act & Assert - Should not throw
      expect(() => shareService.shareTextWithSubject(testText, customSubject), returnsNormally);
    });
    
    test('should handle empty text', () async {
      // Act & Assert - Should not throw
      expect(() => shareService.shareText(''), returnsNormally);
    });
    
    test('should handle long text', () async {
      // Arrange
      final longText = 'a' * 10000; // 10KB of text
      
      // Act & Assert - Should not throw
      expect(() => shareService.shareText(longText), returnsNormally);
    });
    
    test('should handle special characters', () async {
      // Arrange
      const specialText = 'Special chars: !@#\$%^&*()_+-=[]{}|;:,.<>?';
      
      // Act & Assert - Should not throw
      expect(() => shareService.shareText(specialText), returnsNormally);
    });
    
    test('should handle unicode characters', () async {
      // Arrange
      const unicodeText = 'Unicode: 🚀🌟🎉中文日本語한국어';
      
      // Act & Assert - Should not throw
      expect(() => shareService.shareText(unicodeText), returnsNormally);
    });
    
    test('should handle empty subject', () async {
      // Arrange
      const testText = 'test content';
      const emptySubject = '';
      
      // Act & Assert - Should not throw
      expect(() => shareService.shareTextWithSubject(testText, emptySubject), returnsNormally);
    });
  });
}
