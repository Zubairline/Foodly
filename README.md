# FOODLY – Your Personal Meal Planning & Recipe Finder App

FOODLY is a cross-platform Flutter app designed to help users discover, plan, and organize their meals effortlessly.  
The app enables users to explore meal ideas, view detailed recipes, create personalized meal plans, access tailored shopping lists, and now access educational cooking and nutrition courses — all in one place.

---

## Purpose

The app aims to make efficient meal planning easier for busy individuals.  
Users can now:
- Sign up and log in securely using **Firebase Authentication**.
- Browse recipes by category or ingredients.
- View detailed nutritional information.
- Save favorite recipes.
- Create and organize daily/weekly meal plans.
- Generate tailored shopping lists.
- Access and rate educational **courses** on cooking and healthy eating.

---

## App Navigation Flow

1. **Login / Sign Up** – Users authenticate using Firebase.  
2. **Home Screen** – Browse featured meals or categories.  
3. **Courses** – Access and rate educational cooking and nutrition lessons.  
4. **Shopping** – View meals, grocery lists, and nutritional info.  
5. **Meal Planner** – Add meals to daily or weekly plans.  
6. **Favorites / Profile** – Save, edit, and review chosen meals.

---

## Screens

- **Login / Sign Up Screen** – Secure authentication using Firebase.  
- **Home Screen** – Displays list/grid of available meals.  
- **Courses Screen** – Access, view, and rate educational courses.  
- **Shopping Screen** – Shows full recipe, necessary ingredients, and nutritional info.  
- **Meal Planner Screen** – Plan meals by day.  
- **Feedback Form** – Collects user suggestions or comments.

---

## Tech Stack

- **Framework:** Flutter (Dart)  
- **State Management:** Provider / Riverpod (depending on implementation)  
- **Authentication:** Firebase Auth  
- **Database & Storage:** Firebase Firestore / Firebase Storage  
- **Design Tool:** Figma  
- **API:** Mock JSON APIs (for recipes and course data)  
- **Version Control:** Git + GitHub

---

### Demo Video Walkthrough

A short 2–3 minute screen recording demonstrating the updated app flow (Login → Home → Courses → Meal Planning → Details).

**Watch the demo:** [https://drive.google.com/your-video-link](https://drive.google.com/file/d/1ZKkZomZFOkujC87W5EK4SFe7wF4oyiVW/view?usp=drive_link)

---
## How to Run the Project

Follow the steps below to set up and run the app locally on your system.

1. Prerequisites
Make sure you have installed the following:
- [Flutter SDK] (https://flutter.dev/docs/get-started/install)
- [Dart SDK] (https://dart.dev/get-dart) (usually included with Flutter)
- Android Studio / VS Code (with Flutter & Dart plugins)
- Git

You can verify your setup by running in system terminal:

flutter doctor

2. Clone the Repository
In terminal run:

git clone https://github.com/antu468/Foodly.git

then:

cd Foodly

3.Dependencies
Run this command to install all required packages:

flutter pub get

4. Build and run:
In application:
flutter run

In Web browser:
flutter config --enable-web
flutter run -d WEB_BROWSER
>>>>>>> 08be5def6188c91432fcf4791d552017bbb77e13
