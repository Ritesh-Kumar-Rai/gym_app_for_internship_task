# Gym Pro - Responsive Flutter App 🏋️‍♂️

A comprehensive Gym management application built for the Flutter Developer assignment. This app demonstrates UI design, API integration, local data persistence, and cross-platform responsiveness.

## 🚀 Features

- **Splash Screen:** Smooth entry with branded animations.
- **Dynamic Dashboard:** Summary of daily activity and progress.
- **Workout Library:** Scrollable list of exercises with detailed cards.
- **Diet Tracker (API):** Fetches real-time meal data from MealDB API with robust error handling.
- **User Profile:** Persists data (Name, Age, Weight) using `shared_preferences`.

## 🛠️ Design Decisions

- **Architecture:** Followed a modular folder structure (`models`, `services`, `screens`, `widgets`) to ensure Separation of Concerns (SoC).
- **Theme:** Used a Dark-Neon theme (Black & #CCFF00) for a modern, energetic fitness vibe.
- **Responsiveness:** Implemented `LayoutBuilder` to toggle between Mobile (2 columns) and Web (4 columns) grid views.
- **UX:** Added `BouncingScrollPhysics` and custom error screens for better user engagement.

## ⚙️ Assumptions & Improvements

- **Assumptions:** Assumed a stable internet connection for the Diet API; implemented 10s timeout for slow networks.
- **Future Improvements:** - Integration of State Management like **Provider** or **Bloc** for larger scale.
  - Adding a "Dark/Light Mode" toggle.
  - Implementation of Firebase for real-time cloud sync.
  - Authentication and Authorization
  - Daily user activity log feature, for now the summary and workout screen has constant data in future it will be dynamic

## 🏃 How to Run

1. Clone the repo: `git clone <repo-url>`
2. Install dependencies: `flutter pub get`
3. Run the app: `flutter run` (For web: `flutter run -d chrome`)
