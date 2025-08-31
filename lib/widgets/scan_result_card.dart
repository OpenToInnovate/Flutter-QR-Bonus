import 'package:flutter/material.dart';
import '../models/scan_result.dart';

/// A card widget that displays a scan result with copy and share actions
class ScanResultCard extends StatelessWidget {
  /// The scan result to display
  final ScanResult result;
  
  /// Callback when copy button is pressed
  final VoidCallback onCopy;
  
  /// Callback when share button is pressed
  final VoidCallback onShare;
  
  /// Whether this is the latest result (affects styling)
  final bool isLatest;
  
  const ScanResultCard({
    super.key,
    required this.result,
    required this.onCopy,
    required this.onShare,
    this.isLatest = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isLatest ? 2 : 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Text(
                  isLatest ? 'Latest result' : 'Scan result',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                if (!isLatest)
                  Text(
                    _formatTimestamp(result.timestamp),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Content
            SelectableText(
              result.content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            
            // Action buttons
            Row(
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy'),
                  onPressed: onCopy,
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                  onPressed: onShare,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// Format timestamp for display
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
