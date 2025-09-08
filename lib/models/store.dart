import 'package:flutter/material.dart';

/// Represents a store/brand with its visual identity
class Store {
  /// Unique identifier for the store
  final String id;

  /// Display name of the store
  final String name;

  /// Primary brand color
  final int color;

  /// Secondary color (optional)
  final int? secondaryColor;

  /// Whether this store is in the popular list
  final bool isPopular;

  /// Keywords for search functionality
  final List<String> keywords;

  /// Store category
  final StoreCategory category;

  const Store({
    required this.id,
    required this.name,
    required this.color,
    this.secondaryColor,
    this.isPopular = false,
    this.keywords = const [],
    this.category = StoreCategory.other,
  });

  /// Get color as Flutter Color
  Color get colorValue => Color(color);

  /// Get secondary color as Flutter Color (if available)
  Color? get secondaryColorValue =>
      secondaryColor != null ? Color(secondaryColor!) : null;
}

/// Categories for organizing stores
enum StoreCategory {
  supermarket,
  pharmacy,
  clothing,
  electronics,
  restaurant,
  other,
}

/// Predefined stores with their brand identities
class StoreData {
  static const List<Store> allStores = [
    // Most Popular Cards
    Store(
      id: 'nectar',
      name: 'Nectar',
      color: 0xFF6B46C1, // Purple
      isPopular: true,
      keywords: ['nectar', 'sainsbury', 'sainsburys'],
      category: StoreCategory.supermarket,
    ),
    Store(
      id: 'tesco',
      name: 'Tesco',
      color: 0xFF1E40AF, // Blue
      isPopular: true,
      keywords: ['tesco', 'clubcard'],
      category: StoreCategory.supermarket,
    ),
    Store(
      id: 'boots',
      name: 'Boots',
      color: 0xFF1E3A8A, // Dark Blue
      isPopular: true,
      keywords: ['boots', 'advantage'],
      category: StoreCategory.pharmacy,
    ),
    Store(
      id: 'superdrug',
      name: 'Superdrug',
      color: 0xFF1F2937, // Dark Grey
      secondaryColor: 0xFFEC4899, // Pink
      isPopular: true,
      keywords: ['superdrug', 'beauty'],
      category: StoreCategory.pharmacy,
    ),
    Store(
      id: 'morrisons',
      name: 'Morrisons',
      color: 0xFF059669, // Green
      secondaryColor: 0xFFFCD34D, // Yellow
      isPopular: true,
      keywords: ['morrisons', 'more'],
      category: StoreCategory.supermarket,
    ),
    Store(
      id: 'marks_spencer',
      name: 'Marks & Spencer',
      color: 0xFF064E3B, // Dark Green
      isPopular: true,
      keywords: ['marks', 'spencer', 'm&s', 'ms'],
      category: StoreCategory.clothing,
    ),
    Store(
      id: 'coop',
      name: 'Co-op',
      color: 0xFF0EA5E9, // Light Blue
      isPopular: true,
      keywords: ['coop', 'co-op', 'cooperative'],
      category: StoreCategory.supermarket,
    ),
    Store(
      id: 'waitrose',
      name: 'Waitrose & Partners',
      color: 0xFF059669, // Green
      isPopular: true,
      keywords: ['waitrose', 'partners', 'mywaitrose'],
      category: StoreCategory.supermarket,
    ),

    // All Cards
    Store(
      id: '99_ranch',
      name: '99 Ranch Market',
      color: 0xFFDC2626, // Red
      keywords: ['99', 'ranch', 'market', 'asian'],
      category: StoreCategory.supermarket,
    ),
    Store(
      id: 'asda',
      name: 'ASDA',
      color: 0xFF1E40AF, // Blue
      keywords: ['asda', 'asda rewards'],
      category: StoreCategory.supermarket,
    ),
    Store(
      id: 'aldi',
      name: 'ALDI',
      color: 0xFF1E40AF, // Blue
      keywords: ['aldi'],
      category: StoreCategory.supermarket,
    ),
    Store(
      id: 'lidl',
      name: 'LIDL',
      color: 0xFF1E40AF, // Blue
      keywords: ['lidl'],
      category: StoreCategory.supermarket,
    ),
    Store(
      id: 'iceland',
      name: 'Iceland',
      color: 0xFF0EA5E9, // Light Blue
      keywords: ['iceland', 'bonus'],
      category: StoreCategory.supermarket,
    ),
    Store(
      id: 'starbucks',
      name: 'Starbucks',
      color: 0xFF036635, // Dark Green
      keywords: ['starbucks', 'rewards'],
      category: StoreCategory.restaurant,
    ),
    Store(
      id: 'mcdonalds',
      name: 'McDonald\'s',
      color: 0xFFDC2626, // Red
      keywords: ['mcdonalds', 'mcdonald', 'mcd'],
      category: StoreCategory.restaurant,
    ),
    Store(
      id: 'subway',
      name: 'Subway',
      color: 0xFF059669, // Green
      keywords: ['subway', 'subway rewards'],
      category: StoreCategory.restaurant,
    ),
    Store(
      id: 'costa',
      name: 'Costa Coffee',
      color: 0xFF7C2D12, // Brown
      keywords: ['costa', 'coffee', 'costa club'],
      category: StoreCategory.restaurant,
    ),
    Store(
      id: 'pret',
      name: 'Pret A Manger',
      color: 0xFF7C3AED, // Violet
      keywords: ['pret', 'manger', 'pret club'],
      category: StoreCategory.restaurant,
    ),
    Store(
      id: 'kfc',
      name: 'KFC',
      color: 0xFFDC2626, // Red
      keywords: ['kfc', 'kentucky'],
      category: StoreCategory.restaurant,
    ),
    Store(
      id: 'burger_king',
      name: 'Burger King',
      color: 0xFFFF6B35, // Orange
      keywords: ['burger', 'king', 'bk'],
      category: StoreCategory.restaurant,
    ),
    Store(
      id: 'pizza_hut',
      name: 'Pizza Hut',
      color: 0xFFDC2626, // Red
      keywords: ['pizza', 'hut'],
      category: StoreCategory.restaurant,
    ),
    Store(
      id: 'dominos',
      name: 'Domino\'s',
      color: 0xFF1E40AF, // Blue
      keywords: ['dominos', 'domino'],
      category: StoreCategory.restaurant,
    ),
    Store(
      id: 'argos',
      name: 'Argos',
      color: 0xFF1E40AF, // Blue
      keywords: ['argos'],
      category: StoreCategory.electronics,
    ),
    Store(
      id: 'currys',
      name: 'Currys',
      color: 0xFF1E40AF, // Blue
      keywords: ['currys', 'pc world'],
      category: StoreCategory.electronics,
    ),
    Store(
      id: 'john_lewis',
      name: 'John Lewis',
      color: 0xFF1E40AF, // Blue
      keywords: ['john', 'lewis', 'partnership'],
      category: StoreCategory.clothing,
    ),
    Store(
      id: 'next',
      name: 'Next',
      color: 0xFF1F2937, // Dark Grey
      keywords: ['next'],
      category: StoreCategory.clothing,
    ),
    Store(
      id: 'primark',
      name: 'Primark',
      color: 0xFF1E40AF, // Blue
      keywords: ['primark'],
      category: StoreCategory.clothing,
    ),
    Store(
      id: 'h&m',
      name: 'H&M',
      color: 0xFFDC2626, // Red
      keywords: ['h&m', 'hm', 'hennes'],
      category: StoreCategory.clothing,
    ),
    Store(
      id: 'zara',
      name: 'Zara',
      color: 0xFF1F2937, // Dark Grey
      keywords: ['zara'],
      category: StoreCategory.clothing,
    ),
    Store(
      id: 'uniqlo',
      name: 'Uniqlo',
      color: 0xFFDC2626, // Red
      keywords: ['uniqlo'],
      category: StoreCategory.clothing,
    ),
  ];

  /// Get popular stores
  static List<Store> get popularStores =>
      allStores.where((store) => store.isPopular).toList();

  /// Search stores by query
  static List<Store> searchStores(String query) {
    if (query.isEmpty) return allStores;

    final lowercaseQuery = query.toLowerCase();
    return allStores.where((store) {
      return store.name.toLowerCase().contains(lowercaseQuery) ||
          store.keywords.any((keyword) => keyword.contains(lowercaseQuery));
    }).toList();
  }

  /// Get store by ID
  static Store? getStoreById(String id) {
    try {
      return allStores.firstWhere((store) => store.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get store by name (fuzzy matching)
  static Store? getStoreByName(String name) {
    final lowercaseName = name.toLowerCase();

    // Exact match first
    for (final store in allStores) {
      if (store.name.toLowerCase() == lowercaseName) {
        return store;
      }
    }

    // Keyword match
    for (final store in allStores) {
      if (store.keywords.any((keyword) => keyword == lowercaseName)) {
        return store;
      }
    }

    // Partial match
    for (final store in allStores) {
      if (store.name.toLowerCase().contains(lowercaseName) ||
          store.keywords.any((keyword) => keyword.contains(lowercaseName))) {
        return store;
      }
    }

    return null;
  }
}
