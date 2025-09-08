import 'package:flutter/material.dart';
import '../models/scan_result.dart';
import '../constants/app_constants.dart';

/// A list tile widget for displaying scan results in the history list
class HistoryListTile extends StatelessWidget {
  /// The scan result to display
  final ScanResult result;

  /// The index of this item in the list
  final int index;

  /// Callback when the tile is tapped
  final VoidCallback onTap;

  /// Callback when copy button is pressed
  final VoidCallback onCopy;

  /// Callback when share button is pressed
  final VoidCallback onShare;

  const HistoryListTile({
    super.key,
    required this.result,
    required this.index,
    required this.onTap,
    required this.onCopy,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.history),
      title: Text(
        result.content,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        _formatTimestamp(result.timestamp),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
      ),
      onTap: onTap,
      trailing: Wrap(
        spacing: 4,
        children: [
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: AppConstants.copyTooltip,
            onPressed: onCopy,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: AppConstants.shareTooltip,
            onPressed: onShare,
          ),
        ],
      ),
    );
  }

  /// Format timestamp for display with full word format
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
}
