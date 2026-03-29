# Environment Setup Guide

## Cloning and Setting Up the Project

When cloning this repository, follow these steps to set up your environment:

### 1. Copy the Example Environment File
```bash
cp .env.example .env
```

### 2. Fill in Your Firebase Credentials
Edit the `.env` file and replace all placeholder values with your actual Firebase configuration:

```
FIREBASE_ANDROID_API_KEY=your_actual_key_here
FIREBASE_ANDROID_APP_ID=your_actual_id_here
# ... and so on for all platforms
```

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Run the App
```bash
flutter run
```

## Important Notes

- **Never commit `.env` to version control** - it contains sensitive credentials
- **Always use `.env.example`** as a template when setting up a new environment
- The `.env` file is automatically loaded by the app at startup
- Firebase credentials are loaded dynamically from environment variables

## Getting Your Firebase Credentials

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. For each platform (Android, iOS, Web), get the configuration values from:
   - **Project Settings** → Download your configuration files
   - Or manually copy the values from the Firebase Console

## Security Best Practices

- ✅ `.env` is in `.gitignore` - it will NOT be committed
- ✅ `.env.example` is committed - it serves as a template
- ✅ Sensitive keys are loaded at runtime, not hardcoded
- ✅ Different credentials can be used for dev/prod environments by updating `.env`
