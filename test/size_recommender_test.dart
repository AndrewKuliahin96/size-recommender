import 'package:flutter_test/flutter_test.dart';
import 'package:size_recommender/size_recommender.dart';
import 'package:size_recommender/size_recommender_platform_interface.dart';
import 'package:size_recommender/size_recommender_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSizeRecommenderPlatform
    with MockPlatformInterfaceMixin
    implements SizeRecommenderPlatform {

  @override
  Future<String?> calculateSizeRecommendation({required double heightCm, required double weightKg}) {
    final double heightM = heightCm / 100;
    final double bmi = weightKg / (heightM * heightM);

    if (bmi < 18.5) return Future.value('S');
    if (bmi < 25.0) return Future.value('M');
    if (bmi < 30.0) return Future.value('L');
    return Future.value('XL');
  }
}

void main() {
  final SizeRecommenderPlatform initialPlatform = SizeRecommenderPlatform.instance;

  test('$MethodChannelSizeRecommender is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSizeRecommender>());
  });

  group('Size Recommendation Tests', () {
    late SizeRecommender sizeRecommender;
    late MockSizeRecommenderPlatform fakePlatform;

    setUp(() {
      sizeRecommender = SizeRecommender();
      fakePlatform = MockSizeRecommenderPlatform();
      SizeRecommenderPlatform.instance = fakePlatform;
    });

    test('Recommends size S for BMI < 18.5', () async {
      expect(await sizeRecommender.calculateSizeRecommendation(heightCm: 180, weightKg: 50), 'S');
    });

    test('Recommends size M for 18.5 <= BMI < 25', () async {
      expect(await sizeRecommender.calculateSizeRecommendation(heightCm: 170, weightKg: 65), 'M');
    });

    test('Recommends size L for 25 <= BMI < 30', () async {
      expect(await sizeRecommender.calculateSizeRecommendation(heightCm: 160, weightKg: 75), 'L');
    });

    test('Recommends size XL for BMI >= 30', () async {
      expect(await sizeRecommender.calculateSizeRecommendation(heightCm: 160, weightKg: 85), 'XL');
    });

    test('Handles edge case for BMI exactly 18.5', () async {
      expect(await sizeRecommender.calculateSizeRecommendation(heightCm: 170, weightKg: 53.465), 'M');
    });

    test('Handles edge case for BMI exactly 24.9', () async {
      expect(await sizeRecommender.calculateSizeRecommendation(heightCm: 170, weightKg: 72.138), 'M');
    });

    test('Handles edge case for BMI exactly 25', () async {
      expect(await sizeRecommender.calculateSizeRecommendation(heightCm: 170, weightKg: 72.25), 'L');
    });

    test('Handles edge case for BMI exactly 30', () async {
      expect(await sizeRecommender.calculateSizeRecommendation(heightCm: 170, weightKg: 86.7), 'XL');
    });
  });

  group('Invalid Input Tests', () {
    late SizeRecommender sizeRecommender;
    late MockSizeRecommenderPlatform fakePlatform;

    setUp(() {
      sizeRecommender = SizeRecommender();
      fakePlatform = MockSizeRecommenderPlatform();
      SizeRecommenderPlatform.instance = fakePlatform;
    });

    test('Throws error for height <= 0', () async {
      expect(
            () async => await sizeRecommender.calculateSizeRecommendation(heightCm: 0, weightKg: 70),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Throws error for weight <= 0', () async {
      expect(
            () async => await sizeRecommender.calculateSizeRecommendation(heightCm: 170, weightKg: 0),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
