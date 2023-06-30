import Foundation
import PaylikeLuhn

// TODO: update with real min max values
// TODO: Add only digits validation
// TODO: Add card provider regex validation includint number lengts (16-19)

let CARD_NUMBER_MIN_LENGTH = 16
let CARD_NUMBER_MAX_LENGTH = 16

/// Validation method for card Numbers. Validates for card number length, for the Luhn algorithm.
///
/// - Returns:
///     Bool value whether the given card number is valid.
func validateCardNumber(cardNumber: String) -> Bool {
    let isAboveMinLength = cardNumber.count >= CARD_NUMBER_MIN_LENGTH
    let isBelowMaxLength = cardNumber.count <= CARD_NUMBER_MAX_LENGTH
    let isLuhnValid = PaylikeLuhn.isValid(cardNumber: cardNumber)
    
    let isLengthValid = isAboveMinLength && isBelowMaxLength
    
    return isLengthValid && isLuhnValid
}
