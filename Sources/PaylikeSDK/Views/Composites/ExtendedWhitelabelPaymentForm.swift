//
//  ExtendedWhitelabelPaymentForm.swift
//
//
//  Created by Székely Károly on 2023. 05. 10..
//

import SwiftUI

struct ExtendedWhitelabelPaymentForm: View {
    @State private var email: String = "";
    @State private var note: String = "";
    
    var body: some View {
        VStack {
            AdditionalTextField(label: "e-mail", placeholder: "john@doe.com", value: $email)
            AdditionalTextField(label: "Note", placeholder: "additional text", value: $note)
            CardNumberField()
            HStack {
                ExpiryDateField()
                CardValidationCodeField()
            }
            PayButton("30$")
            SecurePaymentLabel()
        }.padding()
    }
}

struct ExtendedWhitelabelPaymentForm_Previews: PreviewProvider {
    static var previews: some View {
        ExtendedWhitelabelPaymentForm()
    }
}
