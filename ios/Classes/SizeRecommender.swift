import Foundation

public class SizeRecommender {
    
    /// Static function for calculating size recommendation based on BMI.
    ///
    /// - Parameters:
    ///   - heightCm: Height in centimeters.
    ///   - weightKg: Weight in kilograms.
    /// - Returns: Recommended size as a `String`.
    /// - Throws: `NSError` if height or weight is invalid.
    public static func calculateSizeRecommendation(heightCm: Double, weightKg: Double) throws -> String {
        guard heightCm > 0 else { throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Height should be more than 0 cm"]) }
        guard weightKg > 0 else { throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Weight should be more than 0 kg"]) }

        let heightM = heightCm / 100.0
        let bmi = weightKg / (heightM * heightM)

        switch bmi {
        case ..<18.5:
            return "S"
        case 18.5..<25:
            return "M"
        case 25..<30:
            return "L"
        default:
            return "XL"
        }
    }
}
