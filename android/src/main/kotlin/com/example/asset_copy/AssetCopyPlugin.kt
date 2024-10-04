package com.example.asset_copy

import android.content.res.AssetManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.loader.FlutterLoader
import java.io.File
import java.io.FileOutputStream
import java.io.IOException
import java.io.InputStream

class AssetCopyPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var assetManager: AssetManager
  private lateinit var flutterLoader: FlutterLoader

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "asset_copy_plugin")
    channel.setMethodCallHandler(this)
    assetManager = flutterPluginBinding.applicationContext.assets

    flutterLoader = FlutterLoader()
    flutterLoader.startInitialization(flutterPluginBinding.applicationContext)
    flutterLoader.ensureInitializationComplete(flutterPluginBinding.applicationContext, null)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "copyAssetToLocal") {
      val assetName = call.argument<String>("assetName")!!
      val targetPath = call.argument<String>("targetPath")!!

      try {
        copyAsset(assetName, targetPath)
        result.success(null)
      } catch (e: IOException) {
        result.error("ERROR", "Failed to copy asset", e)
      }
    } else {
      result.notImplemented()
    }
  }

  private fun copyAsset(assetName: String, targetPath: String) {
    val flutterAssetPath = flutterLoader.getLookupKeyForAsset(assetName)

    val inputStream: InputStream = assetManager.open(flutterAssetPath)
    val outFile = File(targetPath)
    val outputStream = FileOutputStream(outFile)

    val buffer = ByteArray(1024)
    var length: Int
    while (inputStream.read(buffer).also { length = it } > 0) {
      outputStream.write(buffer, 0, length)
    }

    inputStream.close()
    outputStream.close()
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
