//
//  ExampleWrapperView.swift
//  Example2
//
//  Created by Székely Károly on 2023. 04. 26..
//

import SwiftUI
import PaylikeSDK
import PaylikeEngine
import PaylikeClient

struct ExampleWrapper: View {
    let engine: PaylikeEngine
    var viewModel: SimpleWhitelabelPaymentFormViewModel
    
    init(example: Example) {
        self.example = example
        self.engine = PaylikeEngine(merchantID: "YOUR_CODE", engineMode: .TEST, loggingMode: .DEBUG)
        self.viewModel = SimpleWhitelabelPaymentFormViewModel(engine: engine, amount: PaymentAmount(currency: CurrencyCodes.EUR, value: 100, exponent: 2), onError: { print("on error test") })
    }
    
    let example: Example
    // TODO Refine Paylike interface
    var body: some View {
        VStack {
            Text(example.title)
            SimpleWhitelabelPaymentForm(viewModel: viewModel)
        }
    }
}

struct ExampleWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleWrapper(example: examples[0])
    }
}
