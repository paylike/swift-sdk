//
//  CardNumberValidator.swift
//  
//
//  Created by Székely Károly on 2023. 05. 22..
//

import Foundation
import PaylikeLuhn

// TODO update with real min max values
let CARD_NUMBER_MIN_LENGTH = 16
let CARD_NUMBER_MAX_LENGTH = 16

func validateCardNumber(cardNumber: String) -> Bool {
    let isAboveMinLength = cardNumber.count >= CARD_NUMBER_MIN_LENGTH
    let isBelowMaxLength = cardNumber.count <= CARD_NUMBER_MAX_LENGTH
    let isLuhnValid = PaylikeLuhn.isValid(cardNumber: cardNumber)
    
    let isLengthValid = isAboveMinLength && isBelowMaxLength
    
    return isLengthValid && isLuhnValid
}
