import AnyCodable
import Foundation
import PaylikeClient
@testable import PaylikeEngine
import WebKit

class MockEngine: Engine {

    var client: Client = MockClient()

    var webViewModel: (any WebViewModel)? = MockWebViewModel()

    @Published var internalState = EngineState.WAITING_FOR_INPUT
    public var state: Published<EngineState> {
        get {
            return _internalState
        }
        set {
            _internalState = newValue
        }
    }
    @Published var internalError: EngineErrorObject? = nil
    public var error: Published<EngineErrorObject?> {
        get {
            return _internalError
        }
        set {
            _internalError = newValue
        }
    }
    var repository: EngineReposity = EngineReposity()

    init() {
        repository.paymentRepository = CreatePaymentRequest(merchantID: PaymentIntegration(merchantId: "Mocked"))
    }

    func addEssentialPaymentData(applePayToken: String) async {
        repository.paymentRepository?.applepay = ApplePayToken(token: applePayToken)
    }

    func addEssentialPaymentData(cardNumber: String, cvc: String, month: Int, year: Int) async {
        repository.paymentRepository?.card = PaymentCard(number: CardNumberToken(token: cardNumber), code: CardSecurityCodeToken(token: cvc), expiry: try! CardExpiry(month: month, year: year))
    }

    func addDescriptionPaymentData(paymentAmount: PaymentAmount?, paymentPlanDataList: [PaymentPlan]?, paymentUnplannedData: PaymentUnplanned?, paymentTestData: PaymentTest?) {
        repository.paymentRepository?.amount = paymentAmount
        repository.paymentRepository?.plan = paymentPlanDataList
        repository.paymentRepository?.unplanned = paymentUnplannedData
        repository.paymentRepository?.test = paymentTestData
    }

    func addAdditionalPaymentData(textData: String?, customData: AnyEncodable?) {
        repository.paymentRepository?.text = textData
        repository.paymentRepository?.custom = customData
    }

    func resetEngine() {
        repository = EngineReposity()
        repository.paymentRepository = CreatePaymentRequest(merchantID: PaymentIntegration(merchantId: "Mocked"))
        internalError = nil
        internalState = .WAITING_FOR_INPUT
        objectWillChange.send()
    }

    func prepareError(_ error: Error) {
        internalError = EngineErrorObject(message: "Mock error")
        internalState = .ERROR
        objectWillChange.send()
    }

    func startPayment() async {
        internalState = .WEBVIEW_CHALLENGE_STARTED
        objectWillChange.send()
    }

    func continuePayment() async {
        internalState = .WEBVIEW_CHALLENGE_USER_INPUT_REQUIRED
        objectWillChange.send()
    }

    func finishPayment() async {
        internalState = .SUCCESS
        objectWillChange.send()
    }
}

class MockWebViewModel: WebViewModel {
    
    var engine: (any Engine)? = nil
    
    var webView: WKWebView? = nil
    
    var paylikeWebView: PaylikeWebView? = nil
    
    var shouldRenderWebView: Published<Bool> = .init(initialValue: false)
    
    func createWebView() {}
    
    func dropWebView() {}
}
