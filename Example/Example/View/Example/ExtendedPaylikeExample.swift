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

class ExtendedExampleClosures: ObservableObject {
    @Published var showSuccessMessage = false
    
    @Published var customData = CustomData()

    func onSuccess() -> Void {
        showSuccessMessage = true
    }
    
    func beforePayment (engine: PaylikeEngine, _: String, _: String, _: CardExpiry, _: String?, _: AnyEncodable?) -> Void {
        engine.addAdditionalPaymentData(textData: "this is a test", customData: AnyEncodable(customData))
    }
}

struct ExtendedPaylikeExample: View {
    var viewModel: SimplePaymentFormViewModel
    
    @ObservedObject var closures: ExtendedExampleClosures
    
    var customDataEmail: Binding<String>

    init(engine: PaylikeEngine) {
        let closures = ExtendedExampleClosures()
        viewModel = SimplePaymentFormViewModel(engine: engine, onSuccess: closures.onSuccess, beforePayment: closures.beforePayment)
        self.closures = closures
        
        self.customDataEmail = Binding<String>(get: {
           closures.customData.email
       }, set: { string in
           closures.customData.email = string
       })
        
        viewModel.addPaymentAmount(PaymentAmount(currency: .EUR, value: 30, exponent: 0))
        viewModel.addPaymentTestData(PaymentTest())
    }

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("CUSTOM DATA EMAIL")
                    .bold()
                TextField<Text>("Custom Data Email", text: customDataEmail)
                SimplePaymentForm(viewModel: viewModel)
            }
            ZStack {
                Rectangle()
                    .fill(.white)
                    .opacity(0.5)
                Text("Example over, succesful transaction!").font(.headline).foregroundColor(.PaylikeGreen)
            }.opacity(closures.showSuccessMessage ? 1.0 : 0.0)
        }
    }
}


struct ExtendedPaylikeExample_Previews: PreviewProvider {
    static var previews: some View {
        ExtendedPaylikeExample(engine: getEngine())
            .environmentObject(PaylikeTheme)
    }
}
