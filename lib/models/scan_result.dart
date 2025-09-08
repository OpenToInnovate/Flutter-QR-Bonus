/// Represents a QR code scan result with timestamp
class ScanResult {
  /// The scanned QR code content
  final String content;

  /// When the scan was performed
  final DateTime timestamp;

  /// Creates a new scan result
  const ScanResult({
    required this.content,
    required this.timestamp,
  });

  /// Creates a scan result with current timestamp
  factory ScanResult.now(String content) {
    return ScanResult(
      content: content,
      timestamp: DateTime.now(),
    );
  }

  /// Converts to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  /// Creates from JSON
  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      content: json['content'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScanResult &&
        other.content == content &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode => content.hashCode ^ timestamp.hashCode;

  @override
  String toString() {
    return 'ScanResult(content: $content, timestamp: $timestamp)';
  }
}
