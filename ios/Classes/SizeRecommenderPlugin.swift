import Flutter
import UIKit

public class SizeRecommenderPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "size_recommender", binaryMessenger: registrar.messenger())
        let instance = SizeRecommenderPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "calculateSizeRecommendation",
           let args = call.arguments as? [String: Any],
           let heightCm = args["heightCm"] as? Double,
           let weightKg = args["weightKg"] as? Double {
            do {
                let recommendedSize = try SizeRecommender.calculateSizeRecommendation(heightCm: heightCm, weightKg: weightKg)
                result(recommendedSize)
            } catch {
                result(FlutterError(code: "INVALID_INPUT", message: error.localizedDescription, details: nil))
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
