# FOODLY – Your Personal Meal Planning & Recipe Finder App

FOODLY is a cross-platform Flutter app designed to help users discover, plan, and organize their meals effortlessly. The app enables users to explore meal ideas, view detailed recipes, create personalized meal plans and access tailored shopping list — all in one place.


## Purpose

The app aims to make efficient meal planning easier for busy individuals.  
Users can:
- Browse recipes by category or ingredients.
- View detailed nutritional information.
- Save favorite recipes.
- Create and organize daily/weekly meal plans.
- Generate tailored shopping lists.

---

## App Navigation Flow

1. Login / Onboarding – Users sign in or create an account.  
2. Home Screen – Browse featured meals or categories.  
3. Shopping – View meals, grocery list, and nutrition info.  
4. Meal Planner – Add meals to daily or weekly plans.  
5. Favorites / Profile – Save, edit, and review chosen meals.

---

## Screens

- Login Screen – Basic authentication and navigation setup.  
- Home Screen – Displays list/grid of available meals.  
- Shopping Screen – Shows full recipe, necessary ingredients, and nutritional info.  
- Meal Planner Screen – Lets users plan meals by day.  
- Feedback Form – Collects user suggestions or comments.

---

## Tech Stack

- Framework: Flutter (using Dart)
- Design Tool: Figma
- API: Mock JSON APIs (mock data)
- Version Control: Git + GitHub

---
### Demo Video Walkthrough
A short 2–3 minute screen recording demonstrating the app flow (Login → Home → Listing → Details).

**Watch the demo:** [https://drive.google.com/your-video-link](https://drive.google.com/file/d/1ZKkZomZFOkujC87W5EK4SFe7wF4oyiVW/view?usp=drive_link)

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
