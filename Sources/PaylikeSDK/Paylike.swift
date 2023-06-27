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

public protocol PaylikeViewModel: ObservableObject {
    init(engine: PaylikeEngine, onSuccess: OnSuccessHandler?, onError: OnErrorHandler?)

    func addPaymentAmount(_ amount: PaymentAmount)
    func addPaymentPlanDataList(_ paymentPlanDataList: [PaymentPlan])
    func addPaymentUnplannedData(_ paymentUnplannedData: PaymentUnplanned)
    func addPaymentTestData(_ testData: PaymentTest)
    func addDescriptionPaymentData(paymentAmount: PaymentAmount?, paymentPlanDataList: [PaymentPlan]?, paymentUnplannedData: PaymentUnplanned?, paymentTestData: PaymentTest?)
    
    func addAdditionalPaymentData(textData: String?, customData: AnyEncodable?)
}
