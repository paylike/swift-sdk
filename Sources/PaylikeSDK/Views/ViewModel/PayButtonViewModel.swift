//
//  PayButtonViewModel.swift
//  
//
//  Created by Székely Károly on 2023. 05. 26..
//

import Foundation
import SwiftUI
import PaylikeClient

public let defaultButtonStyle = PayButtonStyle()

public class PayButtonViewModel: ObservableObject {
    @Published var amount: PaymentAmount
    @Published var styling: PayButtonStyle
    private (set) var submit: () async -> Void

    @Published var disabled: Bool
    
    public var displayAmount: String {
        // TODO Localize currency
        return "\(Double(amount.value) / pow(Double(10), Double(amount.exponent))) \(amount.currency)"
    }
    
    public init(amount: PaymentAmount, styling: PayButtonStyle = defaultButtonStyle, submit: @escaping () async -> Void = {}, disabled: Bool = false) {
        self.amount = amount
        self.styling = styling
        self.submit = submit
        self.disabled = disabled
    }
}
