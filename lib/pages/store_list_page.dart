import 'package:flutter/material.dart';

import '../models/store.dart';
import 'scanner_page.dart';

/// Page showing list of available stores for card creation
class StoreListPage extends StatefulWidget {
  const StoreListPage({super.key});

  @override
  State<StoreListPage> createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Store> _filteredStores = StoreData.allStores;
  bool _showPopularOnly = true;

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

  void _onSearchChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredStores = _showPopularOnly ? StoreData.popularStores : StoreData.allStores;
      } else {
        _filteredStores = StoreData.searchStores(_searchController.text);
      }
    });
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
          'Store List',
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
        actions: [
          TextButton(
            onPressed: _importCards,
            child: const Text(
              'Import',
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
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white70,
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

            // Content
            Expanded(
              child: _searchController.text.isEmpty
                  ? _buildDefaultView()
                  : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  /// Build default view with popular and all cards sections
  Widget _buildDefaultView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Most popular cards section
          const Text(
            'Most popular cards',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          // Popular stores grid
          _buildStoreGrid(StoreData.popularStores),
          
          const SizedBox(height: 24),
          
          // Add custom card button
          _buildAddCustomCardButton(),
          
          const SizedBox(height: 24),
          
          // All cards section
          const Text(
            'All cards',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          // All stores list
          _buildStoreList(StoreData.allStores),
        ],
      ),
    );
  }

  /// Build search results view
  Widget _buildSearchResults() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Results (${_filteredStores.length})',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildStoreList(_filteredStores),
          ),
        ],
      ),
    );
  }

  /// Build store grid for popular stores
  Widget _buildStoreGrid(List<Store> stores) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.5,
      ),
      itemCount: stores.length,
      itemBuilder: (context, index) {
        final store = stores[index];
        return _buildStoreCard(store);
      },
    );
  }

  /// Build store list for all stores
  Widget _buildStoreList(List<Store> stores) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stores.length,
      itemBuilder: (context, index) {
        final store = stores[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildStoreCard(store),
        );
      },
    );
  }

  /// Build individual store card
  Widget _buildStoreCard(Store store) {
    return GestureDetector(
      onTap: () => _selectStore(store),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: store.colorValue,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            // Store logo
            _buildStoreLogo(store),
            const SizedBox(width: 12),
            // Store name
            Expanded(
              child: Text(
                store.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  /// Build store logo based on store ID
  Widget _buildStoreLogo(Store store) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: _getStoreLogoWidget(store),
      ),
    );
  }

  /// Get store-specific logo widget
  Widget _getStoreLogoWidget(Store store) {
    switch (store.id) {
      case 'nectar':
        return _buildNectarLogo();
      case 'tesco':
        return const Text(
          'TESCO',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'boots':
        return const Text(
          'Boots',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        );
      case 'superdrug':
        return const Text(
          'Superdrug',
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'morrisons':
        return const Text(
          'Morrisons',
          style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'marks_spencer':
        return const Text(
          'M&S',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'coop':
        return const Text(
          'co op',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'waitrose':
        return const Text(
          'WAITROSE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        );
      case '99_ranch':
        return const Text(
          '99',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'starbucks':
        return const Icon(
          Icons.local_cafe,
          color: Colors.white,
          size: 20,
        );
      case 'mcdonalds':
        return const Text(
          'M',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'subway':
        return const Text(
          'S',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'costa':
        return const Icon(
          Icons.local_cafe,
          color: Colors.white,
          size: 20,
        );
      case 'pret':
        return const Text(
          'P',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'kfc':
        return const Text(
          'KFC',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'burger_king':
        return const Text(
          'BK',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'pizza_hut':
        return const Text(
          'PH',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'dominos':
        return const Text(
          'D',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'argos':
        return const Text(
          'A',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'currys':
        return const Text(
          'C',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'john_lewis':
        return const Text(
          'JL',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'next':
        return const Text(
          'N',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'primark':
        return const Text(
          'P',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'h&m':
        return const Text(
          'H&M',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'zara':
        return const Text(
          'Z',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'uniqlo':
        return const Text(
          'U',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        );
      default:
        return Text(
          store.name.substring(0, 1).toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        );
    }
  }

  /// Build Nectar logo
  Widget _buildNectarLogo() {
    return Container(
      width: 30,
      height: 20,
      child: Stack(
        children: [
          // Organic blob shape
          Positioned(
            left: 0,
            top: 2,
            child: Container(
              width: 25,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          // Nectar text
          const Positioned(
            left: 5,
            top: 5,
            child: Text(
              'nectar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build add custom card button
  Widget _buildAddCustomCardButton() {
    return GestureDetector(
      onTap: _addCustomCard,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Container(
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
            const SizedBox(width: 16),
            const Text(
              'Add custom card',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Select a store and navigate to scanner
  void _selectStore(Store store) async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => ScannerPage(selectedStore: store),
      ),
    );
    
    if (result != null && result.isNotEmpty && mounted) {
      Navigator.of(context).pop<String>(result);
    }
  }

  /// Add custom card
  void _addCustomCard() async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => const ScannerPage(),
      ),
    );
    
    if (result != null && result.isNotEmpty && mounted) {
      Navigator.of(context).pop<String>(result);
    }
  }

  /// Import cards functionality
  void _importCards() {
    // TODO: Implement import functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Import functionality coming soon'),
        backgroundColor: Color(0xFF2D2D2D),
      ),
    );
  }
}
