import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'asset_copy_method_channel.dart';

abstract class AssetCopyPlatform extends PlatformInterface {
  /// Constructs a AssetCopyPlatform.
  AssetCopyPlatform() : super(token: _token);

  static final Object _token = Object();

  static AssetCopyPlatform _instance = MethodChannelAssetCopy();

  /// The default instance of [AssetCopyPlatform] to use.
  ///
  /// Defaults to [MethodChannelAssetCopy].
  static AssetCopyPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AssetCopyPlatform] when
  /// they register themselves.
  static set instance(AssetCopyPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
