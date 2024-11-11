# Size Recommender Plugin

A Flutter plugin that helps recommend an optimal size based on user height and weight inputs.
This plugin uses platform channels to communicate with native code on iOS and Android, providing fast and accurate size recommendation.

## Installation

Add this package to your pubspec.yaml:

```yaml
dependencies:
  size_recommender: ^0.0.1
```

Then, run:

```bash
flutter pub get
```

## Usage

Simply import the `SizeRecommender` class and use the `calculateSizeRecommendation` method:

```dart
import 'package:size_recommender/size_recommender.dart';

void getSizeRecommendation() async {
  final sizeRecommendation = await SizeRecommender().calculateSizeRecommendation(
    heightCm: 180.0,
    weightKg: 75.0,
  );
  print('Recommended Size: $sizeRecommendation');
}
```

## Platform Channel Method

The `SizeRecommender` class uses a platform channel to invoke the native `calculateSizeRecommendation` method:

```dart
class SizeRecommender {
  Future<String?> calculateSizeRecommendation(
      {required double heightCm, required double weightKg}) {
    return SizeRecommenderPlatform.instance
        .calculateSizeRecommendation(heightCm: heightCm, weightKg: weightKg);
  }
}
```

### Parameters

- `heightCm` (double): User's height in centimeters.
- `weightKg` (double): User's weight in kilograms.

### Returns

A `Future<String?>` containing the recommended size, based on input parameters.

## Example

For a user of height `180 cm` and weight `75 kg`, you can call:

```dart
final size = await SizeRecommender().calculateSizeRecommendation(
    heightCm: 180.0, weightKg: 75.0,
);
print('Recommended Size: $size');
```

## Demonstration

![Android Demo](demo/demo.gif)

