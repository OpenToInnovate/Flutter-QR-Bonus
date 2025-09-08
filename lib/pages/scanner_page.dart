import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../constants/app_constants.dart';
import '../widgets/scan_window_overlay.dart' as custom;

/// The QR code scanner page with camera preview and scan window
class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

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

  /// Toggle the camera torch/flashlight
  Future<void> _toggleTorch() async {
    try {
      await _controller.toggleTorch();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppConstants.torchNotAvailableMessage),
            duration: AppConstants.snackBarDuration,
          ),
        );
      }
    }
  }

  /// Switch between front and back cameras
  Future<void> _switchCamera() async {
    try {
      await _controller.switchCamera();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppConstants.noSecondCameraMessage),
            duration: AppConstants.snackBarDuration,
          ),
        );
      }
    }
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
      appBar: AppBar(
        title: const Text('Point at a QR'),
        actions: [
          // Torch toggle button
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: _toggleTorch,
            tooltip: AppConstants.toggleTorchTooltip,
          ),
          // Camera switch button
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: _switchCamera,
            tooltip: AppConstants.switchCameraTooltip,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate scan window dimensions
          final size = constraints.biggest;
          final side = math.min(size.width, size.height) *
              AppConstants.scanWindowSizeRatio;
          final center = Offset(size.width / 2, size.height / 2);
          final scanRect =
              Rect.fromCenter(center: center, width: side, height: side);

          return Stack(
            fit: StackFit.expand,
            children: [
              // Camera preview with scanner
              MobileScanner(
                controller: _controller,
                scanWindow: scanRect,
                onDetect: _handleDetection,
              ),

              // Scan window overlay
              custom.ScanWindowOverlay(scanRect: scanRect),

              // Instruction text
              Positioned(
                bottom: 32,
                left: 0,
                right: 0,
                child: Text(
                  kIsWeb
                      ? AppConstants.webCameraInstruction
                      : AppConstants.mobileCameraInstruction,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    shadows: [Shadow(blurRadius: 6)],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
