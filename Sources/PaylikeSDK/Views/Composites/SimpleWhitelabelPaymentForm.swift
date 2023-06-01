//
//  SimpleWhitelabelPaymentForm.swift
//  
//
//  Created by Székely Károly on 2023. 05. 10..
//

import SwiftUI
import PaylikeClient
import PaylikeEngine

public struct SimpleWhitelabelPaymentForm: View {
    @ObservedObject var viewModel: SimpleWhitelabelPaymentFormViewModel
    
    init(viewModel: SimpleWhitelabelPaymentFormViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            VStack {
                if viewModel.errorMessage != nil, let message = viewModel.errorMessage {
                    ErrorLog(message: message)
                }
                CardNumberField(cardNumber: $viewModel.cardNumber, isValid: viewModel.isCardNumberValid)
                HStack {
                    ExpiryDateField(expiryDate: $viewModel.expiryDate, isValid: viewModel.isExpiryDateValid)
                    CardValidationCodeField(cvc: $viewModel.cvc, isValid: viewModel.isCardVerifiacationCodeValid)
                }
                PayButton(viewModel.payButtonViewModel)
                SecurePaymentLabel(color: Color.PaylikeGreen)
            }.padding()
            LoadingOverlay().opacity(viewModel.isLoading ? 1.0 : 0.0)
        }
    }
}

struct SimpleWhitelabelPaymentForm_Previews: PreviewProvider {
    static var previews: some View {
        SimpleWhitelabelPaymentForm(viewModel:  SimpleWhitelabelPaymentFormViewModel(engine: PaylikeEngine(merchantID: "e393f9ec-b2f7-4f81-b455-ce45b02d355d", engineMode: .TEST, loggingMode: .DEBUG), amount: PaymentAmount(currency: CurrencyCodes.BHD, value: 300000, exponent: 2)))
    }
}
