import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bonus/models/store.dart';

void main() {
  group('Store', () {
    test('creates store with all properties', () {
      const store = Store(
        id: 'test',
        name: 'Test Store',
        color: 0xFF123456,
        secondaryColor: 0xFF654321,
        isPopular: true,
        keywords: ['test', 'store'],
        category: StoreCategory.supermarket,
      );

      expect(store.id, equals('test'));
      expect(store.name, equals('Test Store'));
      expect(store.color, equals(0xFF123456));
      expect(store.secondaryColor, equals(0xFF654321));
      expect(store.isPopular, isTrue);
      expect(store.keywords, equals(['test', 'store']));
      expect(store.category, equals(StoreCategory.supermarket));
    });

    test('creates store with minimal properties', () {
      const store = Store(
        id: 'minimal',
        name: 'Minimal Store',
        color: 0xFF000000,
      );

      expect(store.id, equals('minimal'));
      expect(store.name, equals('Minimal Store'));
      expect(store.color, equals(0xFF000000));
      expect(store.secondaryColor, isNull);
      expect(store.isPopular, isFalse);
      expect(store.keywords, isEmpty);
      expect(store.category, equals(StoreCategory.other));
    });

    test('colorValue getter returns correct Color', () {
      const store = Store(
        id: 'color_test',
        name: 'Color Test',
        color: 0xFFFF0000,
      );

      expect(store.colorValue, equals(const Color(0xFFFF0000)));
    });

    test('secondaryColorValue getter returns correct Color when set', () {
      const store = Store(
        id: 'secondary_color_test',
        name: 'Secondary Color Test',
        color: 0xFFFF0000,
        secondaryColor: 0xFF00FF00,
      );

      expect(store.secondaryColorValue, equals(const Color(0xFF00FF00)));
    });

    test('secondaryColorValue getter returns null when not set', () {
      const store = Store(
        id: 'no_secondary_color',
        name: 'No Secondary Color',
        color: 0xFFFF0000,
      );

      expect(store.secondaryColorValue, isNull);
    });
  });

  group('StoreData', () {
    test('allStores contains predefined stores', () {
      final stores = StoreData.allStores;
      expect(stores, isNotEmpty);

      // Check that some well-known stores are present
      final storeNames = stores.map((s) => s.name).toList();
      expect(storeNames, contains('Nectar'));
      expect(storeNames, contains('Tesco'));
      expect(storeNames, contains('Boots'));
    });

    test('popularStores only returns popular stores', () {
      final popularStores = StoreData.popularStores;
      expect(popularStores, isNotEmpty);

      // All stores should be marked as popular
      for (final store in popularStores) {
        expect(store.isPopular, isTrue);
      }
    });

    test('getStoreById returns correct store', () {
      final store = StoreData.getStoreById('nectar');
      expect(store, isNotNull);
      expect(store!.id, equals('nectar'));
      expect(store.name, equals('Nectar'));
    });

    test('getStoreById returns null for non-existent id', () {
      final store = StoreData.getStoreById('non_existent');
      expect(store, isNull);
    });

    test('getStoreByName returns store for exact match', () {
      final store = StoreData.getStoreByName('Nectar');
      expect(store, isNotNull);
      expect(store!.name, equals('Nectar'));
    });

    test('getStoreByName returns store for case insensitive match', () {
      final store = StoreData.getStoreByName('nectar');
      expect(store, isNotNull);
      expect(store!.name, equals('Nectar'));
    });

    test('getStoreByName returns store for keyword match', () {
      final store = StoreData.getStoreByName('sainsbury');
      expect(store, isNotNull);
      expect(store!.name, equals('Nectar'));
    });

    test('getStoreByName returns null for non-existent name', () {
      final store = StoreData.getStoreByName('Non Existent Store');
      expect(store, isNull);
    });

    test('searchStores returns all stores for empty query', () {
      final results = StoreData.searchStores('');
      expect(results.length, equals(StoreData.allStores.length));
    });

    test('searchStores returns filtered results for name query', () {
      final results = StoreData.searchStores('Tesco');
      expect(results, isNotEmpty);
      expect(results.first.name, equals('Tesco'));
    });

    test('searchStores returns filtered results for keyword query', () {
      final results = StoreData.searchStores('clubcard');
      expect(results, isNotEmpty);
      expect(results.first.name, equals('Tesco'));
    });

    test('searchStores is case insensitive', () {
      final results = StoreData.searchStores('tesco');
      expect(results, isNotEmpty);
      expect(results.first.name, equals('Tesco'));
    });

    test('searchStores returns empty for non-matching query', () {
      final results = StoreData.searchStores('XYZ Non Existent Store');
      expect(results, isEmpty);
    });
  });

  group('StoreCategory', () {
    test('has all expected categories', () {
      const categories = StoreCategory.values;
      expect(categories, contains(StoreCategory.supermarket));
      expect(categories, contains(StoreCategory.pharmacy));
      expect(categories, contains(StoreCategory.clothing));
      expect(categories, contains(StoreCategory.electronics));
      expect(categories, contains(StoreCategory.restaurant));
      expect(categories, contains(StoreCategory.other));
    });
  });
}
