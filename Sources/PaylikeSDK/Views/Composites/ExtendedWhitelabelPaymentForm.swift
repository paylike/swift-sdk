//
//  ExtendedWhitelabelPaymentForm.swift
//
//
//  Created by Székely Károly on 2023. 05. 10..
//

import SwiftUI
import PaylikeClient

struct ExtendedWhitelabelPaymentForm: View {
    @State private var email: String = "";
    @State private var note: String = "";
    @State private var cardNumber: String = "";
    
    @State private var expiryDate: String = "";
    
    @State private var cvc: String = "";
    
    var body: some View {
        VStack {
            AdditionalTextField(label: "e-mail", placeholder: "john@doe.com", value: $email)
            AdditionalTextField(label: "Note", placeholder: "additional text", value: $note)
            CardNumberField(cardNumber: $cardNumber, isValid: true)
            HStack {
                ExpiryDateField(expiryDate: $expiryDate, isValid: true)
                CardValidationCodeField(cvc: $cvc, isValid: true)
            }
            PayButton(displayAmount: "200 EUR", submit: {}, disabled: false)
            SecurePaymentLabel()
        }.padding()
    }
}

struct ExtendedWhitelabelPaymentForm_Previews: PreviewProvider {
    static var previews: some View {
        ExtendedWhitelabelPaymentForm()
    }
}
