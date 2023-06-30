import Foundation
import PaylikeClient

/// Validation method for card expiry date. Validates that the date is not in the future, and that the cardExpiry struct can be constructed in the correct format.
///
/// - Returns:
///     Bool value whether the given expiry is valid.
func validateExpiryDate(cardExpiry: CardExpiry?) -> Bool {
    let isFormatValid = cardExpiry != nil
    if isFormatValid {
        let isInFuture = cardExpiry!.toDate() > Date()
        return isInFuture
    }
    return false
}
