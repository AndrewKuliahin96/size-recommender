package com.kuliahin.size_recommender

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.test.Test
import org.mockito.Mockito

/*
 * This demonstrates a simple unit test of the Kotlin portion of this plugin's implementation.
 *
 * Once you have built the plugin's example app, you can run these tests from the command
 * line by running `./gradlew testDebugUnitTest` in the `example/android/` directory, or
 * you can run them directly from IDEs that support JUnit such as Android Studio.
 */

internal class SizeRecommenderPluginTest {

    @Test
    fun `test size S when BMI is less than 18_5`() {
        val height = 180f
        val weight = 50f
        val size = calculateSizeRecommendation(height, weight)
        assertEquals("S", size)
    }

    @Test
    fun `test size M when BMI is between 18_5 and 24_9`() {
        val height = 170f
        val weight = 65f
        val size = calculateSizeRecommendation(height, weight)
        assertEquals("M", size)
    }

    @Test
    fun `test size L when BMI is between 25 and 29_9`() {
        val height = 160f
        val weight = 75f
        val size = calculateSizeRecommendation(height, weight)
        assertEquals("L", size)
    }

    @Test
    fun `test size XL when BMI is 30 or more`() {
        val height = 160f
        val weight = 85f
        val size = calculateSizeRecommendation(height, weight)
        assertEquals("XL", size)
    }

    @Test
    fun `test Invalid input throws IllegalArgumentException for zero or negative height`() {
        val exception = assertThrows(IllegalArgumentException::class.java) {
            calculateSizeRecommendation(0f, 70f)
        }
        assertEquals("Height should be more than 0 cm", exception.message)
    }

    @Test
    fun `test Invalid input throws IllegalArgumentException for zero or negative weight`() {
        val exception = assertThrows(IllegalArgumentException::class.java) {
            calculateSizeRecommendation(170f, 0f)
        }
        assertEquals("Weight should be more than 0 kg", exception.message)
    }

    @Test
    fun `test edge case for size S with BMI exactly 18_5`() {
        val height = 170f
        val weight = 53.465f
        val size = calculateSizeRecommendation(height, weight)
        assertEquals("M", size)  // Результат має бути "M", оскільки BMI = 18.5
    }

    @Test
    fun `test edge case for size M with BMI exactly 24_9`() {
        val height = 170f
        val weight = 72.138f
        val size = calculateSizeRecommendation(height, weight)
        assertEquals("M", size)
    }

    @Test
    fun `test edge case for size L with BMI exactly 25`() {
        val height = 170f
        val weight = 72.25f
        val size = calculateSizeRecommendation(height, weight)
        assertEquals("L", size)
    }

    @Test
    fun `test edge case for size XL with BMI exactly 30`() {
        val height = 170f
        val weight = 86.7f
        val size = calculateSizeRecommendation(height, weight)
        assertEquals("XL", size)
    }
}
