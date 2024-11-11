package com.kuliahin.size_recommender

/**
 * Function for getting size recommendation.
 *
 * @param heightCm - body weight in centimeters.
 * @param weightKg - body weight in kilograms.
 * @return [String] recommended size
 */
fun calculateSizeRecommendation(heightCm: Double, weightKg: Double): String {
    // Validate inputs
    if (heightCm <= 0) throw IllegalArgumentException("Height should be more than 0 cm")
    if (weightKg <= 0) throw IllegalArgumentException("Weight should be more than 0 kg")

    // Convert height from cm to meters
    val heightM = heightCm / 100.0
    val bmi = weightKg / (heightM * heightM)

    // Return result based on calculation
    return when {
        bmi < 18.5 -> "S"
        bmi in 18.5..24.9 -> "M"
        bmi in 25.0..29.9 -> "L"
        else -> "XL"
    }
}
