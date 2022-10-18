---------- Step Quest README ----------
Step Quest has the following dependencies to build on Android. 
- Flutter v3.0.5
- Android SDK 33 (Android v13)
- Google Fit API

---------- Setup Dependencies ---------
1. Install Android SDK from https://developer.android.com/ (Android Studio highly recommended)
1.1 If using Android Studio, additionally install the flutter plugin
2. From SDK install API 33
3. Install Flutter from https://docs.flutter.dev/get-started/install
4. Follow https://developers.google.com/fit/android/get-started to sign up for Google Fit API
- As the package name "com.digitalnarwhals.caravaneering.caravaneering" is already used in our testing, you may need to change the package name to something different. There are mutiple places you will need to change this in the directory "%source%/android/app".
- After creating the OAuth key, set up the OAuth consent screen in the Google Cloud Console under APIs and Services. In the "Scopes" step, add the "auth/fitness.activity.read" scope from the Fitness API.
5. During step 4, you would need to supply the SHA fingerprint of a certificate used to sign the app. Using the same certificate details (key alias, key password, keystore password) in the file "%source%/android/key.properties" write:

---------------------------------------
storePassword=<your keystore password>
keyPassword=<your key password>
keyAlias=<your key alias>
storeFile=<path to store file>
---------------------------------------

For example: If you are on linux and using the default debug keystore

---------------------------------------
storePassword=android
keyPassword=android
keyAlias=androiddebugkey
storeFile=~/.android/debug.keystore
---------------------------------------

Note: Step 4 (but not step 5) may only be necessary to enable background tracking of steps. However this is untested.

---------- Build and Pubspec ----------
If using Android Studio, open the project folder and build normally. If Android Studio does not automatically get packages then run "flutter pub get" in the root project directory.

If not using Android Studio, run in the root directory:
1. flutter pub get
2. flutter build apk
