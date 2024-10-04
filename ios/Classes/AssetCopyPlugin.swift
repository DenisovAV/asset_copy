import Flutter
import UIKit

public class AssetCopyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "asset_copy_plugin", binaryMessenger: registrar.messenger())
    let instance = AssetCopyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "copyAssetToLocal" {
      guard let args = call.arguments as? [String: Any],
            let assetName = args["assetName"] as? String,
            let targetPath = args["targetPath"] as? String else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments", details: nil))
        return
      }

      do {
        try copyAsset(assetName: assetName, targetPath: targetPath)
        result(nil)
      } catch {
        result(FlutterError(code: "ERROR", message: "Failed to copy asset", details: error.localizedDescription))
      }
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  private func copyAsset(assetName: String, targetPath: String) throws {
    let flutterAssetPath = FlutterDartProject.lookupKey(forAsset: assetName)

    guard let bundleAssetPath = Bundle.main.path(forResource: flutterAssetPath, ofType: nil) else {
      throw NSError(domain: "Asset not found", code: 404, userInfo: nil)
    }

    let fileManager = FileManager.default
    let targetURL = URL(fileURLWithPath: targetPath)

    if fileManager.fileExists(atPath: targetURL.path) {
      try fileManager.removeItem(at: targetURL)
    }

    try fileManager.copyItem(at: URL(fileURLWithPath: bundleAssetPath), to: targetURL)
  }
}
