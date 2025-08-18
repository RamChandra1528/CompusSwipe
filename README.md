# CampusSwipe 💕

**A Tinder-style social networking app for college students**

CampusSwipe is a Flutter-based cross-platform application that allows verified college students to connect, interact, and chat with mutual matches in a safe and authenticated environment.

## 🚀 Features

### Core Functionality
- **User Registration & Verification**: Students register with college email/phone and upload ID proof for admin approval
- **Swipe & Match System**: Tinder-style swiping with Like, Dislike, and Super Like options
- **Real-time Chat**: Private messaging with matched users including text, images, and GIFs
- **Profile Management**: Multiple photos, bio, interests, and personal information
- **Admin Panel**: Complete user verification and content moderation system

### Key Features
- ✅ **Verified Profiles**: Admin-approved users with college credentials
- 🔒 **Safe Environment**: Content moderation and reporting system
- 💬 **Real-time Messaging**: Instant chat with matches
- 🎯 **Smart Filters**: Filter by age, department, batch, and interests
- 🏆 **Gamification**: Points system and leaderboards
- 📱 **Cross-platform**: Android, iOS, and Web support
- 🌙 **Dark Mode**: Modern UI with light and dark themes

## 🛠 Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase
  - Authentication (Email/Phone)
  - Firestore Database
  - Cloud Storage
  - Cloud Messaging (FCM)
- **State Management**: Provider
- **UI Framework**: Material Design 3
- **Fonts**: Google Fonts (Poppins, Inter)

## 📱 Screenshots

*Screenshots will be added once the UI is implemented*

## 🏗 Project Structure

```
lib/
├── constants/          # App constants and themes
│   └── app_theme.dart
├── models/            # Data models
│   ├── user_model.dart
│   ├── match_model.dart
│   ├── message_model.dart
│   ├── swipe_model.dart
│   └── report_model.dart
├── providers/         # State management
│   └── auth_provider.dart
├── screens/          # UI screens
│   ├── auth/         # Authentication screens
│   ├── home/         # Main app screens
│   ├── profile/      # Profile management
│   ├── chat/         # Chat functionality
│   └── admin/        # Admin panel
├── services/         # Business logic
│   ├── auth_service.dart
│   └── database_service.dart
├── utils/            # Utility functions
├── widgets/          # Reusable widgets
└── main.dart         # App entry point
```

## 🚦 Getting Started

### Prerequisites
- Flutter SDK (>=3.9.0)
- Dart SDK
- Firebase account
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/campus_swipe.git
   cd campus_swipe
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project
   - Enable Authentication (Email/Password, Phone)
   - Set up Firestore Database
   - Enable Cloud Storage
   - Add your Firebase configuration files:
     - `android/app/google-services.json`
     - `ios/Runner/GoogleService-Info.plist`
     - `web/index.html` (Firebase config)

4. **Run the app**
   ```bash
   flutter run
   ```

## 🔧 Configuration

### Firebase Collections

The app uses the following Firestore collections:

- `users` - User profiles and verification status
- `swipes` - User swipe actions and preferences
- `matches` - Mutual likes and match data
- `messages` - Chat messages between matched users
- `reports` - User reports for content moderation

### Environment Setup

1. **Android**: Update `android/app/build.gradle` with your package name
2. **iOS**: Update `ios/Runner/Info.plist` with required permissions
3. **Web**: Update `web/index.html` with Firebase config

## 📋 Development Roadmap

### Phase 1: Core Features ✅
- [x] Project structure and Firebase setup
- [x] User authentication service
- [x] Data models and database service
- [x] Basic UI structure and theming
- [ ] User registration and verification flow

### Phase 2: Swipe System 🚧
- [ ] Swipe card widget implementation
- [ ] Match detection and creation
- [ ] User filtering and preferences
- [ ] Undo swipe functionality

### Phase 3: Chat System 🚧
- [ ] Real-time messaging
- [ ] Image and GIF support
- [ ] Message reactions and status
- [ ] Chat list and conversation UI

### Phase 4: Admin Panel 🚧
- [ ] User verification interface
- [ ] Content moderation tools
- [ ] Analytics dashboard
- [ ] Report management

### Phase 5: Advanced Features 📋
- [ ] Push notifications
- [ ] Advanced filters and preferences
- [ ] Gamification features
- [ ] Video chat integration
- [ ] Event and group features

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Material Design for UI guidelines
- The open-source community for inspiration

## 📞 Contact

For questions or support, please reach out:
- Email: support@campusswipe.com
- GitHub Issues: [Create an issue](https://github.com/yourusername/campus_swipe/issues)

---

**Made with ❤️ for the college community**

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
