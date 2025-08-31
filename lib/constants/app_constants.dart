/// Application-wide constants for the QR Scanner app
class AppConstants {
  // App metadata
  static const String appName = 'QR Bonus';
  static const String appTitle = 'QR Starter';
  
  // UI constants
  static const double scanWindowSizeRatio = 0.70; // 70% of screen size
  static const double scanWindowBorderRadius = 12.0;
  static const double scanWindowBorderWidth = 3.0;
  static const double overlayOpacity = 0.55;
  
  // Animation and feedback
  static const Duration scanDelay = Duration(milliseconds: 60);
  static const Duration snackBarDuration = Duration(seconds: 2);
  
  // Storage keys
  static const String historyKey = 'qr_scan_history';
  static const int maxHistoryItems = 100;
  
  // Messages
  static const String copiedMessage = 'Copied to clipboard';
  static const String scannedAndCopiedMessage = 'Scanned and copied';
  static const String torchNotAvailableMessage = 'Torch not available';
  static const String noSecondCameraMessage = 'No second camera';
  static const String clearHistoryTooltip = 'Clear history';
  static const String copyTooltip = 'Copy';
  static const String shareTooltip = 'Share';
  static const String toggleTorchTooltip = 'Toggle torch';
  static const String switchCameraTooltip = 'Switch camera';
  
  // Instructions
  static const String webCameraInstruction = 'Allow camera access in your browser';
  static const String mobileCameraInstruction = 'Align QR within the square';
  static const String initialInstruction = 'Tap "Scan QR" to start. The first decode returns instantly.';
  
  // Share subject
  static const String shareSubject = 'Scanned QR';
}
