import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_qr_bonus/pages/store_list_page.dart';
import 'package:flutter_qr_bonus/models/store.dart';

void main() {
  group('StoreListPage', () {
    testWidgets('displays app bar with correct title',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StoreListPage(),
        ),
      );

      expect(find.text('Store List'), findsOneWidget);
      expect(find.text('Import'), findsOneWidget);
    });

    testWidgets('displays search bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StoreListPage(),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
    });

    testWidgets('displays popular stores section', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StoreListPage(),
        ),
      );

      expect(find.text('Most popular cards'), findsOneWidget);

      // Should display some popular stores
      final popularStores = StoreData.popularStores;
      expect(popularStores, isNotEmpty);
    });

    testWidgets('displays all cards section', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StoreListPage(),
        ),
      );

      expect(find.text('All cards'), findsOneWidget);
    });

    testWidgets('displays add custom card option', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StoreListPage(),
        ),
      );

      expect(find.text('Add custom card'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('search functionality filters stores',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StoreListPage(),
        ),
      );

      // Enter search query
      await tester.enterText(find.byType(TextField), 'Tesco');
      await tester.pump();

      // Should show search results instead of all cards
      expect(find.text('Search Results'), findsOneWidget);
      expect(find.text('All cards'), findsNothing);

      // Should not show popular cards section when searching
      expect(find.text('Most popular cards'), findsNothing);
    });

    testWidgets('clearing search shows all sections again',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StoreListPage(),
        ),
      );

      // Enter and then clear search
      await tester.enterText(find.byType(TextField), 'Tesco');
      await tester.pump();
      await tester.enterText(find.byType(TextField), '');
      await tester.pump();

      // Should show original sections
      expect(find.text('Most popular cards'), findsOneWidget);
      expect(find.text('All cards'), findsOneWidget);
      expect(find.text('Search Results'), findsNothing);
    });

    testWidgets('has correct theme colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StoreListPage(),
        ),
      );

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, equals(Colors.black));

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, equals(const Color(0xFF2D2D2D)));
    });

    testWidgets('back button navigates back', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StoreListPage()),
              ),
              child: const Text('Go to Store List'),
            ),
          ),
        ),
      );

      // Navigate to store list page
      await tester.tap(find.text('Go to Store List'));
      await tester.pumpAndSettle();

      expect(find.byType(StoreListPage), findsOneWidget);

      // Tap back button
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.byType(StoreListPage), findsNothing);
    });
  });
}
