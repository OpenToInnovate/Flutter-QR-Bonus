import 'package:flutter/material.dart';

/// A loyalty card widget that displays QR code scan results as cards
class LoyaltyCard extends StatelessWidget {
  /// The content of the QR code
  final String content;
  
  /// The brand/name to display on the card
  final String brand;
  
  /// The color of the card
  final Color cardColor;
  
  /// Callback when the card is tapped
  final VoidCallback? onTap;
  
  /// Callback when the card is long pressed
  final VoidCallback? onLongPress;

  const LoyaltyCard({
    super.key,
    required this.content,
    required this.brand,
    this.cardColor = const Color(0xFF6B46C1), // Default purple
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: 160,
        height: 100,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background pattern/design
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            // Brand name
            Positioned(
              bottom: 16,
              left: 16,
              child: Text(
                brand,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // QR code indicator
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.qr_code,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
