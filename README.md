# Expense Tracker Mobile App

A modern, cross-platform mobile application built with Flutter to complement the Expense Tracker API. Track your
spending, manage categories, and view financial insights on the go.

---

## 🚀 Getting Started

Follow these instructions to set up the Flutter environment and run the application on your local machine or device.

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (Latest stable version)
- **Dart SDK** (included with Flutter)
- **Android Studio** (for Android development) / **Xcode** (for iOS development)
- **VS Code** (Recommended editor with Flutter & Dart extensions)

---

## 🛠️ Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/jaymash01/expense-tracker-app.git expense_tracker
cd expense_tracker
```

### 2. Install Dependencies

Fetch all the required packages listed in the pubspec.yaml file:

```bash
flutter pub get
```

### 3. Environment Configuration

Copy the template to create your local environment file:

```bash
cp .env.example .env
```

Open the .env file in your editor and update the base URL:

```plaintext
BASE_URL=http://localhost:8000
```

Note: If using an Android Emulator, use http://10.0.2.2:8000 instead of localhost.

### 4. Check Flutter Setup

Ensure your environment is correctly configured by running:

```bash
flutter doctor
```

## 🏃 Running the Application

**Using the Command Line**

To run the app on a connected device or emulator:

```bash
flutter run
```

**Build for Release**

To generate an APK for Android or an Archive for iOS:

Android:

```bash
flutter build apk --release
```

iOS:

```bash
flutter build ios --release
```

## 🔧 Troubleshooting

### 1. CocoaPods Issues (macOS/iOS only)

If you encounter errors related to iOS plugins, navigate to the ios folder and reinstall pods:

```bash
cd ios
rm -rf Pods
rm Podfile.lock
pod install
cd ..
```

### 2. Clear Build Cache

If the app is behaving unexpectedly after an update:

```bash
flutter clean
flutter pub get
```

## 🔑 Key Features

- Real-time Sync: Connects seamlessly with the Expense Tracker API.
- Beautiful UI: Built using Material Design 3.
- State Management: Efficient data handling with Bloc.
- Secure Storage: JWT tokens are stored securely on the device.
