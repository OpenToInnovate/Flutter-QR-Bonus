import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../services/history_service.dart';
import '../services/clipboard_service.dart';
import '../services/share_service.dart';
import '../widgets/scan_result_card.dart';
import '../widgets/history_list_tile.dart';
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

  /// Clear all scan history
  Future<void> _clearHistory() async {
    await _historyService.clear();
    if (mounted) {
      setState(() {});
    }
  }

  /// Promote a history item to the top
  Future<void> _promoteToTop(int index) async {
    await _historyService.promoteToTop(index);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final latest = _historyService.latest;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appTitle),
        actions: [
          if (!_historyService.isEmpty)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              tooltip: AppConstants.clearHistoryTooltip,
              onPressed: _clearHistory,
            ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Scan button
              FilledButton.icon(
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Scan QR'),
                onPressed: () async {
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
                        ),
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 16),
              
              // Latest result or instruction
              if (latest == null) ...[
                const Text(
                  AppConstants.initialInstruction,
                  textAlign: TextAlign.center,
                ),
              ] else ...[
                ScanResultCard(
                  result: latest,
                  onCopy: () => _copy(latest.content),
                  onShare: () => _share(latest.content),
                  isLatest: true,
                ),
              ],
              const SizedBox(height: 8),
              
              // History section
              Expanded(
                child: _historyService.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'History',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.separated(
                              itemCount: _historyService.length,
                              separatorBuilder: (_, __) => const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final result = _historyService.history[index];
                                return HistoryListTile(
                                  result: result,
                                  index: index,
                                  onTap: () => _promoteToTop(index),
                                  onCopy: () => _copy(result.content),
                                  onShare: () => _share(result.content),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
