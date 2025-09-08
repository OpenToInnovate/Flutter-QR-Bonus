# Flutter QR Bonus

A modern, feature-rich Flutter loyalty card manager with QR code scanning, store recognition, and beautiful card displays. Transform your physical loyalty cards into a sleek digital wallet with brand-specific styling and intuitive navigation.

## ✨ Features

### 🎯 Core Functionality
- **Smart QR Code Scanning**: Advanced camera scanning with visual guides and haptic feedback
- **Store Recognition**: Automatic brand detection for 30+ major retailers (Nectar, Tesco, Boots, etc.)
- **Digital Card Display**: Beautiful card views with brand-specific colors and logos
- **Manual Entry**: Add cards manually with brand-specific styling
- **Screenshot Import**: Import QR codes from your photo gallery

### 🎨 User Experience
- **Dark Theme**: Sleek dark interface with consistent theming
- **Card Grid**: Visual card grid on home screen with brand colors
- **Store List**: Comprehensive store selection with search functionality
- **Card Details**: Full-screen card view with barcode display and actions
- **Smooth Navigation**: Intuitive flow between all screens

### 🔧 Technical Features
- **Persistent Storage**: Automatic save and restore of all cards
- **Cross-Platform**: Works seamlessly on iOS, Android, and Web
- **Auto-copy**: Automatically copies scanned results to clipboard
- **Share Integration**: Native sharing functionality for all platforms
- **Responsive Design**: Adapts to different screen sizes and orientations

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
│   ├── scan_result.dart            # Scan result data model
│   └── store.dart                  # Store/brand data model with 30+ retailers
├── services/
│   ├── history_service.dart        # Persistent history management
│   ├── clipboard_service.dart      # Clipboard operations
│   └── share_service.dart          # Content sharing
├── widgets/
│   ├── scan_window_overlay.dart    # Camera overlay with scan window
│   ├── scan_result_card.dart       # Result display card
│   ├── history_list_tile.dart      # History list item
│   └── loyalty_card.dart           # Brand-specific loyalty card widget
├── pages/
│   ├── home_page.dart              # Main home screen with card grid
│   ├── scanner_page.dart           # QR scanner with manual entry
│   ├── store_list_page.dart        # Store selection with search
│   └── card_detail_page.dart       # Full card view with barcode
└── main.dart                       # App entry point with dark theme
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

- **Models**: Complete test coverage for `ScanResult` and `Store` models
- **Services**: Full testing of `HistoryService`, `ClipboardService`, and `ShareService`
- **Widgets**: Comprehensive widget tests for all UI components including `LoyaltyCard`
- **Pages**: Full page testing for `StoreListPage` and `CardDetailPage`
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

- `mobile_scanner: ^7.0.1` - Advanced QR code scanning functionality
- `share_plus: ^11.1.0` - Cross-platform content sharing
- `shared_preferences: ^2.2.2` - Persistent data storage
- `image_picker: ^1.0.4` - Gallery access for screenshot import

### Development Dependencies

- `flutter_test` - Testing framework
- `flutter_lints: ^6.0.0` - Code quality and style
- `mockito: ^5.5.0` - Mocking for unit tests
- `build_runner: ^2.7.0` - Code generation

## 🎯 Usage

### Adding New Cards

1. **From Store List**: Tap the + button → Select store → Scan QR code
2. **Manual Entry**: Tap + button → Select store → Tap "Enter manually"
3. **Screenshot Import**: Tap + button → Select store → Tap "Import screenshot"
4. **Custom Cards**: Tap + button → "Add custom card" → Scan any QR code

### Managing Your Cards

- **View Cards**: All cards displayed in a beautiful grid on the home screen
- **Card Details**: Tap any card to view full details with barcode
- **Card Actions**: Long press cards for copy, share, or delete options
- **Brand Recognition**: Cards automatically display with correct brand colors and logos

### Store Selection

- **Popular Stores**: Quick access to most common retailers
- **Search**: Find any store by typing in the search bar
- **All Stores**: Browse complete list of 30+ supported retailers
- **Custom Cards**: Add cards for stores not in the list

### Scanner Features

- **Visual Guides**: Phone icon and scanning rectangle for better targeting
- **Manual Entry**: Enter card numbers manually with brand-specific styling
- **Screenshot Import**: Import QR codes from your photo gallery
- **Auto-copy**: Scanned results automatically copied to clipboard

## 🏪 Supported Stores

The app includes built-in support for 30+ major retailers with proper branding:

### Popular Stores
- **Nectar** (Sainsbury's) - Purple with organic logo
- **Tesco** - Blue with TESCO branding
- **Boots** - Dark blue with italic logo
- **Superdrug** - Dark grey with pink accents
- **Morrisons** - Green with yellow accents
- **Marks & Spencer** - Dark green with M&S logo
- **Co-op** - Light blue with co op branding
- **Waitrose & Partners** - Green with WAITROSE logo

### Additional Stores
- **Supermarkets**: ASDA, ALDI, LIDL, Iceland
- **Restaurants**: Starbucks, McDonald's, Subway, Costa, Pret, KFC, Burger King, Pizza Hut, Domino's
- **Retail**: Argos, Currys, John Lewis, Next, Primark, H&M, Zara, Uniqlo
- **And many more!**

### Custom Cards
- Add cards for any store not in the list
- Automatic brand detection from QR content
- Fallback to Nectar styling for unknown brands

## 🔒 Privacy & Security

- **Local Storage**: All card data is stored locally on the device
- **No Network**: The app doesn't send any data over the network
- **Camera Access**: Camera is only used for scanning, not recording
- **Gallery Access**: Only used for importing QR codes from screenshots
- **Minimal Permissions**: Only camera and gallery access required

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

## 🚀 Recent Updates

### Version 1.4.0 (Latest)
- **Major UI/UX Overhaul**: Complete redesign of store list and card detail pages
- **Performance Improvements**: Converted to StatelessWidget for better performance
- **Enhanced Testing**: Added comprehensive test coverage for all new components
- **Code Quality**: Improved error handling and null safety throughout

### Version 1.3.0
- **Store System**: Added 30+ retailers with brand recognition
- **Card Management**: Full card detail views with barcode display
- **Search Functionality**: Real-time search across all stores
- **Manual Entry**: Brand-specific manual card entry

### Version 1.2.0
- **Dark Theme**: Complete dark theme implementation
- **Card Grid**: Visual card display on home screen
- **Scanner Redesign**: Modern scanner with visual guides

---

**Made with ❤️ using Flutter**