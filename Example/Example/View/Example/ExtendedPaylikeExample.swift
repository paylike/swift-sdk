//
//  ExtendedPaylikeExample.swift
//
//  Created by Károly Székely on 2023. 06. 27..
//

import AnyCodable
import SwiftUI
import PaylikeEngine
import PaylikeSDK
import PaylikeClient


struct CustomData: Encodable {
    var email = "not-real@test.com"
    var testArray = [0, 1, 2]
}

class ExtendedExampleViewModel: ObservableObject {
    @Published var showSuccessOverlay = false
    
    @Published var textData = "this is a test"
    @Published var customData = CustomData()

    func onSuccess() -> Void {
        showSuccessOverlay = true
    }
    
    func beforePayment (engine: PaylikeEngine, _: String, _: String, _: CardExpiry, _: String?, _: AnyEncodable?) -> Void {
        engine.addAdditionalPaymentData(textData: textData, customData: AnyEncodable(customData))
    }
}

struct ExtendedPaylikeExample: View {
    @ObservedObject var exampleViewModel: ExtendedExampleViewModel

    var viewModel: SimplePaymentFormViewModel
    
    init(engine: PaylikeEngine) {
        let exampleViewModel = ExtendedExampleViewModel()
        viewModel = SimplePaymentFormViewModel(engine: engine, onSuccess: exampleViewModel.onSuccess, beforePayment: exampleViewModel.beforePayment)
        self.exampleViewModel = exampleViewModel

        viewModel.addPaymentAmount(PaymentAmount(currency: .EUR, value: 30, exponent: 0))
        viewModel.addPaymentTestData(PaymentTest())
    }

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("ADDITIONAL TEXT DATA")
                    .bold()
                TextField<Text>("Text Data", text: $exampleViewModel.textData)
                SimplePaymentForm(viewModel: viewModel)
            }
            ExampleSuccessOverlay(showOverlay: exampleViewModel.showSuccessOverlay)
        }
        .onDisappear {
            viewModel.resetViewModelAndEngine()
            exampleViewModel.showSuccessOverlay = false
        }
    }
}


struct ExtendedPaylikeExample_Previews: PreviewProvider {
    static var previews: some View {
        ExtendedPaylikeExample(engine: getEngine())
            .environmentObject(PaylikeTheme)
    }
}
