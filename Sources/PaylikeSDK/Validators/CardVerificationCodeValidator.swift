import Foundation

// TODO: Add only digits validation

let CARD_VERIFICATION_CODE_LENGTH = 3

/// Validation method for card verification code. Validates for length.
///
/// - Returns:
///     Bool value whether the given cvc is valid.
func validateCardVerificationCode(cvc: String) -> Bool {
    return cvc.count == CARD_VERIFICATION_CODE_LENGTH
}
