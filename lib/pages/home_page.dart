import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../models/scan_result.dart';
import '../services/history_service.dart';
import '../services/clipboard_service.dart';
import '../services/share_service.dart';
import '../widgets/loyalty_card.dart';
import 'scanner_page.dart';

/// The main home page of the QR scanner app
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Service for managing scan history
  final HistoryService _historyService = HistoryService();

  /// Service for clipboard operations
  final ClipboardService _clipboardService = ClipboardService();

  /// Service for sharing content
  final ShareService _shareService = ShareService();

  /// Whether the services have been initialized
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  /// Initialize all services
  Future<void> _initializeServices() async {
    await _historyService.initialize();
    if (mounted) {
      setState(() {
        _initialized = true;
      });
    }
  }

  /// Add a new scan result to history
  Future<void> _addResult(String value) async {
    await _historyService.addResult(value);
    if (mounted) {
      setState(() {});
    }
  }

  /// Copy text to clipboard and show feedback
  Future<void> _copy(String text) async {
    await _clipboardService.copyToClipboard(text);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppConstants.copiedMessage),
          duration: AppConstants.snackBarDuration,
        ),
      );
    }
  }

  /// Share text content
  Future<void> _share(String text) async {
    await _shareService.shareText(text);
  }


  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header with orange cloud icon and red plus button
            Container(
              height: 60,
              color: const Color(0xFF2D2D2D),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Orange cloud icon with checkmark
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6B35),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Cards title
                  const Text(
                    'Cards',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  // Red plus button
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.of(context).push<String>(
                        MaterialPageRoute(builder: (_) => const ScannerPage()),
                      );
                      if (!mounted) return;
                      if (result != null && result.isNotEmpty) {
                        await _addResult(result);
                        // Auto-copy the scanned result
                        await _clipboardService.copyToClipboard(result);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(AppConstants.scannedAndCopiedMessage),
                              duration: AppConstants.snackBarDuration,
                              backgroundColor: Color(0xFF2D2D2D),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE53E3E),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Cards grid
            Expanded(
              child: _historyService.isEmpty
                  ? const Center(
                      child: Text(
                        'No cards yet\nTap the + button to scan a QR code',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.6,
                        ),
                        itemCount: _historyService.length,
                        itemBuilder: (context, index) {
                          final result = _historyService.history[index];
                          // Extract brand name from content or use a default
                          String brand = _extractBrandName(result.content);
                          Color cardColor = _getCardColor(index);
                          
                          return LoyaltyCard(
                            content: result.content,
                            brand: brand,
                            cardColor: cardColor,
                            onTap: () => _copy(result.content),
                            onLongPress: () => _showCardOptions(context, result, index),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// Extract brand name from QR content
  String _extractBrandName(String content) {
    // Try to extract meaningful brand names from common QR patterns
    if (content.toLowerCase().contains('nectar')) return 'nectar';
    if (content.toLowerCase().contains('starbucks')) return 'Starbucks';
    if (content.toLowerCase().contains('mcdonalds')) return 'McDonald\'s';
    if (content.toLowerCase().contains('subway')) return 'Subway';
    if (content.toLowerCase().contains('costa')) return 'Costa';
    if (content.toLowerCase().contains('pret')) return 'Pret';
    if (content.toLowerCase().contains('tesco')) return 'Tesco';
    if (content.toLowerCase().contains('sainsbury')) return 'Sainsbury\'s';
    if (content.toLowerCase().contains('asda')) return 'ASDA';
    if (content.toLowerCase().contains('morrisons')) return 'Morrisons';
    
    // If it's a URL, try to extract domain
    if (content.startsWith('http')) {
      try {
        final uri = Uri.parse(content);
        final host = uri.host.toLowerCase();
        if (host.contains('.')) {
          return host.split('.').first;
        }
        return host;
      } catch (e) {
        // Fall through to default
      }
    }
    
    // Default to first word or truncated content
    final words = content.split(' ');
    if (words.isNotEmpty && words.first.length > 1) {
      return words.first.length > 10 
          ? '${words.first.substring(0, 10)}...'
          : words.first;
    }
    
    return content.length > 10 ? '${content.substring(0, 10)}...' : content;
  }

  /// Get card color based on index
  Color _getCardColor(int index) {
    const colors = [
      Color(0xFF6B46C1), // Purple (nectar-like)
      Color(0xFF059669), // Green
      Color(0xFFDC2626), // Red
      Color(0xFF2563EB), // Blue
      Color(0xFF7C3AED), // Violet
      Color(0xFFEA580C), // Orange
      Color(0xFF0891B2), // Cyan
      Color(0xFFBE185D), // Pink
    ];
    return colors[index % colors.length];
  }

  /// Show options for a card
  void _showCardOptions(BuildContext context, ScanResult result, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2D2D2D),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.copy, color: Colors.white),
              title: const Text('Copy', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _copy(result.content);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.white),
              title: const Text('Share', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _share(result.content);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _deleteCard(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Delete a specific card
  Future<void> _deleteCard(int index) async {
    await _historyService.removeAt(index);
    if (mounted) {
      setState(() {});
    }
  }
}
