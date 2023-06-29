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



class SimpleExampleViewModel: ObservableObject {
    @Published var showSuccessOverlay = false

    func onSuccess() -> Void {
        showSuccessOverlay = true
    }
}

struct SimplePaylikeExample: View {
    @ObservedObject var exampleViewModel: SimpleExampleViewModel
    var viewModel: SimplePaymentFormViewModel

    init(engine: PaylikeEngine) {
        let exampleViewModel = SimpleExampleViewModel()
        viewModel = SimplePaymentFormViewModel(engine: engine, amount: PaymentAmount(currency: .EUR, value: 30, exponent: 0), onSuccess: exampleViewModel.onSuccess)
        self.exampleViewModel = exampleViewModel

        viewModel.addPaymentTestData(PaymentTest())
    }

    var body: some View {
        ZStack {
            SimplePaymentForm(viewModel: viewModel)
            ExampleSuccessOverlay(showOverlay: exampleViewModel.showSuccessOverlay)
        }
        .onDisappear {
            viewModel.resetViewModelAndEngine()
            exampleViewModel.showSuccessOverlay = false
        }
    }
}

struct SimplePaylikeExample_Previews: PreviewProvider {
    static var previews: some View {
        SimplePaylikeExample(engine: getEngine())
            .environmentObject(PaylikeTheme)
    }
}
