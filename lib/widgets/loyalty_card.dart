import 'package:flutter/material.dart';

/// A loyalty card widget that displays store branding and content
class LoyaltyCard extends StatelessWidget {
  /// The card content (barcode number, QR data, etc.)
  final String content;

  /// The store/brand name
  final String brand;

  /// The card's primary color
  final int cardColor;

  /// Callback when card is tapped
  final VoidCallback? onTap;

  /// Callback when card is long pressed
  final VoidCallback? onLongPress;

  const LoyaltyCard({
    super.key,
    required this.content,
    required this.brand,
    required this.cardColor,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: Color(cardColor),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
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
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: _buildStoreLogo(),
                ),
              ),
            ),

            // Card info section
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      brand,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _formatCardNumber(content),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build the store logo or brand text
  Widget _buildStoreLogo() {
    // For now, we'll use brand text. In a full implementation,
    // you could add actual logo images for each brand
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        _getBrandDisplayText(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
    );
  }

  /// Get the brand display text (handle special cases)
  String _getBrandDisplayText() {
    switch (brand.toLowerCase()) {
      case 'nectar':
        return 'nectar';
      case 'tesco':
        return 'TESCO';
      case 'marks & spencer':
        return 'M&S';
      case 'waitrose & partners':
        return 'WAITROSE\n& PARTNERS';
      default:
        return brand.toUpperCase();
    }
  }

  /// Format card number for display (show first 4 and last 4 digits)
  String _formatCardNumber(String number) {
    if (number.length <= 8) return number;

    // Remove non-digits for formatting
    final digits = number.replaceAll(RegExp(r'\D'), '');

    if (digits.length <= 8) return number;

    final first4 = digits.substring(0, 4);
    final last4 = digits.substring(digits.length - 4);

    return '$first4....$last4';
  }
}
