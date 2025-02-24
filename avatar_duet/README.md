# Avatar Duet

A Flutter application that enables loading and animating 3D assets (.glb files) on both mobile and desktop platforms. This project demonstrates the handling of 3D assets in a mobile environment, implementing interactive animations, and optimizing rendering performance.

## 🌟 Live Demo
- [Try it on Appetize.io](https://appetize.io/app/b_nleyu4fhlnsdytu2hv4isu7zo4)
- [Video Demo](https://drive.google.com/file/d/1-IUQhEJ_AC1RCg0wQmPAwupdlb-0oQL6/view?usp=drivesdk)

## ✨ Features

- **3D Asset Loading**
  - Support for loading multiple .glb files
  - Proper scaling and display of 3D assets
  - Assets can be loaded from both assets folder and storage

- **Platform-Specific Controls**
  - Mobile: On-screen buttons for model control
  - Desktop: Keyboard controls support
    - Arrow keys (Left/Right) for rotation/movement
    - Space bar for jump animation

- **Dual Model Display**
  - View two 3D models simultaneously
  - Models face each other to simulate communication
  - Independent control for each model

- **Performance Optimization**
  - Smooth animation transitions
  - Optimized rendering for better performance
  - Efficient asset loading system

## 🚀 Getting Started

### Prerequisites
- Flutter (latest version)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository
```bash
git clone https://github.com/your-username/avatar-duet.git
cd avatar-duet
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

### Project Structure
```
lib/
├── main.dart
├── providers/
│   └── glb_provider.dart
├── screens/
│   ├── viewer_screen.dart
│   └── view_model_from_web_screen.dart
└── assets/
    ├── models/
    └── animations/
```

## 🛠️ Built With

- [Flutter](https://flutter.dev/) - UI Framework
- [model_viewer_plus](https://pub.dev/packages/model_viewer_plus) - 3D Model Viewer
- [provider](https://pub.dev/packages/provider) - State Management
- [file_picker](https://pub.dev/packages/file_picker) - File Selection

## 📱 Screenshots

[Include screenshots here]

## 🎮 Usage

1. **Launch the App**
   - Open the app to view the available 3D models

2. **View Models**
   - Click on any model to open it in the viewer
   - Use the "+" button to load models from web URLs

3. **Dual Model View**
   - Select models for both viewers
   - Models can be loaded from assets or storage
   - Use the change button to switch models

4. **Controls**
   - Mobile: Use on-screen buttons
   - Desktop: Use keyboard controls
   - Camera controls available for model viewing

## 🤝 Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## 🙏 Acknowledgments

- Ready Player Me for 3D assets
- Ready Player Me Animation Library for animations
- The Flutter community for support and resources

## 👤 Author

Your Name
- GitHub: [@mxg-mega](https://github.com/mxg-mega)

## 📝 Note

This project was created as part of a technical assessment. It demonstrates the implementation of 3D model viewing and animation in a Flutter application.
