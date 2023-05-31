//
//  SimpleWhitelabelPaymentFormModel.swift
//  
//
//  Created by Székely Károly on 2023. 05. 16..
//

import Foundation
import PaylikeClient
import PaylikeRequest
import PaylikeEngine

struct PaymentFormModel {
    
    func onPaymentButton(engine: PaylikeEngine, cardNumber: String, cvc: String, expiryMonth: Int, expiryYear: Int) {
        var req: CreatePaymentRequest = CreatePaymentRequest(merchantID: PaymentIntegration(merchantId: "kek"))
        do {
            req.amount = try PaymentAmount(currency: CurrencyCodes.EUR, double: 2000)
        } catch {
            return
        }
    }
}
