//
//  SimplePaymentForm.swift
//  
//
//  Created by Székely Károly on 2023. 05. 10..
//

import SwiftUI
import PaylikeClient
import PaylikeEngine

public struct SimplePaymentForm: View {
    @ObservedObject private var viewModel: SimplePaymentFormViewModel
    
    public init(viewModel: SimplePaymentFormViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            VStack {
                if viewModel._errorMessage != nil, let message = viewModel._errorMessage {
                    ErrorLog(message: message)
                }
                CardNumberField(cardNumber: $viewModel.cardNumber, isValid: viewModel.isCardNumberValid)
                HStack {
                    ExpiryDateField(expiryDate: $viewModel.expiryDate, isValid: viewModel.isExpiryDateValid)
                    CardValidationCodeField(cvc: $viewModel.cvc, isValid: viewModel.isCardVerifiacationCodeValid)
                }
                PayButton(
                    displayAmount: viewModel.payButtonDisplayAmount,
                    submit:
                        {
                            #if os(iOS)
                            hideKeyboard()
                            #endif
                            await viewModel.submit()
                        },
                    disabled: viewModel.payButtonDisabled
                )
                SecurePaymentLabel()
            }
            
            LoadingOverlay()
                .opacity(viewModel.isLoading ? 1.0 : 0.0)
            
            if viewModel.shouldRenderWebView {
                viewModel.engine.webViewModel!.paylikeWebView
                    .frame(maxWidth: .infinity, maxHeight: 400, alignment: .center)
            }
        }
    }
}

#if os(iOS)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct SimplePaymentForm_Previews: PreviewProvider {
    static var previews: some View {
        SimplePaymentForm(viewModel:  SimplePaymentFormViewModel(engine: PaylikeEngine(merchantID: "YOUR KEY", engineMode: .TEST, loggingMode: .DEBUG), amount: PaymentAmount(currency: CurrencyCodes.BHD, value: 300000, exponent: 2)))
            .environmentObject(PaylikeTheme)
    }
}
