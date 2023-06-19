//
//  SimpleWhitelabelPaymentFormViewModel.swift
//  
//
//  Created by Székely Károly on 2023. 05. 19..
//

import Foundation
import PaylikeEngine
import PaylikeClient
import Combine

public typealias onSuccessHandler = () -> Void
public typealias onErrorHandler = () -> Void

public class SimpleWhitelabelPaymentFormViewModel: ObservableObject {
    @Published var engine: PaylikeEngine
    
    private var onSuccess: onSuccessHandler
    private var onError: onErrorHandler
    private var cancellables: Set<AnyCancellable> = []

    @Published var cardNumber: String = "";
    @Published var expiryDate: String = "";
    @Published var cvc: String = "";
    
    @Published var amount: PaymentAmount
    
    @Published var isLoading: Bool = false
    @Published var shouldRenderWebView: Bool = false
    
    @Published var _engineState: EngineState?
    @Published var _errorMessage: String? = nil
    
    func submit() async -> Void {
        if (self.isFormValid()) {
            await MainActor.run {
                isLoading = true
            }
            await engine.addEssentialPaymentData(cardNumber: self.cardNumber, cvc: self.cvc, expiry: self.cardExpiry!)
            engine.addDescriptionPaymentData(paymentAmount: self.amount)
            await self.engine.startPayment()
        }
    }
    
    public init(engine: PaylikeEngine, amount: PaymentAmount = PaymentAmount(currency: CurrencyCodes.USD, value: 0, exponent: 0), onError: @escaping onErrorHandler = {}, onSuccess: @escaping onSuccessHandler = {}) {
        self.engine = engine
        self.amount = amount
        
        self.onError = onError
        self.onSuccess = onSuccess
        
        setEngineStateListeners()
    }
    
    func setEngineStateListeners() {
        self.cancellables.insert(
            self.engine.state.projectedValue
                .sink(receiveValue: { state in
                    Task {
                        await MainActor.run {
                            self._engineState = state
                            self.onStateChange(state: state)
                        }
                    }
                })
        )
        self.cancellables.insert(
            self.engine.error.projectedValue
                .sink(receiveValue: { error in
                    Task {
                        await MainActor.run {
                            self._errorMessage = error?.message
                        }
                    }
                })
        )
        self.cancellables.insert(
            self.engine.webViewModel!.shouldRenderWebView.projectedValue
                .sink(receiveValue: { shouldRenderWebView in
                    Task {
                        await MainActor.run {
                            self.shouldRenderWebView = shouldRenderWebView
                        }
                    }
                })
        )
    }
    
    var payButtonViewModel: PayButtonViewModel {
        let isDisabled = !isFormValid() || isLoading
        return PayButtonViewModel(amount: amount, submit: self.submit, disabled: isDisabled)
    }
    
    var isCardNumberValid: Bool {
        return validateCardNumber(cardNumber: cardNumber)
    }
    
    var cardExpiry: CardExpiry? {
        if expiryDate.count > 2 {
            let dividerIndex = expiryDate.index(expiryDate.startIndex, offsetBy: 2)
            if let month = Int(expiryDate[..<dividerIndex]) {
                if let year = Int(expiryDate[dividerIndex...]) {
                    do {
                        return try CardExpiry(month: month, year: year)
                    } catch {
                        return nil
                    }
                }
            }
        }
        return nil
    }
    
    var isExpiryDateValid: Bool {
        return validateExpiryDate(cardExpiry: cardExpiry)
    }
    
    var isCardVerifiacationCodeValid: Bool {
        return validateCardVerificationCode(cvc: cvc)
    }
    
    func isFormValid() -> Bool {
        return isCardNumberValid && isExpiryDateValid && isCardVerifiacationCodeValid
    }
    
    func onStateChange(state: EngineState) {
        if state == EngineState.SUCCESS {
            isLoading = false
            onSuccess()
        }
        if state == EngineState.ERROR {
            isLoading = false
            onError()
        }
    }
}

extension CardExpiry {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        return formatter.date(from: "\(year)/\(month)")!
    }
}
