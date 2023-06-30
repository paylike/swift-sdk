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
    var paylikeViewModel: SimplePaymentFormViewModel

    init(engine: PaylikeEngine) {
        // Create the exampleViewModel inside the init method, so the closures can be used by paylikeViewModel
        let exampleViewModel = SimpleExampleViewModel()
        paylikeViewModel = SimplePaymentFormViewModel(engine: engine, amount: PaymentAmount(currency: .EUR, value: 30, exponent: 0), onSuccess: exampleViewModel.onSuccess)
        self.exampleViewModel = exampleViewModel

        paylikeViewModel.addPaymentTestData(PaymentTest())
    }

    var body: some View {
        ZStack {
            SimplePaymentForm(viewModel: paylikeViewModel)
            ExampleSuccessOverlay(showOverlay: exampleViewModel.showSuccessOverlay)
        }
        .onDisappear {
            paylikeViewModel.resetViewModelAndEngine()
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
