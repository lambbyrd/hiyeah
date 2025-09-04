# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter application built with the Nylo micro-framework (v6.8.15), designed to simplify Flutter app development with an MVC pattern and structured boilerplate.

## Development Commands

### Flutter Analysis and Linting
```bash
flutter analyze
```
Runs static analysis on the Dart code using the configuration in `analysis_options.yaml`.

### App Icon Generation
```bash
dart run flutter_launcher_icons
```
Generates app icons from `public/app_icon/icon.png` for both Android and iOS platforms.

### Project Renaming
```bash
flutter pub run rename setAppName --targets ios,android --value "YourAppName"
```
Renames the application for iOS and Android platforms.

### Testing
```bash
flutter test
```
Runs unit tests located in the `test/` directory.

### Building
```bash
flutter build apk          # Android APK
flutter build ios          # iOS build
flutter build web          # Web build
```

### Running the Application
```bash
flutter run                # Debug mode
flutter run --release      # Release mode
flutter run -d <device>    # Specific device
```

## Architecture Overview

### Core Structure
- **Nylo Framework**: Built on Nylo v6.8.15 micro-framework with MVC pattern
- **Entry Point**: `lib/main.dart` initializes the app through `Nylo.init()` with bootstrap configuration
- **Bootstrap**: `lib/bootstrap/` contains app initialization, extensions, and helpers

### Directory Architecture

#### `/lib/app/` - Application Logic
- **commands/**: Command pattern implementations
- **controllers/**: MVC controllers handling business logic
- **events/**: Event system implementations  
- **forms/**: Form handling with styles (login, register forms)
- **models/**: Data models and entities
- **networking/**: API services and HTTP interceptors (Dio-based)
- **providers/**: Service providers and dependency injection

#### `/lib/config/` - Configuration
Core configuration files for:
- **decoders.dart**: Data transformation and parsing
- **design.dart**: UI design system and theming
- **events.dart**: Event system configuration
- **form_casts.dart**: Form validation and casting
- **keys.dart**: API keys and configuration keys
- **localization.dart**: Multi-language support
- **providers.dart**: Service provider registration
- **theme.dart**: App theming and styling
- **toast_notification_styles.dart**: Notification styling
- **validation_rules.dart**: Form validation rules

#### `/lib/resources/` - UI Resources
Contains widgets, pages, and other UI components.

#### `/lib/routes/` - Navigation
Route definitions and navigation configuration.

#### `/public/` - Static Assets
- **fonts/**: Custom fonts
- **images/**: Image assets
- **app_icon/**: Application icons

#### `/lang/` - Localization
Translation files (e.g., `en.json` for English)

### Key Dependencies
- **nylo_framework**: Core framework (v6.8.15)
- **dio**: HTTP client with interceptors for API communication
- **google_fonts**: Typography system
- **flutter_local_notifications**: Push notifications
- **scaffold_ui**: UI components

### Environment Configuration
- Environment variables in `.env` file (see `.env-example` for template)
- Configuration managed through Nylo's environment system

### Testing Structure
- Unit tests in `/test/` directory
- Follow Flutter testing conventions

## Development Notes

### API Integration
- API services located in `lib/app/networking/api_service.dart`
- Bearer authentication interceptor available in `lib/app/networking/dio/interceptors/`
- HTTP logging enabled via `pretty_dio_logger`

### Form Handling
- Forms use Nylo's form system with validation
- Form styles centralized in `lib/app/forms/style/`
- Validation rules configured in `lib/config/validation_rules.dart`

### Theming
- Material Design with custom theming
- Google Fonts integration
- Font Awesome icons available
- Theme configuration in `lib/config/theme.dart`

### Localization
- Multi-language support built-in
- Translation files in `/lang/` directory
- Configuration in `lib/config/localization.dart`