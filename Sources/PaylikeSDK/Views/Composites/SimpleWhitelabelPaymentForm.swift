//
//  SimpleWhitelabelPaymentForm.swift
//  
//
//  Created by Székely Károly on 2023. 05. 10..
//

import SwiftUI

struct SimpleWhitelabelPaymentForm: View {
    var body: some View {
        VStack {
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

struct SimpleWhitelabelPaymentForm_Previews: PreviewProvider {
    static var previews: some View {
        SimpleWhitelabelPaymentForm()
    }
}
