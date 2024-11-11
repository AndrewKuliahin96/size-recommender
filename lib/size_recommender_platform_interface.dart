import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'size_recommender_method_channel.dart';

abstract class SizeRecommenderPlatform extends PlatformInterface {
  /// Constructs a SizeRecommenderPlatform.
  SizeRecommenderPlatform() : super(token: _token);

  static final Object _token = Object();

  static SizeRecommenderPlatform _instance = MethodChannelSizeRecommender();

  /// The default instance of [SizeRecommenderPlatform] to use.
  ///
  /// Defaults to [MethodChannelSizeRecommender].
  static SizeRecommenderPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SizeRecommenderPlatform] when
  /// they register themselves.
  static set instance(SizeRecommenderPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> calculateSizeRecommendation(
      {required double heightCm, required double weightKg}) {
    throw UnimplementedError(
        'calculateSizeRecommendation() has not been implemented.');
  }
}
