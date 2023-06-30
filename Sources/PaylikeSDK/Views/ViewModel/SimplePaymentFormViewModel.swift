import AnyCodable
import Foundation
import PaylikeEngine
import PaylikeClient
import Combine

/// View model of the ``SimplePaymentForm``. Handles the whole payment flow, and uses `PaylikeEngine` under the hood.
///
/// Use closures to catch the success and error states of the flow. You can inject your own functionality before the payment process starts, in order to set custom data, or do third party logic.
/// You can also reset the view model and the engine after a flow to avoid impossible states.
public final class SimplePaymentFormViewModel: PaylikeViewModel {
    @Published var engine: any Engine
    
    private var onSuccess: OnSuccessHandler?
    private var onError: OnErrorHandler?
    private var beforePayment: BeforePayment?
    
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
    @Published var playSuccessAnimation: Bool = false
    
    // Underscored variables are variables listening to engine value changes. The listening is set up after initialization in the `setEngineStateListeners` method
    @Published var _engineState: EngineState?
    @Published var _engineError: EngineErrorObject?
    @Published var _shouldRenderWebView: Bool = false
    
    var errorMessage: String? {
        _engineError?.message
    }
    
    var payButtonDisabled: Bool {
        return !isFormValid() || isLoading
    }
    
    /// Amount displayed on the payment button with the currency displayed.
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
    
    /// expiryDate converted to a CardExpiry struct. It can only be converted, if the formatting of expiryDate was valid. This variable is used to validate the expiryDate, and set essential payment data
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

    /// Initializer with default parameters. Engine is required, everything else is optional.
    ///
    /// Once the viewModel is set up, do not forget to set up the payment amount with the ``addPaymentAmount(amount: PaymentAmount)`` method, as its requierd to start the payment.
    ///
    /// - Parameters:
    ///   - engine: PaylikeEngine under the hood. You can pass an fresh instance set up with YOUR merchantID
    ///   - onSuccess: closure called when the engine switches to SUCCESS state. It is after the payment is succesful. Redirection at the end of the flow can be implemented in this closure
    ///   - onError: closure called when the engine switches to ERROR state. It is called with the error from the PaylikeEngine as its first parameter
    ///   - beforePayment: closure called after the user hits the PaymentButton, and the essential payment information was set.
    ///   
    public required init(engine: any Engine, onSuccess: OnSuccessHandler? = nil, onError: OnErrorHandler? = nil, beforePayment: BeforePayment? = nil) {
        self.engine = engine
        self.onSuccess = onSuccess
        self.onError = onError
        self.beforePayment = beforePayment
        
        setEngineStateListeners()
    }


    /// Initializer with default parameters and amount. It is preferable to set the PaymentAmount as soon as possible, so the PaymentButton can show the amount to the user.
    ///
    /// - Parameters:
    ///   - engine: PaylikeEngine under the hood. You can pass an fresh instance set up with YOUR merchantID
    ///   - amount: PaymentAmount to initally set
    ///   - onSuccess: closure called when the engine switches to SUCCESS state. It is after the payment is succesful. Redirection at the end of the flow can be implemented in this closure
    ///   - onError: closure called when the engine switches to ERROR state. It is called with the error from the PaylikeEngine as its first parameter
    ///   - beforePayment: closure called after the user hits the PaymentButton, and the essential payment information was set.
    ///
    public init(engine: any Engine, amount: PaymentAmount, onSuccess: OnSuccessHandler? = nil, onError: OnErrorHandler? = nil, beforePayment: BeforePayment? = nil) {
        self.engine = engine
        self.amount = amount
        self.onError = onError
        self.onSuccess = onSuccess
        self.beforePayment = beforePayment
        
        setEngineStateListeners()
    }

    public func addPaymentAmount(_ paymentAmount: PaymentAmount) {
        self.amount = paymentAmount
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
        self.amount = paymentAmount
        self.paymentPlanDataList = paymentPlanDataList
        self.paymentUnplannedData = paymentUnplannedData
        self.paymentTestData = paymentTestData
    }
    
    public func addAdditionalPaymentData(textData: String?, customData: AnyEncodable?) {
        self.paymentTextData = textData
        self.paymentCustomData = customData
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
                            self._shouldRenderWebView = shouldRenderWebView
                        }
                    }
                })
        )
    }
    
    // Set all paymentData data known by the viewModel to the engine. Called after pressing the PaymentButton, but before the `beforePayment` closure
    func setEnginePaymentData() async -> Void {
        await engine.addEssentialPaymentData(cardNumber: self.cardNumber, cvc: self.cvc, month: self.cardExpiry!.month, year: self.cardExpiry!.year)
        engine.addDescriptionPaymentData(paymentAmount: self.amount, paymentPlanDataList: self.paymentPlanDataList, paymentUnplannedData: self.paymentUnplannedData, paymentTestData: self.paymentTestData)
        engine.addAdditionalPaymentData(textData: paymentTextData, customData: paymentCustomData)
    }
    
    // Called when pressing the PaymentButton
    func submit() async -> Void {
        if (self.isFormValid()) {
            await MainActor.run {
                isLoading = true
            }
            await setEnginePaymentData()

            if beforePayment != nil {
                beforePayment!(engine, cardNumber, cvc, cardExpiry!, paymentTextData, paymentCustomData)
            }

            await self.engine.startPayment()
        }
    }
    
    // Handling engine state changes, and calling the right closures.
    func onStateChange(state: EngineState) {
        if state == EngineState.SUCCESS {
            isLoading = false
            playSuccessAnimation = true
            if onSuccess != nil {
                onSuccess!()
            }
        }
        if state == EngineState.ERROR {
            isLoading = false
            if onError != nil && _engineError != nil {
                onError!(_engineError!)
            }
        }
    }
    
    public func resetViewModelAndEngine() {
        self.cardNumber = ""
        self.cvc = ""
        self.expiryDate = ""
        self.isLoading = false
        self.playSuccessAnimation = false
        engine.resetEngine()
    }
}

extension CardExpiry {
    /// Converts CardExpiry to a Date based on the "yyyy/MM" format
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        return formatter.date(from: "\(year)/\(month)")!
    }
}
