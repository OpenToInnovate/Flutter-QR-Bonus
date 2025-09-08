import 'package:flutter/material.dart';
import '../models/store.dart';
import 'scanner_page.dart';

/// Page that displays available stores with search functionality
class StoreListPage extends StatefulWidget {
  const StoreListPage({super.key});

  @override
  State<StoreListPage> createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  /// Controller for the search text field
  final TextEditingController _searchController = TextEditingController();

  /// Current search query
  String _searchQuery = '';

  /// Filtered stores based on search
  List<Store> _filteredStores = StoreData.allStores;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Handle search query changes
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _filteredStores = StoreData.searchStores(_searchQuery);
    });
  }

  /// Navigate to scanner page for selected store
  Future<void> _selectStore(Store store) async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => ScannerPage(selectedStore: store),
      ),
    );

    if (!mounted) return;

    if (result != null && result.isNotEmpty) {
      Navigator.of(context).pop<String>(result);
    }
  }

  /// Handle import button tap
  void _handleImport() {
    // Navigate to scanner without specific store selection
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ScannerPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final popularStores = StoreData.popularStores;
    final allStores =
        _searchQuery.isEmpty ? StoreData.allStores : _filteredStores;

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
        title: const Text(
          'Store List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _handleImport,
            child: const Text(
              'Import',
              style: TextStyle(
                color: Color(0xFFFF6B35),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle:
                      TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),

          // Store list
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Popular cards section (only show when not searching)
                    if (_searchQuery.isEmpty) ...[
                      const Text(
                        'Most popular cards',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Popular stores list
                      ...popularStores
                          .map((store) => _buildStoreListItem(store)),

                      const SizedBox(height: 24),

                      // Add custom card option
                      _buildAddCustomCard(),

                      const SizedBox(height: 32),
                    ],

                    // All cards section
                    Text(
                      _searchQuery.isEmpty ? 'All cards' : 'Search Results',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // All stores list
                    ...allStores.map((store) => _buildStoreListItem(store)),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build a store list item
  Widget _buildStoreListItem(Store store) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: store.colorValue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              _getStoreInitials(store.name),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Text(
          store.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () => _selectStore(store),
      ),
    );
  }

  /// Build add custom card option
  Widget _buildAddCustomCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Color(0xFFFF6B35),
              size: 24,
            ),
          ),
        ),
        title: const Text(
          'Add custom card',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: _handleImport,
      ),
    );
  }

  /// Get store initials for display
  String _getStoreInitials(String name) {
    final words = name.split(' ');
    if (words.length == 1) {
      return name.length >= 2
          ? name.substring(0, 2).toUpperCase()
          : name.toUpperCase();
    }
    return words
        .take(2)
        .map((word) => word.isNotEmpty ? word[0] : '')
        .join()
        .toUpperCase();
  }
}
