import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_constants.dart';
import '../models/store.dart';

/// The QR code scanner page with camera preview and scan window
class ScannerPage extends StatefulWidget {
  final Store? selectedStore;

  const ScannerPage({super.key, this.selectedStore});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  /// Mobile scanner controller for camera operations
  late final MobileScannerController _controller;

  /// Flag to prevent multiple scan handling
  bool _handled = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  /// Initialize the mobile scanner controller
  void _initializeController() {
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      formats: const [BarcodeFormat.qrCode],
      facing: CameraFacing.back,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Handle QR code detection
  Future<void> _handleDetection(BarcodeCapture capture) async {
    // Prevent multiple handling of the same scan
    if (_handled) return;

    final codes = capture.barcodes;
    if (codes.isEmpty) return;

    final value = codes.first.rawValue;
    if (value == null || value.isEmpty) return;

    _handled = true;

    // Provide haptic feedback
    try {
      await HapticFeedback.mediumImpact();
    } catch (_) {
      // Haptic feedback is not available on all devices
    }

    // Small delay to ensure haptic feedback is felt
    await Future<void>.delayed(AppConstants.scanDelay);

    if (mounted) {
      Navigator.of(context).pop<String>(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D2D2D),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Scanner',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;
          final center = Offset(size.width / 2, size.height / 2);

          // Calculate scan rectangle dimensions
          final scanWidth = size.width * 0.8;
          final scanHeight = size.height * 0.4;
          final scanRect = Rect.fromCenter(
            center: center,
            width: scanWidth,
            height: scanHeight,
          );

          return Stack(
            fit: StackFit.expand,
            children: [
              // Camera preview with scanner
              MobileScanner(
                controller: _controller,
                scanWindow: scanRect,
                onDetect: _handleDetection,
              ),

              // Dark overlay with phone icon and scan rectangle
              Container(
                color: const Color(0xFF1A1A2E).withValues(alpha: 0.8),
                child: Column(
                  children: [
                    const Spacer(flex: 2),

                    // Phone icon with scanning animation
                    Container(
                      width: 80,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A4A4A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1),
                      ),
                      child: Stack(
                        children: [
                          // Phone notch
                          Positioned(
                            top: 8,
                            left: 20,
                            right: 20,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          // Scanning circle
                          Positioned(
                            top: 30,
                            left: 30,
                            right: 30,
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2D2D2D),
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 1),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.qr_code_scanner,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          ),
                          // Barcode pattern
                          Positioned(
                            bottom: 20,
                            left: 15,
                            right: 15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                  8,
                                  (index) => Container(
                                        width: 2,
                                        height: 20,
                                        color:
                                            Colors.white.withValues(alpha: 0.7),
                                      )),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Scan rectangle outline
                    Container(
                      width: scanWidth,
                      height: scanHeight,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: MobileScanner(
                          controller: _controller,
                          scanWindow: scanRect,
                          onDetect: _handleDetection,
                        ),
                      ),
                    ),

                    const Spacer(flex: 2),

                    // Action buttons
                    Column(
                      children: [
                        GestureDetector(
                          onTap: _showManualEntry,
                          child: const Text(
                            'Enter manually',
                            style: TextStyle(
                              color: Color(0xFFFF6B35),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: _importScreenshot,
                          child: const Text(
                            'Import screenshot',
                            style: TextStyle(
                              color: Color(0xFFFF6B35),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Show manual entry dialog
  void _showManualEntry() {
    showDialog(
      context: context,
      builder: (context) => const ManualEntryDialog(),
    );
  }

  /// Import screenshot from gallery
  Future<void> _importScreenshot() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // Here you would typically process the image to extract QR/barcode data
        // For now, we'll just show a placeholder message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Screenshot import feature coming soon'),
              backgroundColor: Color(0xFF2D2D2D),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error importing image: $e'),
            backgroundColor: const Color(0xFF2D2D2D),
          ),
        );
      }
    }
  }
}

/// Dialog for manual entry of QR/barcode data
class ManualEntryDialog extends StatefulWidget {
  const ManualEntryDialog({super.key});

  @override
  State<ManualEntryDialog> createState() => _ManualEntryDialogState();
}

class _ManualEntryDialogState extends State<ManualEntryDialog> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus the text field when dialog opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Spacer(),
                TextButton(
                  onPressed:
                      _controller.text.trim().isNotEmpty ? _saveEntry : null,
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Color(0xFFFF6B35),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Brand banner (TESCO style)
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF1E40AF), // Blue color like TESCO
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'TESCO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Card number input
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Card Number',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Text input field
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter your card number',
                hintStyle:
                    TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {
                setState(() {}); // Rebuild to update save button state
              },
            ),

            const SizedBox(height: 24),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    _controller.text.trim().isNotEmpty ? _saveEntry : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveEntry() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      Navigator.of(context).pop<String>(text);
    }
  }
}
