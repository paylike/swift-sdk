//
//  Paylike.swift
//  
//
//  Created by Székely Károly on 2023. 05. 19..
//

import Foundation
import PaylikeEngine


/*
 * API key, may modified in your local machine to run tests with Paylike API
 */
let merchantId = "e393f9ec-b2f7-4f81-b455-ce45b02d355d"
let E2E_DISABLED = merchantId == "YOUR_KEY"

public class Paylike {
    public var helloSDK = "Hello SDK!"
    public var engine: PaylikeEngine

    public init(engine: PaylikeEngine, onPaylikeButton: () -> Void, onUpdateDelegate: () -> Void) {
        self.engine = engine
    }

    public init() {
        self.engine = PaylikeEngine(merchantID: merchantId, engineMode: .TEST, loggingMode: .DEBUG)
    }
}


