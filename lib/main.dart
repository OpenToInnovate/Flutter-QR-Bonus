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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}