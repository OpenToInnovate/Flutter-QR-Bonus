import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_qr_bonus/widgets/scan_window_overlay.dart';

void main() {
  group('ScanWindowOverlay', () {
    late Rect testRect;
    
    setUp(() {
      testRect = const Rect.fromLTWH(50, 50, 200, 200);
    });
    
    Widget createWidget({
      Color borderColor = Colors.white,
      Color overlayColor = Colors.black,
      double borderRadius = 12.0,
      double borderWidth = 3.0,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: ScanWindowOverlay(
            scanRect: testRect,
            borderColor: borderColor,
            overlayColor: overlayColor,
            borderRadius: borderRadius,
            borderWidth: borderWidth,
          ),
        ),
      );
    }
    
    testWidgets('should create overlay with scan window', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidget());
      
      // Assert
      expect(find.byType(ScanWindowOverlay), findsOneWidget);
      expect(find.byType(CustomPaint), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });
    
    testWidgets('should create border container with correct dimensions', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidget());
      
      // Assert
      final container = tester.widget<Container>(find.byType(Container));
      final boxDecoration = container.decoration as BoxDecoration;
      final border = boxDecoration.border as Border;
      
      expect(container.constraints?.maxWidth, equals(testRect.width));
      expect(container.constraints?.maxHeight, equals(testRect.height));
      expect(border.top.width, equals(3.0));
      expect(border.top.color, equals(Colors.white));
    });
    
    testWidgets('should use custom border color', (WidgetTester tester) async {
      // Arrange
      const customColor = Colors.red;
      
      // Act
      await tester.pumpWidget(createWidget(borderColor: customColor));
      
      // Assert
      final container = tester.widget<Container>(find.byType(Container));
      final boxDecoration = container.decoration as BoxDecoration;
      final border = boxDecoration.border as Border;
      
      expect(border.top.color, equals(customColor));
    });
    
    testWidgets('should use custom border width', (WidgetTester tester) async {
      // Arrange
      const customWidth = 5.0;
      
      // Act
      await tester.pumpWidget(createWidget(borderWidth: customWidth));
      
      // Assert
      final container = tester.widget<Container>(find.byType(Container));
      final boxDecoration = container.decoration as BoxDecoration;
      final border = boxDecoration.border as Border;
      
      expect(border.top.width, equals(customWidth));
    });
    
    testWidgets('should use custom border radius', (WidgetTester tester) async {
      // Arrange
      const customRadius = 20.0;
      
      // Act
      await tester.pumpWidget(createWidget(borderRadius: customRadius));
      
      // Assert
      final container = tester.widget<Container>(find.byType(Container));
      final boxDecoration = container.decoration as BoxDecoration;
      final borderRadius = boxDecoration.borderRadius as BorderRadius;
      
      expect(borderRadius.topLeft.x, equals(customRadius));
    });
    
    testWidgets('should have ignore pointer on overlay and border', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidget());
      
      // Assert
      expect(find.byType(IgnorePointer), findsNWidgets(2));
    });
    
    testWidgets('should create stack with correct fit', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidget());
      
      // Assert
      final stack = tester.widget<Stack>(find.byType(Stack));
      expect(stack.fit, equals(StackFit.expand));
    });
  });
}
