# Asset Copy Plugin

The **Asset Copy Plugin** allows you to copy files from the Flutter app's assets to the device's local file system on both Android and iOS. This is useful when you need to manipulate or access large files that are bundled within your Flutter app, such as JSON files, images, or other resources.

## Features

- Copy any asset from your Flutter project to the local file system.
- Cross-platform support for both Android and iOS.

## Installation

To install the plugin, add the following line to your `pubspec.yaml` under the dependencies section:

```yaml
dependencies:
  asset_copy: ^1.0.0
```

Then, run:
```shell
flutter pub get
```

## Usage

### 1. Register the asset in `pubspec.yaml`

Make sure the asset file is registered in your Flutter app. Add the following lines to the `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/example.json
```

### 2.  Copy asset to native local file system

Use the plugin to copy the asset to a local path on the device:

```dart
import 'package:asset_copy/asset_copy.dart';

Future<void> copyAssetToLocal() async {
  String status;
  try {
    const assetName = 'example.json';
    const targetPath = 'example.json';

    await AssetCopy.copyAssetToLocalStorage(assetName, targetPath);
    status = 'File copied successfully to $targetPath';
  } on PlatformException catch (e) {
    status = 'Failed to copy asset: ${e.message}';
  }
}
```

## Supported Platforms

- Android
- iOS

## License

This plugin is released under the MIT license. See the [LICENSE](LICENSE) file for details.

