# Changelog

All notable changes to the Flutter QR Bonus app will be documented in this file.

## [1.4.0] - 2024-12-19

### 🎨 UI/UX Improvements

#### Store List Page Redesign
- **Simplified Layout**: Replaced complex grid system with clean list-based design
- **Improved Search**: Enhanced search functionality with real-time filtering
- **Better Navigation**: Streamlined store selection flow
- **Consistent Styling**: Unified design language across all store cards
- **Store Initials**: Added store initials display for better visual identification

#### Card Detail Page Overhaul
- **Modern Design**: Complete redesign with improved visual hierarchy
- **Custom Barcode**: Implemented custom barcode painter for realistic display
- **Enhanced Branding**: Better store brand text display with proper formatting
- **Improved Actions**: Redesigned action buttons with chevron indicators
- **Responsive Layout**: Better spacing and proportions for different screen sizes

#### Home Page Refinements
- **Code Cleanup**: Removed unused imports and methods
- **Better Integration**: Improved store data integration
- **Consistent Colors**: Fixed color property usage for store cards

### 🔧 Technical Improvements

#### Code Architecture
- **StatelessWidget**: Converted CardDetailPage from StatefulWidget to StatelessWidget for better performance
- **Method Extraction**: Extracted reusable methods for better code organization
- **Error Handling**: Improved error handling in share functionality
- **Null Safety**: Enhanced null safety throughout the codebase

#### Store Data Model
- **Color Properties**: Fixed color property access in store model
- **Better Integration**: Improved store data integration across all pages

#### Scanner Integration
- **Store Context**: Enhanced scanner page to accept selected store context
- **Navigation Flow**: Improved navigation between store list and scanner

### 🐛 Bug Fixes
- **Color Access**: Fixed store color property access issues
- **Navigation**: Resolved navigation flow issues between pages
- **Import Cleanup**: Removed unused imports to reduce bundle size

### 📱 User Experience
- **Faster Navigation**: Streamlined user flow from store selection to card creation
- **Better Visual Feedback**: Improved visual indicators and button states
- **Consistent Theming**: Unified dark theme across all pages
- **Responsive Design**: Better adaptation to different screen sizes

### 🧪 Testing
- **Test Coverage**: Added comprehensive test files for new components
- **Model Tests**: Added tests for store data model
- **Widget Tests**: Added tests for loyalty card widget
- **Page Tests**: Added tests for store list and card detail pages

## [1.3.0] - 2024-12-19

### ✨ New Features
- **Store List System**: Complete store selection system with 30+ retailers
- **Brand Recognition**: Automatic brand detection and logo display
- **Search Functionality**: Real-time search across all stores
- **Card Detail View**: Full card display with barcode and actions
- **Manual Entry**: Manual card entry with brand-specific styling
- **Screenshot Import**: Gallery import functionality for QR codes

### 🎨 Design System
- **Dark Theme**: Consistent dark theme across all screens
- **Brand Colors**: Proper brand colors for each retailer
- **Logo System**: Custom logos for major retailers
- **Card Layout**: Grid-based card display on home screen

### 🔧 Technical Features
- **Store Data Model**: Comprehensive store data with metadata
- **Navigation Flow**: Seamless navigation between all screens
- **QR Processing**: Enhanced QR code processing and display
- **Persistent Storage**: Improved history management

## [1.2.0] - 2024-12-19

### 🎨 UI Redesign
- **Home Screen**: Complete redesign with dark theme and card grid
- **Scanner Screen**: Dark theme with phone icon and scanning rectangle
- **Manual Entry**: TESCO-style manual entry dialog
- **Card Display**: Purple nectar-style loyalty cards

### 🔧 Technical Improvements
- **Theme System**: Comprehensive dark theme implementation
- **Widget System**: New loyalty card widget with brand support
- **Navigation**: Improved navigation flow between screens
- **Dependencies**: Added image_picker for screenshot import

## [1.1.0] - 2024-12-19

### ✨ Core Features
- **QR Scanner**: Mobile scanner integration with camera support
- **History Management**: Persistent scan history with SharedPreferences
- **Share Functionality**: Text sharing capabilities
- **Clipboard Integration**: Auto-copy scanned results
- **Haptic Feedback**: Vibration feedback on successful scans

### 🎨 UI Components
- **Scan Window Overlay**: Custom scanning area with visual guides
- **Result Cards**: Display scanned results with copy/share actions
- **History List**: Chronological list of previous scans
- **Action Buttons**: Copy, share, and clear history functionality

## [1.0.0] - 2024-12-19

### 🚀 Initial Release
- **Basic QR Scanner**: Core QR code scanning functionality
- **Cross-Platform**: Support for iOS, Android, and Web
- **Material Design**: Modern Material 3 design system
- **Responsive Layout**: Adaptive layout for different screen sizes