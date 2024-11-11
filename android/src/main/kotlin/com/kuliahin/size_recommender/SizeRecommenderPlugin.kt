package com.kuliahin.size_recommender

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SizeRecommenderPlugin */
class SizeRecommenderPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "size_recommender")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, result: Result) {
        if (call.method == "calculateSizeRecommendation") {
            try {
                val arguments = call.arguments() as? Map<String, String?>?

                val heightCm = arguments?.get("heightCm")?.toDouble()
                    ?: throw IllegalArgumentException("heightCm shouldn't be null")
                val weightKg = arguments?.get("weightKg")?.toDouble()
                    ?: throw IllegalArgumentException("weightKg shouldn't be null")

                val recommendedSize = calculateSizeRecommendation(heightCm, weightKg)

                result.success(recommendedSize)
            } catch (e: Exception) {
                result.error("calculateSizeRecommendation", e?.message, null)
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
