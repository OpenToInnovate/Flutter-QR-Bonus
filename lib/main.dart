import 'package:flutter/material.dart';

import 'constants/app_constants.dart';
import 'pages/home_page.dart';

/// Main entry point of the QR Scanner application
void main() {
  runApp(const QRScannerApp());
}

/// The root widget of the QR Scanner application
class QRScannerApp extends StatelessWidget {
  const QRScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF6B35), // Orange
          secondary: Color(0xFFE53E3E), // Red
          surface: Color(0xFF2D2D2D), // Dark grey
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D2D2D),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFF2D2D2D),
          contentTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      home: const HomePage(),
    );
  }
}
