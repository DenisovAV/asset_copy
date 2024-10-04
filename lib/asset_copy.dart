import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class AssetCopy {
  static const MethodChannel _channel = MethodChannel('asset_copy_plugin');

  static Future<void> copyAssetToLocalStorage(String assetName, String targetName) async {
    final String targetPath = await _getLocalFilePath(targetName);
    await _channel.invokeMethod('copyAssetToLocal', {
      'assetName': 'assets/$assetName',
      'targetPath': targetPath,
    });
  }

  static Future<String> _getLocalFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }
}
