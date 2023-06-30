import AnyCodable
import SwiftUI
import PaylikeEngine
import PaylikeSDK
import PaylikeClient

/// Showcase encodable custom data that can be passed to the payment as additional data
struct CustomData: Encodable {
    var email = "not-real@test.com"
    var testArray = [0, 1, 2]
}

class ExtendedExampleViewModel: ObservableObject {
    @Published var showSuccessOverlay = false
    
    // This data can be edited in the example, and is added to the payment as additional data in the beforePayment callback
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

    var paylikeViewModel: SimplePaymentFormViewModel
    
    init(engine: PaylikeEngine) {
        // Create the exampleViewModel inside the init method, so the closures can be used by paylikeViewModel
        let exampleViewModel = ExtendedExampleViewModel()
        paylikeViewModel = SimplePaymentFormViewModel(engine: engine, onSuccess: exampleViewModel.onSuccess, beforePayment: exampleViewModel.beforePayment)
        self.exampleViewModel = exampleViewModel

        paylikeViewModel.addPaymentAmount(PaymentAmount(currency: .EUR, value: 30, exponent: 0))
        paylikeViewModel.addPaymentTestData(PaymentTest())
    }

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("ADDITIONAL TEXT DATA")
                    .bold()
                TextField<Text>("Text Data", text: $exampleViewModel.textData)
                SimplePaymentForm(viewModel: paylikeViewModel)
            }
            ExampleSuccessOverlay(showOverlay: exampleViewModel.showSuccessOverlay)
        }
        .onDisappear {
            paylikeViewModel.resetViewModelAndEngine()
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
