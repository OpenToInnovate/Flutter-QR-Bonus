import 'package:flutter/material.dart';

import '../models/scan_result.dart';
import '../models/store.dart';
import '../services/share_service.dart';

/// Detailed view of a loyalty card with barcode and actions
class CardDetailPage extends StatefulWidget {
  final ScanResult result;

  const CardDetailPage({
    super.key,
    required this.result,
  });

  @override
  State<CardDetailPage> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  final ShareService _shareService = ShareService();

  @override
  Widget build(BuildContext context) {
    final store = StoreData.getStoreByName(widget.result.content) ?? 
                  StoreData.getStoreById('nectar')!; // Default to Nectar
    final barcodeData = _generateBarcodeData(widget.result.content);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D2D2D),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          store.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: _editCard,
            child: const Text(
              'Edit',
              style: TextStyle(
                color: Color(0xFFFF6B35),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(),
              
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
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Brand logo
                    Positioned(
                      top: 20,
                      left: 20,
                      child: _buildBrandLogo(store),
                    ),
                    
                    // Barcode section
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: _buildBarcodeSection(barcodeData),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Action buttons
              _buildActionButtons(),
              
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  /// Build brand logo based on store
  Widget _buildBrandLogo(Store store) {
    switch (store.id) {
      case 'nectar':
        return _buildNectarLogo();
      case 'tesco':
        return _buildTescoLogo();
      case 'sainsbury\'s':
      case 'sainsburys':
        return _buildSainsburysLogo();
      default:
        return _buildGenericLogo(store.name);
    }
  }

  /// Build Nectar logo
  Widget _buildNectarLogo() {
    return Container(
      width: 80,
      height: 50,
      child: Stack(
        children: [
          // Organic blob shape
          Positioned(
            left: 0,
            top: 5,
            child: Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          // Nectar text
          const Positioned(
            left: 15,
            top: 15,
            child: Text(
              'nectar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build Tesco logo
  Widget _buildTescoLogo() {
    return Container(
      width: 80,
      height: 50,
      child: const Center(
        child: Text(
          'TESCO',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  /// Build Sainsbury's logo
  Widget _buildSainsburysLogo() {
    return Container(
      width: 80,
      height: 50,
      child: const Center(
        child: Text(
          'SAINSBURY\'S',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  /// Build generic logo
  Widget _buildGenericLogo(String brand) {
    return Container(
      width: 80,
      height: 50,
      child: Center(
        child: Text(
          brand.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  /// Build barcode section
  Widget _buildBarcodeSection(Map<String, String> barcodeData) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Barcode visual
          Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(20, (index) {
                final width = (index % 3 == 0) ? 2.0 : 1.0;
                return Container(
                  width: width,
                  height: 40,
                  color: Colors.black,
                );
              }),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Primary barcode number
          Text(
            barcodeData['primary']!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Secondary barcode number
          Text(
            barcodeData['secondary']!,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  /// Build action buttons
  Widget _buildActionButtons() {
    return Column(
      children: [
        _buildActionButton(
          icon: Icons.photo_camera,
          text: 'Card Pictures',
          onTap: _showCardPictures,
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          icon: Icons.note,
          text: 'Notes',
          onTap: _showNotes,
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          icon: Icons.share,
          text: 'Share Card',
          onTap: _shareCard,
        ),
      ],
    );
  }

  /// Build individual action button
  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(
              icon,
              color: const Color(0xFFFF6B35),
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFFFF6B35),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// Generate barcode data from content
  Map<String, String> _generateBarcodeData(String content) {
    // Extract numbers from content or generate based on content hash
    final numbers = content.replaceAll(RegExp(r'[^0-9]'), '');
    
    String primary, secondary;
    
    if (numbers.length >= 13) {
      primary = numbers.substring(0, 13);
      secondary = numbers.length >= 20 ? numbers.substring(0, 20) : numbers;
    } else {
      // Generate based on content hash
      final hash = content.hashCode.abs();
      primary = '${hash.toString().padLeft(13, '0').substring(0, 13)}';
      secondary = '${hash.toString().padLeft(20, '0').substring(0, 20)}';
    }
    
    // Format with spaces
    primary = _formatBarcodeNumber(primary);
    secondary = _formatBarcodeNumber(secondary);
    
    return {
      'primary': primary,
      'secondary': secondary,
    };
  }

  /// Format barcode number with spaces
  String _formatBarcodeNumber(String number) {
    if (number.length <= 4) return number;
    
    final parts = <String>[];
    for (int i = 0; i < number.length; i += 4) {
      final end = (i + 4 < number.length) ? i + 4 : number.length;
      parts.add(number.substring(i, end));
    }
    
    return parts.join(' ');
  }

  /// Edit card functionality
  void _editCard() {
    // TODO: Implement edit functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit functionality coming soon'),
        backgroundColor: Color(0xFF2D2D2D),
      ),
    );
  }

  /// Show card pictures
  void _showCardPictures() {
    // TODO: Implement card pictures functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Card pictures functionality coming soon'),
        backgroundColor: Color(0xFF2D2D2D),
      ),
    );
  }

  /// Show notes
  void _showNotes() {
    // TODO: Implement notes functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notes functionality coming soon'),
        backgroundColor: Color(0xFF2D2D2D),
      ),
    );
  }

  /// Share card
  Future<void> _shareCard() async {
    await _shareService.shareText(widget.result.content);
  }
}
