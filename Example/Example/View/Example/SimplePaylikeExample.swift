//
//  SimplePaylikeExample.swift
//
//  Created by Károly Székely on 2023. 06. 20..
//

import SwiftUI
import Foundation
import PaylikeClient
import PaylikeEngine
import PaylikeSDK



class SimpleExampleClosures: ObservableObject {
    @Published var showSuccessMessage = false

    func onSuccess() -> Void {
        showSuccessMessage = true
    }
}

struct SimplePaylikeExampleView: View {
    var viewModel: SimplePaymentFormViewModel
    
    @ObservedObject var closures: SimpleExampleClosures

    init(engine: PaylikeEngine) {
        let closures = SimpleExampleClosures()
        viewModel = SimplePaymentFormViewModel(engine: engine, onSuccess: closures.onSuccess)
        self.closures = closures
        
        viewModel.addPaymentAmount(PaymentAmount(currency: .EUR, value: 30, exponent: 0))
        viewModel.addPaymentTestData(PaymentTest())
    }

    var body: some View {
        ZStack {
            SimplePaymentForm(viewModel: viewModel)
            ZStack {
                Rectangle()
                    .fill(.white)
                    .opacity(0.5)
                Text("Example over, succesful transaction!").font(.headline).foregroundColor(.PaylikeGreen)
            }.opacity(closures.showSuccessMessage ? 1.0 : 0.0)
        }
    }
}
