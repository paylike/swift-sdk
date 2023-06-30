//
//  CardVerificationCodeValidator.swift
//  
//
//  Created by Székely Károly on 2023. 05. 31..
//

import Foundation

// TODO: Add only digits validation

let CARD_VERIFICATION_CODE_LENGTH = 3

func validateCardVerificationCode(cvc: String) -> Bool {
    return cvc.count == CARD_VERIFICATION_CODE_LENGTH
}
