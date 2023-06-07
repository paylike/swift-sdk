//
//  SimpleWhitelabelPaymentFormViewModel.swift
//  
//
//  Created by Székely Károly on 2023. 05. 19..
//

import Foundation
import PaylikeEngine
import PaylikeClient
import PaylikeLuhn

typealias onSuccessHandler = () -> Void
typealias onErrorHandler = () -> Void

public class SimpleWhitelabelPaymentFormViewModel: ObservableObject {
    private var engine: PaylikeEngine
    
    private var onSuccess: onSuccessHandler
    private var onError: onErrorHandler
    
    @Published var cardNumber: String = "";
    @Published var expiryDate: String = "";
    @Published var cvc: String = "";
    
    @Published var amount: PaymentAmount
    
    @Published var isLoading: Bool = false
    var errorMessage: String? {
        return engine.error?.message
    }

    func submit() async -> Void {
        isLoading = true
        if (self.isFormValid()) {
            await engine.addEssentialPaymentData(cardNumber: self.cardNumber, cvc: self.cvc, expiry: self.cardExpiry!)
            engine.addDescriptionPaymentData(paymentAmount: self.amount, paymentTestData: PaymentTest())
            await self.engine.startPayment()
            // TODO isLoading = false only on success
            isLoading = false
        }
    }
    
    public init(engine: PaylikeEngine, amount: PaymentAmount = PaymentAmount(currency: CurrencyCodes.USD, value: 0, exponent: 0)) {
        self.engine = engine
        self.amount = amount
        // TODO create empty default handlers
        self.onError = { print("onError") }
        self.onSuccess = { print("onSuccess") }
    }
    
    public var payButtonViewModel: PayButtonViewModel {
        let isDisabled = !isFormValid() || isLoading
        return PayButtonViewModel(amount: amount, submit: self.submit, disabled: isDisabled)
    }
    
    public var isCardNumberValid: Bool {
        return validateCardNumber(cardNumber: cardNumber)
    }
    
    public var cardExpiry: CardExpiry? {
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
    
    public var isExpiryDateValid: Bool {
        return validateExpiryDate(cardExpiry: cardExpiry)
    }
    
    public var isCardVerifiacationCodeValid: Bool {
        return validateCardVerificationCode(cvc: cvc)
    }
    
    func isFormValid() -> Bool {
        return isCardNumberValid && isExpiryDateValid && isCardVerifiacationCodeValid
    }
}

extension CardExpiry {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        return formatter.date(from: "\(year)/\(month)")!
    }
}
