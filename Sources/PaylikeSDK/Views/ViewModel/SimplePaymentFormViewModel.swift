//
//  SimplePaymentFormViewModel.swift
//  
//
//  Created by Székely Károly on 2023. 05. 19..
//

import AnyCodable
import Foundation
import PaylikeEngine
import PaylikeClient
import Combine


public class SimplePaymentFormViewModel: PaylikeViewModel {
    
    public required init(engine: PaylikeEngine, onSuccess: OnSuccessHandler? = {}, onError: OnErrorHandler? = { error in }) {
        self.engine = engine
        self.onSuccess = onSuccess
        self.onError = onError
        
        setEngineStateListeners()
    }
    
    public init(engine: PaylikeEngine, amount: PaymentAmount, onSuccess: OnSuccessHandler? = {}, onError: OnErrorHandler? = { error in }) {
        self.engine = engine
        self.amount = amount
        self.onError = onError
        self.onSuccess = onSuccess
        
        setEngineStateListeners()
    }
    
    public func addPaymentAmount(_ amount: PaymentAmount) {
        self.amount = amount
    }
    
    public func addPaymentPlanDataList(_ paymentPlanDataList: [PaymentPlan]) {
        self.paymentPlanDataList = paymentPlanDataList
    }
    
    public func addPaymentUnplannedData(_ paymentUnplannedData: PaymentUnplanned) {
        self.paymentUnplannedData = paymentUnplannedData
    }
    
    public func addPaymentTestData(_ paymentTestData: PaymentTest) {
        self.paymentTestData = paymentTestData
    }
    
    public func addDescriptionPaymentData(paymentAmount: PaymentAmount?, paymentPlanDataList: [PaymentPlan]?, paymentUnplannedData: PaymentUnplanned?, paymentTestData: PaymentTest?) {
        self.amount = amount
        self.paymentPlanDataList = paymentPlanDataList
        self.paymentUnplannedData = paymentUnplannedData
        self.paymentTestData = paymentTestData
    }
    
    public func addAdditionalPaymentData(textData: String?, customData: AnyEncodable?) {
        self.paymentTextData = textData
        self.paymentCustomData = customData
    }
    
    @Published var engine: PaylikeEngine
    
    private var onSuccess: OnSuccessHandler?
    private var onError: OnErrorHandler?
    
    @Published var amount: PaymentAmount?
    var paymentTestData: PaymentTest?
    var paymentPlanDataList: [PaymentPlan]?
    var paymentUnplannedData: PaymentUnplanned?
    var paymentTextData: String?
    var paymentCustomData: AnyEncodable?
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var cardNumber: String = "";
    @Published var expiryDate: String = "";
    @Published var cvc: String = "";
    
    @Published var isLoading: Bool = false
    @Published var shouldRenderWebView: Bool = false
    
    @Published var _engineState: EngineState?
    @Published var _engineError: EngineErrorObject?
    
    
    var _errorMessage: String? {
        _engineError?.message
    }
    
    var payButtonDisabled: Bool {
        return !isFormValid() || isLoading
    }
    
    var payButtonDisplayAmount: String {
        // TODO Localize currency
        if let amount = self.amount {
            return "\(Double(amount.value) / pow(Double(10), Double(amount.exponent))) \(amount.currency)"
        } else {
            return ""
        }
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
                            self._engineError = error
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
    
    func setEnginePaymentData() async -> Void {
        await engine.addEssentialPaymentData(cardNumber: self.cardNumber, cvc: self.cvc, expiry: self.cardExpiry!)
        engine.addDescriptionPaymentData(paymentAmount: self.amount, paymentPlanDataList: self.paymentPlanDataList, paymentUnplannedData: self.paymentUnplannedData, paymentTestData: self.paymentTestData)
        engine.addAdditionalPaymentData(textData: paymentTextData, customData: paymentCustomData)
    }
    
    func submit() async -> Void {
        if (self.isFormValid()) {
            await MainActor.run {
                isLoading = true
            }
            await setEnginePaymentData()

            await self.engine.startPayment()
        }
    }
    
    func onStateChange(state: EngineState) {
        if state == EngineState.SUCCESS {
            isLoading = false
            if onSuccess != nil {
                onSuccess!()
            }
        }
        if state == EngineState.ERROR {
            isLoading = false
            if onError != nil {
                onError!(_engineError!)
            }
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
