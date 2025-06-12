A Flutter mobile app that fetches and displays articles from a public API with detail view for comments. 
Built using Provider for state management.

✅ Features
Fetch posts from jsonplaceholder.typicode.com (fallback to dummyjson.com).

Search bar to filter articles by title.

Pull-to-refresh support.

Post details with comment view.

Responsive UI using flutter_screenutil.

Error handling and loading states.

🛠️ Setup Instructions
Prerequisites
Flutter SDK (>=3.10.0)

Dart SDK

VS Code or Android Studio with Flutter plugin

Emulator or physical Android device

Steps
bash
Copy
Edit
git clone https://github.com/ayolateef/article_app.git
cd article_app
flutter pub get
Add Internet Permission (Android)
Edit android/app/src/main/AndroidManifest.xml:


Run App
bash
Copy
Edit
flutter run

📦 Dependencies
http: For API requests.

provider: State management.

flutter_screenutil: Responsive UI.

Flutter's material.dart: UI components.

🔧 Architecture
Core: Constants, models, services.

Features: Article logic (providers, screens, widgets).

State Management: PostProvider for managing posts/comments.

Routing: Named routes (/home, /detail) via routes.dart.

📁 Folder Structure
css
Copy
Edit
lib/
├── core/
│   ├── constants/
│   ├── models/
│   └── services/
├── features/
│   └── articles/
│       ├── providers/
│       ├── screens/
│       └── widgets/
├── routes.dart
└── main.dart
🧪 Troubleshooting
403 Forbidden: Check API access in browser or switch network.

No data: Confirm API access and check console logs.

INTERNET Permission: Ensure it's added in AndroidManifest.xml.

💡 Future Improvements
Add local caching with shared_preferences.

Add UI animations with flutter_animate.

Write unit and widget tests.

🚀 First Commit & Push
Make sure you’ve initialized the Git repo and added the files:

bash
Copy
Edit
git init
git remote add origin https://github.com/ayolateef/article_app.git
git add .
git commit -m "Initial commit: Article App with Provider and API integration"
git branch -M main
git push -u origin main
Let me know if you'd like a README.md file generated or help pushing from a specific IDE like VS Code.