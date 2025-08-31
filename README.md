# Flutter QR Bonus

A clean, feature-rich Flutter QR code scanner with scan window, haptics, persistent history, and copy/share functionality. Supports iOS, Android, and Web platforms.

## ✨ Features

- **Fast QR Code Scanning**: Opens camera with centered scan window for precise targeting
- **Haptic Feedback**: Medium impact vibration on successful scan
- **Persistent History**: Automatically saves and restores scan history across app sessions
- **Copy & Share**: One-tap copy to clipboard and native sharing functionality
- **Camera Controls**: Torch toggle and front/back camera switching
- **Auto-copy**: Automatically copies the first scan result to clipboard
- **Clean UI**: Material Design 3 with modern, intuitive interface
- **Cross-platform**: Works on iOS, Android, and Web

## 🚀 Quick Start

### Prerequisites

- Flutter SDK (>=3.3.0)
- Dart SDK
- iOS/Android device or emulator for testing

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_qr_bonus
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Platform Setup

### Android

Add camera permission to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA" />
```

### iOS/macOS

Add camera usage description to `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to scan QR codes.</string>
```

### Web

- Run on `https://` or `http://localhost`
- Allow camera access when prompted by the browser

## 🏗️ Project Structure

```
lib/
├── constants/
│   └── app_constants.dart          # App-wide constants and configuration
├── models/
│   └── scan_result.dart            # Scan result data model
├── services/
│   ├── history_service.dart        # Persistent history management
│   ├── clipboard_service.dart      # Clipboard operations
│   └── share_service.dart          # Content sharing
├── widgets/
│   ├── scan_window_overlay.dart    # Camera overlay with scan window
│   ├── scan_result_card.dart       # Result display card
│   └── history_list_tile.dart      # History list item
├── pages/
│   ├── home_page.dart              # Main home screen
│   └── scanner_page.dart           # QR scanner screen
└── main.dart                       # App entry point
```

## 🧪 Testing

The project includes comprehensive unit and widget tests:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test files
flutter test test/models/scan_result_test.dart
flutter test test/services/history_service_test.dart
flutter test test/widgets/scan_result_card_test.dart
```

### Test Coverage

- **Models**: Complete test coverage for `ScanResult` model
- **Services**: Full testing of `HistoryService`, `ClipboardService`, and `ShareService`
- **Widgets**: Comprehensive widget tests for all UI components
- **Integration**: End-to-end testing scenarios

## 🔧 Configuration

### App Constants

Key configuration values can be found in `lib/constants/app_constants.dart`:

- `scanWindowSizeRatio`: Size of scan window relative to screen (default: 0.70)
- `maxHistoryItems`: Maximum number of items to keep in history (default: 100)
- `scanDelay`: Delay after scan before returning result (default: 60ms)

### Customization

You can easily customize:

- **Colors**: Modify the color scheme in `main.dart`
- **Scan Window**: Adjust size and appearance in `app_constants.dart`
- **History Limit**: Change `maxHistoryItems` in constants
- **UI Elements**: Customize widgets in the `widgets/` directory

## 📦 Dependencies

### Core Dependencies

- `mobile_scanner: ^6.0.1` - QR code scanning functionality
- `share_plus: ^9.0.0` - Cross-platform content sharing
- `shared_preferences: ^2.2.2` - Persistent data storage

### Development Dependencies

- `flutter_test` - Testing framework
- `flutter_lints: ^4.0.0` - Code quality and style
- `mockito: ^5.4.4` - Mocking for unit tests
- `build_runner: ^2.4.7` - Code generation

## 🎯 Usage

### Basic Scanning

1. Tap the "Scan QR" button
2. Point your camera at a QR code
3. The app will automatically detect and copy the result
4. View the result on the home screen

### History Management

- **View History**: All previous scans are displayed in chronological order
- **Promote to Top**: Tap any history item to move it to the top
- **Copy/Share**: Use the action buttons for each history item
- **Clear History**: Use the trash icon in the app bar to clear all history

### Camera Controls

- **Torch**: Toggle flashlight for better scanning in low light
- **Switch Camera**: Switch between front and back cameras
- **Scan Window**: Align QR codes within the centered square overlay

## 🔒 Privacy & Security

- **Local Storage**: All scan history is stored locally on the device
- **No Network**: The app doesn't send any data over the network
- **Camera Access**: Camera is only used for scanning, not recording
- **Permissions**: Minimal permissions required (camera only)

## 🐛 Troubleshooting

### Common Issues

1. **Camera not working**
   - Ensure camera permissions are granted
   - Check if another app is using the camera
   - Restart the app

2. **QR codes not detected**
   - Ensure good lighting conditions
   - Hold the device steady
   - Make sure the QR code is within the scan window

3. **History not persisting**
   - Check device storage space
   - Ensure app has storage permissions
   - Try restarting the app

### Debug Mode

Run in debug mode for additional logging:

```bash
flutter run --debug
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow Flutter/Dart style guidelines
- Write tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [mobile_scanner](https://pub.dev/packages/mobile_scanner) for excellent QR scanning capabilities
- [share_plus](https://pub.dev/packages/share_plus) for cross-platform sharing
- Flutter team for the amazing framework

## 📞 Support

If you encounter any issues or have questions:

1. Check the [troubleshooting section](#-troubleshooting)
2. Search existing [issues](../../issues)
3. Create a new issue with detailed information

---

**Made with ❤️ using Flutter**