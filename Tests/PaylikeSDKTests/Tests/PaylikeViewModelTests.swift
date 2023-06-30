import AnyCodable
import Combine
import PaylikeClient
import PaylikeEngine
@testable import PaylikeSDK
import XCTest

fileprivate let testKey = "test_key"
fileprivate let emptyString = ""
fileprivate let paymentAmount = PaymentAmount(currency: .EUR, value: 1, exponent: 0)
fileprivate let paymentPlans = [PaymentPlan(amount: paymentAmount), PaymentPlan(amount: paymentAmount)]
fileprivate let paymentUnplanned = PaymentUnplanned(costumer: true)
fileprivate let paymentTest = PaymentTest(card: TestCard(code: CardCodeOptions.INVALID))
fileprivate let paymentText = "hello tests"
fileprivate let paymentCustom = [0, 1, 2] as AnyEncodable

final class PaylikeViewModelTests: XCTestCase {
    
    func test_PaylikeViewModel_initialization() throws {
        
        let engine = MockEngine()
        
        let viewModel = SimplePaymentFormViewModel(engine: engine)
        var cancellables: Set<AnyCancellable> = []
        
        let initExpectation = expectation(description: "Data should be added")
        
        cancellables.insert(viewModel.$_engineState.sink(receiveValue: { state in
            if state == nil {
                return
            }
            XCTAssertNotNil(viewModel)
            XCTAssertNotNil(viewModel.engine)
            
            XCTAssertEqual(emptyString, viewModel.cardNumber)
            XCTAssertEqual(emptyString, viewModel.expiryDate)
            XCTAssertEqual(emptyString, viewModel.cvc)
            
            XCTAssertNil(viewModel.amount)
            XCTAssertNil(viewModel.paymentTestData)
            XCTAssertNil(viewModel.paymentPlanDataList)
            XCTAssertNil(viewModel.paymentUnplannedData)
            XCTAssertNil(viewModel.paymentTextData)
            XCTAssertNil(viewModel.paymentCustomData)
            
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertFalse(viewModel._shouldRenderWebView)
            XCTAssertTrue(viewModel.payButtonDisabled)
            XCTAssertEqual(emptyString, viewModel.payButtonDisplayAmount)
            XCTAssertFalse(viewModel.isCardNumberValid)
            XCTAssertFalse(viewModel.isExpiryDateValid)
            XCTAssertFalse(viewModel.isCardVerifiacationCodeValid)
            
            XCTAssertNil(viewModel.cardExpiry)
            
            XCTAssertEqual(EngineState.WAITING_FOR_INPUT, state)
            XCTAssertNil(viewModel._engineError)
            XCTAssertNil(viewModel._errorMessage)
            initExpectation.fulfill()
            
        }))
        wait(for: [initExpectation], timeout: 10)
    }
    
    func test_PaylikeViewModel_addingInterface() throws {
        let engine = MockEngine()
        
        let viewModel = SimplePaymentFormViewModel(engine: engine)
        
        viewModel.addPaymentAmount(paymentAmount)
        
        XCTAssertNotNil(viewModel.amount)
        XCTAssertEqual(paymentAmount, viewModel.amount)
        
        viewModel.addPaymentPlanDataList(paymentPlans)
        
        XCTAssertNotNil(viewModel.paymentPlanDataList)
        XCTAssertEqual(paymentPlans.count, viewModel.paymentPlanDataList?.count)
        XCTAssertEqual(paymentPlans[0].amount, viewModel.paymentPlanDataList?[0].amount)
        
        
        viewModel.addPaymentUnplannedData(paymentUnplanned)
        
        XCTAssertNotNil(viewModel.paymentUnplannedData)
        XCTAssertEqual(paymentUnplanned.constumer, viewModel.paymentUnplannedData?.constumer)
        
        viewModel.addPaymentTestData(paymentTest)
        
        XCTAssertNotNil(viewModel.paymentTestData)
        
        // delete
        viewModel.addDescriptionPaymentData(paymentAmount: nil, paymentPlanDataList: nil, paymentUnplannedData: nil, paymentTestData: nil)
        
        XCTAssertNil(viewModel.amount)
        XCTAssertNil(viewModel.paymentPlanDataList)
        XCTAssertNil(viewModel.paymentUnplannedData)
        XCTAssertNil(viewModel.paymentTestData)
        
        // add again
        viewModel.addDescriptionPaymentData(paymentAmount: paymentAmount, paymentPlanDataList: paymentPlans, paymentUnplannedData: paymentUnplanned, paymentTestData: paymentTest)
        
        XCTAssertNotNil(viewModel.amount)
        XCTAssertEqual(paymentAmount, viewModel.amount)
        XCTAssertNotNil(viewModel.paymentPlanDataList)
        XCTAssertEqual(paymentPlans.count, viewModel.paymentPlanDataList?.count)
        XCTAssertEqual(paymentPlans[0].amount, viewModel.paymentPlanDataList?[0].amount)
        XCTAssertNotNil(viewModel.paymentUnplannedData)
        XCTAssertEqual(paymentUnplanned.constumer, viewModel.paymentUnplannedData?.constumer)
        XCTAssertNotNil(viewModel.paymentTestData)
        
        viewModel.addAdditionalPaymentData(textData: paymentText, customData: paymentCustom)
        
        XCTAssertNotNil(viewModel.paymentTextData)
        XCTAssertEqual(paymentText, viewModel.paymentTextData)
        XCTAssertNotNil(viewModel.paymentCustomData)
    }
    
    func test_PaylikeViewModel_reset() throws {
        let engine = MockEngine()
        
        let viewModel = SimplePaymentFormViewModel(engine: engine)
        
        viewModel.addDescriptionPaymentData(paymentAmount: paymentAmount, paymentPlanDataList: paymentPlans, paymentUnplannedData: paymentUnplanned, paymentTestData: paymentTest)
        viewModel.addAdditionalPaymentData(textData: paymentText, customData: paymentCustom)
        
        XCTAssertNotNil(viewModel.amount)
        XCTAssertEqual(paymentAmount, viewModel.amount)
        XCTAssertNotNil(viewModel.paymentPlanDataList)
        XCTAssertEqual(paymentPlans.count, viewModel.paymentPlanDataList?.count)
        XCTAssertEqual(paymentPlans[0].amount, viewModel.paymentPlanDataList?[0].amount)
        XCTAssertNotNil(viewModel.paymentUnplannedData)
        XCTAssertEqual(paymentUnplanned.constumer, viewModel.paymentUnplannedData?.constumer)
        XCTAssertNotNil(viewModel.paymentTestData)
        XCTAssertNotNil(viewModel.paymentTextData)
        XCTAssertEqual(paymentText, viewModel.paymentTextData)
        XCTAssertNotNil(viewModel.paymentCustomData)
        
        viewModel.resetViewModelAndEngine()
        
        // TODO: FormViewModel needs to reset its internal variables to test it
        // TODO: some tests
    }
    
    func test_PaylikeViewModel_callbacks() throws {
        let engine = MockEngine()
        
        let validCardNumber = "4012111111111111"
        let validExpiryDateMonth = "12"
        let validExpiryDateYear = "34"
        let validCVC = "111"
        
        let beforePaymentExpectation = expectation(description: "Callback `beforePaymentExpectation` should be called")
        let onSuccessExpectation = expectation(description: "Callback `onSuccessExpectation` should be called")
        let onErrorExpectation = expectation(description: "Callback `onErrorExpectation` should be called")
        
        let beforePayment: BeforePayment = { engine, cardNumber, cvc, expiry, textData, customData in
            beforePaymentExpectation.fulfill()
        }
        let onSuccess: OnSuccessHandler = {
            onSuccessExpectation.fulfill()
        }
        let onError: OnErrorHandler = { error in
            onErrorExpectation.fulfill()
        }
        
        let viewModel = SimplePaymentFormViewModel(engine: engine, onSuccess: onSuccess, onError: onError, beforePayment: beforePayment)
        viewModel.cardNumber = validCardNumber
        viewModel.expiryDate = validExpiryDateMonth + validExpiryDateYear
        viewModel.cvc = validCVC
        
        Task {
            await viewModel.submit()
            
            XCTAssertEqual(validCardNumber, engine.repository.paymentRepository?.card?.number.token)
            XCTAssertEqual(validExpiryDateMonth, String((engine.repository.paymentRepository?.card?.expiry.month)!))
            XCTAssertEqual("20" + validExpiryDateYear, String((engine.repository.paymentRepository?.card?.expiry.year)!))
            XCTAssertEqual(validCVC, engine.repository.paymentRepository?.card?.code.token)
            
            engine.internalState = .SUCCESS
            engine.prepareError(EngineError.NotImplemented)
        }
        wait(for: [beforePaymentExpectation, onSuccessExpectation, onErrorExpectation], timeout: 10)
    }
    
    func test_PaylikeViewModel_isFormValid() throws {
        let validCardNumber = "4012111111111111"
        let validExpiryDate = "1234"
        let validCardExpiry = try? CardExpiry(month: 12, year: 34)
        XCTAssertNotNil(validCardExpiry)
        let validCVC = "111"
        
        let engine = MockEngine()
        
        let viewModel = SimplePaymentFormViewModel(engine: engine)
        
        viewModel.cardNumber = validCardNumber
        viewModel.expiryDate = validExpiryDate
        viewModel.cvc = validCVC
        
        XCTAssertNotNil(viewModel.cardExpiry)
        
        XCTAssertTrue(viewModel.isFormValid())
    }
    
    func test_PaylikeViewModel_isFormInvalid() throws {
        let invalidCardNumber = "4012111111111112"
        let invalidExpiryDate = "1334"
        let validCardExpiry = try? CardExpiry(month: 13, year: 34)
        XCTAssertNil(validCardExpiry)
        let invalidCVC = "11"
        
        let engine = MockEngine()
        
        let viewModel = SimplePaymentFormViewModel(engine: engine)
        
        viewModel.cardNumber = invalidCardNumber
        viewModel.expiryDate = invalidExpiryDate
        viewModel.cvc = invalidCVC
        
        XCTAssertNil(viewModel.cardExpiry)
        
        XCTAssertFalse(viewModel.isFormValid())
    }
}
