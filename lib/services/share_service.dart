import 'package:share_plus/share_plus.dart';
import '../constants/app_constants.dart';

/// Service for sharing content
class ShareService {
  static final ShareService _instance = ShareService._internal();
  factory ShareService() => _instance;
  ShareService._internal();
  
  /// Share text content
  Future<void> shareText(String text) async {
    if (text.isEmpty) {
      throw ArgumentError('Text cannot be empty');
    }
    await SharePlus.instance.share(
      ShareParams(
        text: text,
        subject: AppConstants.shareSubject,
      ),
    );
  }
  
  /// Share text with custom subject
  Future<void> shareTextWithSubject(String text, String subject) async {
    await SharePlus.instance.share(
      ShareParams(
        text: text,
        subject: subject,
      ),
    );
  }
}
