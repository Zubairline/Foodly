# FOODLY – Your Personal Meal Planning & Recipe Finder App

FOODLY is a cross-platform Flutter app designed to help users discover, plan, and organize their meals effortlessly. The app enables users to explore meal ideas, view detailed recipes, create personalized meal plans and access tailored shopping list — all in one place.


FOODLY is a modern cross-platform Flutter application that serves as your personal meal planning assistant and recipe discovery platform. It helps users discover, plan, and organize their meals effortlessly while providing access to educational cooking and nutrition courses.

## ✨ Features

- **🔐 Secure Authentication**
  - Firebase-powered user authentication
  - Email/password registration and login
  - Password recovery functionality

- **🍳 Recipe Discovery**
  - Browse recipes by categories (Dinner, Vegan, Desserts, Quick Meals)
  - View detailed recipe information
  - Access nutritional facts and ingredients
  - Save favorite recipes

- **📅 Meal Planning**
  - Create daily and weekly meal plans
  - Add custom meals with images
  - Organize meals by category and time
  - Store meal plans locally for offline access

- **🛒 Shopping & Details**
  - View complete recipe instructions
  - Access ingredient lists
  - Check nutritional information
  - Generate shopping lists based on meal plans

- **📚 Educational Courses**
  - Access cooking and nutrition courses
  - Rate and review course content
  - Track learning progress

## 🛠️ Tech Stack

- **Framework:** Flutter (Dart)
- **State Management:** Bloc Pattern with HydratedBloc
- **Authentication:** Firebase Auth
- **Database:** Firebase Cloud Storage
- **Local Storage:** HydratedStorage
- **UI Components:** Material Design 3
- **Dependencies:**
  - `flutter_bloc`: State management
  - `firebase_core` & `firebase_auth`: Authentication
  - `hydrated_bloc`: Persistent state management
  - `image_picker`: Image selection
  - `table_calendar`: Calendar functionality
  - Additional utilities and plugins

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.x or later)
- Dart SDK
- Firebase project setup
- Android Studio / VS Code with Flutter plugins

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Zubairline/Foodly.git
   cd Foodly
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a new Firebase project
   - Add your `google-services.json` to `android/app`
   - Update Firebase configuration in `lib/firebase_options.dart`

4. **Run the application**
   ```bash
   flutter run
   ```

### Building for Different Platforms

- **Android:**
  ```bash
  flutter build apk
  ```

- **iOS:**
  ```bash
  flutter build ios
  ```

- **Web:**
  ```bash
  flutter build web
  ```
## 📱 App Structure

```
lib/
├── config/           # App configuration and utilities
├── core/            # Core functionality and shared code
├── features/        # Main feature modules
│   ├── auth/        # Authentication
│   ├── discovery/   # Recipe discovery
│   ├── plan/        # Meal planning
│   ├── recipes/     # Recipe details
│   └── courses/     # Educational content
└── foodly.dart      # App entry point
```

### Demo Video Walkthrough

A short 2–3 minute screen recording demonstrating the updated app flow (Login → Home → Courses → Meal Planning → Details).

**Watch the demo:** [https://drive.google.com/your-video-link](https://drive.google.com/file/d/1ZKkZomZFOkujC87W5EK4SFe7wF4oyiVW/view?usp=drive_link)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📧 Support

For support, email support@foodly.app or create an issue in the repository.

---

Made with ❤️ by the Foodly Team
