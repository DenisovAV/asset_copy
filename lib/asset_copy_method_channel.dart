import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'asset_copy_platform_interface.dart';

/// An implementation of [AssetCopyPlatform] that uses method channels.
class MethodChannelAssetCopy extends AssetCopyPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('asset_copy');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
