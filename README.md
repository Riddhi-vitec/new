# template_flutter_mvvm_repo_bloc

Welcome to the template_flutter_mvvm_repo_bloc repository, a robust starting point for your Flutter application development.

## Getting Started

If this is your initial encounter with Flutter and Vitec Family, here are some essential steps to kickstart your project:

### App Renaming and BundleID Configuration

1. **Customize App Name:**
   - Execute the following command in your terminal:
     ```bash
     rename setAppName --targets ios,android --value "Your App Name"
     ```

2. **Adjust App Bundle ID:**
   - Execute the following command in your terminal:
     ```bash
     rename setBundleId --targets android,ios --value "com.example.app"
     ```

3. **Retrieve Current App Name:**
   - Run this command in your terminal to get the current App Name for a specific platform:
     ```bash
     rename getAppName --targets ios,android
     ```

4. **Manage BundleID:**
   - Run this command in your terminal to retrieve or set the BundleId for the specified platforms:
     ```bash
     rename getBundleId --targets android
     ```

### Managing jks Files and key.properties

1. Create a file named `[project]/android/key.properties` that references your keystore.
   - For reference, check the uploaded `key.properties` located at `android/key.properties`.

2. If you already have an existing keystore, proceed to the next step. Otherwise, create one by either:

   - Following the Android Studio key generation steps.

   - Running the following command at the command line:

      - On macOS or Linux:
          ```bash
          keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
          ```

      - On Windows (PowerShell):
          ```powershell
          keytool -genkey -v -keystore F:\vitec\Template-Flutter-MVVM-Repo-Bloc\android\app\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
          ```

   Ensure consistency in the `keyAlias` name and .jks file name, and choose a robust password. Share the `upload-keystore.jks` and `key.properties` files with your co-developer.

**Important**: Avoid pushing these files to GitHub. They are included here as a template, but remember to add `upload-keystore.jks` and `key.properties` to your `.gitignore`.


### Release Certificate Fingerprint (Sha1 and Sha256)

```bash
keytool -list -v -alias upload -keystore F:\vitec\Template-Flutter-MVVM-Repo-Bloc\android\app\upload-keystore.jks
```

### Debug Certificate Fingerprint (Sha1 and Sha256)

#### Windows

```bash
keytool -list -v -alias androiddebugkey -keystore C:\Users\Rafia\.android\debug.keystore
```

#### Mac/Linux

```bash
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
```

Make sure to run these commands in your terminal to obtain the certificate fingerprints. These fingerprints are useful for tasks such as setting up OAuth credentials or configuring app signing in the Google Play Console.

## Note

The `.jks` and `.properties` files will be utilized in your CI/CD pipeline with the help of GitHub secrets. This reinforces the importance of not uploading them to the repository.

### Getting the Hash Key for Facebook Sign-In

To generate a hash of your release key, use the following command on either Mac or Windows, replacing `<RELEASE_KEY_ALIAS>` with your actual release key alias and `<RELEASE_KEY_PATH>` with the path to your keystore.

## On Mac OS

```bash
keytool -exportcert -alias <RELEASE_KEY_ALIAS> -keystore <RELEASE_KEY_PATH> | openssl sha1 -binary | openssl base64
```
## Setting up OpenSSL for Windows

To get started, download OpenSSL for Windows from [this link](https://code.google.com/archive/p/openssl-for-windows/downloads).

Next, create a folder named, e.g., `openssl-0.9.8k_X64.zip` inside your preferred directory. In my case, I've chosen `C:\Users\Rafia`.

Open a command prompt window and navigate to your Java Development Kit (JDK - at the time of coding it is jdk-19) directory. For instance, in my setup, the command would be:

```bash
cd C:\Program Files\Java\jdk-19
```

Now, execute the following command:

```bash
keytool -exportcert -alias upload -keystore F:\vitec\Template-Flutter-MVVM-Repo-Bloc\android\app\upload-keystore.jks | C:\Users\Rafia\openssl-0.9.8k_X64\bin\openssl sha1 -binary | C:\Users\Rafia\openssl-0.9.8k_X64\bin\openssl base64
```

This will generate the necessary output for your specific configuration.

### For generating hash key from online (debug or release)

You can use the online tool provided at [https://tomeko.net/online_tools/hex_to_base64.php](https://tomeko.net/online_tools/hex_to_base64.php). This tool allows you to convert a hexadecimal value to its base64 representation, which can be useful in various debugging scenarios.

Here's how you can use it:

1. Visit [https://tomeko.net/online_tools/hex_to_base64.php](https://tomeko.net/online_tools/hex_to_base64.php).
2. Paste the hexadecimal value you want to debug into the input field.
3. Click the "Convert" button.
4. The tool will generate the corresponding base64 representation.

This can be particularly helpful when dealing with cryptographic operations or when working with systems that use hash keys for authentication or data integrity verification.

### Commands for generating apk according to flavors 
## Flavor: dev
Run this in your IDE terminal
```bash
flutter build apk -t lib/main_dev.dart --flavor=dev  --split-per-abi   
```
## Flavor: prod
Run this in your IDE terminal
```bash
flutter build apk -t lib/main_prod.dart --flavor=prod  --split-per-abi   
```
### Command for creating an aab file
Run this in your IDE terminal
```bash
flutter build appbundle --release -t lib/main_prod.dart --flavor=prod
```
## Note
version: 1.0.0+1 has must be incremented by 1 every time new changes are made before generating an aab file

## Command for firebase integration for IOS
- import Firebase as plugin in AppDelegate.swift file
- Add FirebaseApp.configure() inside bool {} 

## Isar db class generation command:
 Run this command every time you create a new entity
```bash
  flutter pub run build_runner build  
```