import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'size_recommender_platform_interface.dart';

/// An implementation of [SizeRecommenderPlatform] that uses method channels.
class MethodChannelSizeRecommender extends SizeRecommenderPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('size_recommender');

  @override
  Future<String?> calculateSizeRecommendation(
      {required double heightCm, required double weightKg}) async {
    return await methodChannel
        .invokeMethod<String>('calculateSizeRecommendation', {
      'heightCm': heightCm.toString(),
      'weightKg': weightKg.toString(),
    });
  }
}
