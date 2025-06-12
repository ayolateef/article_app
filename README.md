A Flutter mobile app that fetches and displays articles from a public API with detailed views for comments. Built using Provider for state management.

🔄 Supports dark mode toggle using SharedPreferences.

Features
🔥 Fetch posts from jsonplaceholder.typicode.com (fallback to dummyjson.com).

🔍 Search bar to filter articles by title.

⬇️ Pull-to-refresh support.

🗨️ Post detail screen with comment view.

📱 Responsive UI using flutter_screenutil.

🌓 Dark theme toggle with persistent setting via shared_preferences.

⚠️ Error handling and loading states.

Setup Instructions
🔧 Prerequisites
Flutter SDK (>=3.10.0)

Dart SDK

VS Code or Android Studio with Flutter plugin

Emulator or Android device

🚀 Steps
git clone https://github.com/ayolateef/article_app.git
cd article_app
flutter pub get

Add Internet Permission (Android)
Edit android/app/src/main/AndroidManifest.xml:
<uses-permission android:name="android.permission.INTERNET"/>

Run the App
flutter run

📦 Dependencies
http: For API requests.

provider: State management.

flutter_screenutil: Responsive UI scaling.

shared_preferences: Persist dark theme preference.

Flutter's built-in material.dart: UI components.

          
