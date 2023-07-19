# Flutter Native Screenshot and share image

Works both on Android & iOS.

## Dependencies

flutter_native_screenshot: ^1.1.2 from https://pub.dev/packages/flutter_native_screenshot.

share_plus: 4.5.0 from https://pub.dev/packages/share_plus.

path_provider: 2.0.5 from https://pub.dev/packages/path_provider.

permission_handler: 8.3.0 from https://pub.dev/packages/permission_handler.

### How to Install

Open the **pubspec.yaml** file and add the following lines of code inside your `dependencies`.

```
native_screenshot_and_share: ^<latest_version>
```

Note: Please replace <latest_version> with the value of the latest version of this plugin.

#### Android

For the Android platform, you must add the following permissions to the **AndroidManifest.xml** file.

```
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.INTERNET"/>
```

And don't forget to add the following properties to the tags `application` in the **AndroidManifest.xml** file.

```
android:requestLegacyExternalStorage="true"
```

#### iOS

For iOS platforms, you must add the following permissions to the **Info.plist** file.

```
<key>NSPhotoLibraryAddUsageDescription</key>
<string>Take pretty screenshots and save it to the PhotoLibrary.</string>
```

### How to use

Import the package.

```
import 'package:native_screenshot_and_share/native_screenshot_and_share.dart';
```

Call the function that will take the screenshot and share it. This is usually in button press.

```
await Screenshot(context).shareScreenShot();
```

### Usage Example

For examples of usage, please see in the **example** project.
