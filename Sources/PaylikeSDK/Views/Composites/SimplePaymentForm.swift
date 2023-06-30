import SwiftUI
import PaylikeClient
import PaylikeEngine

/// Simple card Payment form. Uses ``SimplePaymentFormViewModel`` as view model. Consists of card payment forms and a payment button. Will show error messages, loading state, and will Render WebView when needed. In case of a succesful payment flow, a success overlay will be shown, redirection should be solved via the viewModel closures.
public struct SimplePaymentForm: View {
    @ObservedObject private var viewModel: SimplePaymentFormViewModel
    
    public init(viewModel: SimplePaymentFormViewModel) {
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
                        CardVerificationCodeField(cvc: $viewModel.cvc, isValid: viewModel.isCardVerifiacationCodeValid)
                    }
                    PayButton(
                        displayAmount: viewModel.payButtonDisplayAmount,
                        submit:
                            {
                                /// Keyboard functionality is not supported for the target macOs version
                                #if os(iOS)
                                hideKeyboard()
                                #endif
                                await viewModel.submit()
                            },
                        disabled: viewModel.payButtonDisabled
                    )
                    SecurePaymentLabel()
            }

            if viewModel.isLoading || viewModel.playSuccessAnimation {
                LoadingOverlay(playSuccessAnimation: viewModel.playSuccessAnimation)
                    .frame(maxHeight: 200)
                    .aspectRatio(contentMode: .fit)
            }

            if viewModel._shouldRenderWebView {
                viewModel.engine.webViewModel!.paylikeWebView
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
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
