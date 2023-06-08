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
    let example: Example
    // TODO Refine Paylike interface
    let viewModel = SimpleWhitelabelPaymentFormViewModel(engine: PaylikeEngine(merchantID: "YOUR_KEY", engineMode: .TEST, loggingMode: .DEBUG), amount: PaymentAmount(currency: CurrencyCodes.BHD, value: 300000, exponent: 2))
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
