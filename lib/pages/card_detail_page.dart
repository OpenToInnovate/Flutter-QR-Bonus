import 'package:flutter/material.dart';
import '../models/scan_result.dart';
import '../models/store.dart';
import '../services/share_service.dart';

/// Page that displays detailed view of a loyalty card with barcode
class CardDetailPage extends StatelessWidget {
  /// The scan result to display
  final ScanResult result;

  const CardDetailPage({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    // Get store information or use default
    final store = StoreData.getStoreByName(result.content) ??
        StoreData.getStoreById('nectar')!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D2D2D),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          store.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => _editCard(context),
            child: const Text(
              'Edit',
              style: TextStyle(
                color: Color(0xFFFF6B35),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Main card display
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                color: store.colorValue,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Store branding section
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          _getStoreBrandText(store.name),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                  // Barcode section
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Barcode visualization
                          Container(
                            height: 60,
                            width: double.infinity,
                            child: CustomPaint(
                              painter: BarcodePainter(),
                              child: const SizedBox.expand(),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Primary card number
                          Text(
                            _formatPrimaryNumber(result.content),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),

                          const SizedBox(height: 4),

                          // Secondary number (if different format)
                          if (_hasSecondaryNumber(result.content))
                            Text(
                              _formatSecondaryNumber(result.content),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Action buttons
            Column(
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.photo_library,
                  label: 'Card Pictures',
                  onTap: () => _showCardPictures(context),
                ),
                const SizedBox(height: 16),
                _buildActionButton(
                  context,
                  icon: Icons.note,
                  label: 'Notes',
                  onTap: () => _showNotes(context),
                ),
                const SizedBox(height: 16),
                _buildActionButton(
                  context,
                  icon: Icons.share,
                  label: 'Share Card',
                  onTap: () => _shareCard(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build an action button
  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFFFF6B35),
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: Colors.white.withValues(alpha: 0.6),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  /// Get store brand display text
  String _getStoreBrandText(String name) {
    switch (name.toLowerCase()) {
      case 'nectar':
        return 'nectar';
      case 'tesco':
        return 'TESCO';
      case 'marks & spencer':
        return 'M&S';
      case 'waitrose & partners':
        return 'WAITROSE\n& PARTNERS';
      default:
        return name.toUpperCase();
    }
  }

  /// Format the primary display number
  String _formatPrimaryNumber(String content) {
    // Remove non-digits
    final digits = content.replaceAll(RegExp(r'\D'), '');

    if (digits.length >= 13) {
      // Format as groups of 4 digits
      final groups = <String>[];
      for (int i = 0; i < digits.length; i += 4) {
        final end = (i + 4 < digits.length) ? i + 4 : digits.length;
        groups.add(digits.substring(i, end));
      }
      return groups.join(' ');
    }

    return content;
  }

  /// Check if there's a secondary number format
  bool _hasSecondaryNumber(String content) {
    final digits = content.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 13;
  }

  /// Format the secondary number (alternative format)
  String _formatSecondaryNumber(String content) {
    final digits = content.replaceAll(RegExp(r'\D'), '');
    if (digits.length >= 13) {
      return digits;
    }
    return '';
  }

  /// Handle edit card action
  void _editCard(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit functionality coming soon'),
        backgroundColor: Color(0xFF2D2D2D),
      ),
    );
  }

  /// Handle card pictures action
  void _showCardPictures(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Card pictures functionality coming soon'),
        backgroundColor: Color(0xFF2D2D2D),
      ),
    );
  }

  /// Handle notes action
  void _showNotes(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notes functionality coming soon'),
        backgroundColor: Color(0xFF2D2D2D),
      ),
    );
  }

  /// Handle share card action
  Future<void> _shareCard(BuildContext context) async {
    try {
      final shareService = ShareService();
      await shareService.shareText(result.content);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing: $e'),
            backgroundColor: const Color(0xFF2D2D2D),
          ),
        );
      }
    }
  }
}

/// Custom painter for drawing barcode lines
class BarcodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    final random = [
      1,
      3,
      2,
      1,
      2,
      3,
      1,
      2,
      3,
      2,
      1,
      3,
      2,
      1,
      2,
      3,
      1,
      2,
      3,
      2,
      1,
      3,
      1,
      2,
      3,
      2,
      1
    ];
    double currentX = 0;
    final barWidth = size.width / 100;

    for (int i = 0; i < random.length; i++) {
      final width = barWidth * random[i];

      if (i % 2 == 0) {
        // Draw black bar
        canvas.drawRect(
          Rect.fromLTWH(currentX, 0, width, size.height),
          paint,
        );
      }

      currentX += width;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
