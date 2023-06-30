//
//  Paylike.swift
//  
//
//  Created by Károly Székely on 2023. 06. 19..
//

import AnyCodable
import Foundation
import PaylikeEngine
import PaylikeClient

public typealias PaylikeError = EngineErrorObject

public typealias OnSuccessHandler = () -> Void
public typealias OnErrorHandler = (_ error: PaylikeError) -> Void
public typealias BeforePayment = (_ engine: PaylikeEngine,
                                  _ cardNumber: String,
                                  _ cvc: String,
                                  _ cardExpiry: CardExpiry,
                                  _ textData: String?,
                                  _ customData: AnyEncodable?) -> Void

/// Public protocol for PaylikeViewModels which use PaylikeEngine under the hood
public protocol PaylikeViewModel: ObservableObject {
    
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
    init(engine: PaylikeEngine, onSuccess: OnSuccessHandler?, onError: OnErrorHandler?, beforePayment: BeforePayment?)

    /// Sets PaymentAmount in the viewModel. It will be set in the engine before starting the Payment process
    func addPaymentAmount(_ amount: PaymentAmount)
    /// Sets Plan Data in the viewModel. It will be set in the engine before starting the Payment process
    func addPaymentPlanDataList(_ paymentPlanDataList: [PaymentPlan])
    /// Sets Unplanned Data in the viewModel. It will be set in the engine before starting the Payment process
    func addPaymentUnplannedData(_ paymentUnplannedData: PaymentUnplanned)
    /// Sets Test Data in the viewModel. It will be set in the engine before starting the Payment process. Use Test Data to test card scenarios, such as expired card
    func addPaymentTestData(_ testData: PaymentTest)
    func addDescriptionPaymentData(paymentAmount: PaymentAmount?, paymentPlanDataList: [PaymentPlan]?, paymentUnplannedData: PaymentUnplanned?, paymentTestData: PaymentTest?)
    /// Sets Additional Payment Data in the viewModel. It will be set in the engine before starting the Payment process
    func addAdditionalPaymentData(textData: String?, customData: AnyEncodable?)
    /// Resets internal values of the viewModel, and the Engine.
    func resetViewModelAndEngine()
}
