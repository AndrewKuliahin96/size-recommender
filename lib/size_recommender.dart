import 'size_recommender_platform_interface.dart';

class SizeRecommender {
  Future<String?> calculateSizeRecommendation(
      {required double heightCm, required double weightKg}) {
    return SizeRecommenderPlatform.instance
        .calculateSizeRecommendation(heightCm: heightCm, weightKg: weightKg);
  }
}
