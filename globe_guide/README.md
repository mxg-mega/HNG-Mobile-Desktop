# GlobeGuide

GlobeGuide is a Flutter-based mobile application that provides detailed information about countries worldwide. Users can browse through countries, search for specific ones, and view comprehensive details about each country. The app features both light and dark themes for comfortable viewing.

## Features

- 🌍 **Comprehensive Country List**: Browse through all countries with search functionality.
- 🔍 **Detailed Country Information**:
  - Country name and flag
  - Population statistics
  - Capital city
  - Geographic information
  - Currency and economic data
  - Cultural information
- 🌓 **Light/Dark Theme Support**: Switch between themes for comfortable viewing in any lighting condition.
- 🔎 **Search and Filter**: Easily find specific countries using search and filter capabilities.
- 📱 **Responsive Design**: Optimized for various screen sizes and devices.

## Getting Started

### Prerequisites

Before running the app, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev) (latest version)
- [Dart SDK](https://dart.dev) (latest version)
- Android Studio or VS Code with Flutter extensions
- A RESTful Countries API key

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/globe_guide.git
   ```
2. Navigate to the project directory:
    ```bash
    Copy
    cd globe_guide
    ```

3. Install dependencies:
    ```bash
    Copy
    flutter pub get
    ```

### API Key Setup
1. Visit [RESTful Countries API](https://restfulcountries.com) to generate your API key.

2. Create a .env file in the project root.

3. Add your API key to the .env file:

```
API_KEY=your_api_key_here
```

### Running the App
1. Ensure you have a device connected or an emulator running.

2. Run the app:

    ```bash
    Copy
    flutter run
    ```

## Project Structure

```
lib/
├── providers/       # State management
├── screens/         # App screens
├── widgets/         # Reusable widgets
├── themes/          # Theme configurations
└── main.dart        # App entry point
```

## Dependencies
The app uses the following key dependencies:

 - provider: For state management.

 - http: For making API calls.

 - lucide_icons_flutter: For icons.

## Theme Customization
The app supports both light and dark themes:

Light Theme: Clean, bright interface for daytime use.

Dark Theme: Eye-friendly dark mode for low-light environments.

Themes can be toggled via the sun/moon icon in the app bar.

## Testing
To run the tests, use the following command:

```bash
Copy
flutter test
```

##Building for Production
1. Build an APK:

```bash
Copy
flutter build apk
```

2. Build for iOS:

```bash
Copy
flutter build ios
```

# Deployment
The app is deployed on [Appetize.io](https://appetize.io/app/b_f7idegq43u3prnp2ztlfffroue) for easy testing. You can access it here:
GlobeGuide on [Appetize.io](https://appetize.io/app/b_f7idegq43u3prnp2ztlfffroue)

Contributing
We welcome contributions! Here’s how you can help:

1. Fork the repository.

2. Create your feature branch:

```bash
Copy
git checkout -b feature/AmazingFeature
```

3. Commit your changes:

```bash
Copy
git commit -m 'Add some AmazingFeature'
```

4. Push to the branch:

```bash
Copy
git push origin feature/AmazingFeature
```

5. Open a Pull Request.

## License
This project is licensed under the [MIT License](https://github.com/mxg-mega/HNG-Mobile-Desktop/tree/main/globe_guide). See the LICENSE file for details.

## Acknowledgments
Country data provided by RESTful Countries API.

UI design inspired by Figma Template provided by HNG19.

Built with the Flutter framework.
