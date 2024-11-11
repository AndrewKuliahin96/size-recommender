import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:size_recommender/size_recommender.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final SizeRecommender plugin = SizeRecommender();

  group('SizeRecommender Integration Tests', () {
    testWidgets('calculateSizeRecommendation - Size S (BMI < 18.5)', (WidgetTester tester) async {
      final String? size = await plugin.calculateSizeRecommendation(heightCm: 180, weightKg: 50);
      expect(size, 'S');
    });

    testWidgets('calculateSizeRecommendation - Size M (18.5 <= BMI < 25)', (WidgetTester tester) async {
      final String? size = await plugin.calculateSizeRecommendation(heightCm: 170, weightKg: 65);
      expect(size, 'M');
    });

    testWidgets('calculateSizeRecommendation - Size L (25 <= BMI < 30)', (WidgetTester tester) async {
      final String? size = await plugin.calculateSizeRecommendation(heightCm: 160, weightKg: 75);
      expect(size, 'L');
    });

    testWidgets('calculateSizeRecommendation - Size XL (BMI >= 30)', (WidgetTester tester) async {
      final String? size = await plugin.calculateSizeRecommendation(heightCm: 160, weightKg: 85);
      expect(size, 'XL');
    });

    testWidgets('calculateSizeRecommendation - Edge Case BMI 18.5', (WidgetTester tester) async {
      final String? size = await plugin.calculateSizeRecommendation(heightCm: 170, weightKg: 53.465);
      expect(size, 'M');
    });

    testWidgets('calculateSizeRecommendation - Edge Case BMI 24.9', (WidgetTester tester) async {
      final String? size = await plugin.calculateSizeRecommendation(heightCm: 170, weightKg: 72.138);
      expect(size, 'M');
    });

    testWidgets('calculateSizeRecommendation - Edge Case BMI 25', (WidgetTester tester) async {
      final String? size = await plugin.calculateSizeRecommendation(heightCm: 170, weightKg: 72.25);
      expect(size, 'L');
    });

    testWidgets('calculateSizeRecommendation - Edge Case BMI 30', (WidgetTester tester) async {
      final String? size = await plugin.calculateSizeRecommendation(heightCm: 170, weightKg: 86.7);
      expect(size, 'XL');
    });
  });
}
