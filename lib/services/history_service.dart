import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/scan_result.dart';
import '../constants/app_constants.dart';

/// Service for managing scan history with persistent storage
class HistoryService {
  static final HistoryService _instance = HistoryService._internal();
  factory HistoryService() => _instance;
  HistoryService._internal();

  /// Internal list of scan results
  final List<ScanResult> _history = [];

  /// Get all scan results (most recent first)
  List<ScanResult> get history => List.unmodifiable(_history);

  /// Get the most recent scan result
  ScanResult? get latest => _history.isEmpty ? null : _history.first;

  /// Check if history is empty
  bool get isEmpty => _history.isEmpty;

  /// Get history count
  int get length => _history.length;

  /// Initialize the service and load history from storage
  Future<void> initialize() async {
    await _loadHistory();
  }

  /// Add a new scan result to history
  Future<void> addResult(String content) async {
    final result = ScanResult.now(content);

    // Remove duplicate if it exists (to move it to top)
    _history.removeWhere((item) => item.content == content);

    // Add to beginning of list
    _history.insert(0, result);

    // Limit history size
    if (_history.length > AppConstants.maxHistoryItems) {
      _history.removeRange(AppConstants.maxHistoryItems, _history.length);
    }

    await _saveHistory();
  }

  /// Remove a result from history by index
  Future<void> removeAt(int index) async {
    if (index >= 0 && index < _history.length) {
      _history.removeAt(index);
      await _saveHistory();
    }
  }

  /// Clear all history
  Future<void> clear() async {
    _history.clear();
    await _saveHistory();
  }

  /// Promote a result to the top of history
  Future<void> promoteToTop(int index) async {
    if (index >= 0 && index < _history.length) {
      final result = _history.removeAt(index);
      _history.insert(0, result);
      await _saveHistory();
    }
  }

  /// Load history from SharedPreferences
  Future<void> _loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(AppConstants.historyKey);

      if (historyJson != null) {
        final List<dynamic> historyList = json.decode(historyJson);
        _history.clear();
        _history.addAll(historyList
            .map((json) => ScanResult.fromJson(json as Map<String, dynamic>)));
      }
    } catch (e) {
      // If loading fails, start with empty history
      // This handles cases where SharedPreferences is corrupted or JSON is malformed
      _history.clear();
    }
  }

  /// Save history to SharedPreferences
  Future<void> _saveHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson =
          json.encode(_history.map((result) => result.toJson()).toList());
      await prefs.setString(AppConstants.historyKey, historyJson);
    } catch (e) {
      // Handle save error silently - history will be lost on app restart
      // This could happen if SharedPreferences is unavailable or device storage is full
      // In a production app, you might want to log this error or notify the user
    }
  }
}
