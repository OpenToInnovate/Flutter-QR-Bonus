import 'package:flutter/services.dart';

/// Service for clipboard operations
class ClipboardService {
  static final ClipboardService _instance = ClipboardService._internal();
  factory ClipboardService() => _instance;
  ClipboardService._internal();
  
  /// Copy text to clipboard
  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
  
  /// Check if clipboard has text
  Future<bool> hasText() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text != null && data!.text!.isNotEmpty;
  }
  
  /// Get text from clipboard
  Future<String?> getText() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text;
  }
}
