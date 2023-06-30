import PaylikeClient
@testable import PaylikeSDK
import XCTest

final class ValidatorTests: XCTestCase {
    
    func test_CardNumberValidator() throws {
        let validMaestroNumbers = [
            "6759649826438453",
//            "6799990100000000019" // TODO: Extend card number check to accept between 16-19
        ]
        let validMastercardNumbers = [
            "5555555555554444",
            "5454545454545454"
        ]
        let validVisaNumbers = [
            "4444333322221111",
            "4917610000000000"
        ]
        let invalidCardNumbers = [
            "76009244561",
            "4571736004738485",
            "45717360047384855432"
        ]
        
        validMaestroNumbers.forEach { number in
            XCTAssertTrue(validateCardNumber(cardNumber: number))
        }
        validMastercardNumbers.forEach { number in
            XCTAssertTrue(validateCardNumber(cardNumber: number))
        }
        validVisaNumbers.forEach { number in
            XCTAssertTrue(validateCardNumber(cardNumber: number))
        }
        invalidCardNumbers.forEach { number in
            XCTAssertFalse(validateCardNumber(cardNumber: number))
        }
    }
    
    func test_CardVerificationCodeValidator() throws {
        let validCVCs = [
            "000",
            "111",
            "123",
            "999"
        ]
        let invalidCVCs = [
            "0",
            "11",
            "1234"
        ]
        
        validCVCs.forEach { number in
            XCTAssertTrue(validateCardVerificationCode(cvc: number))
        }
        invalidCVCs.forEach { number in
            XCTAssertFalse(validateCardVerificationCode(cvc: number))
        }
    }
    
    func test_ExpiryDateValidator() throws {
        let validDates: [CardExpiry?] = [
            try? CardExpiry(month: 12, year: 34),
            try? CardExpiry(month: 1, year: 34),
            try? CardExpiry(month: 5, year: 99)
        ]
        let invalidDates: [CardExpiry?] = [
            try? CardExpiry(month: 0, year: 34),
            try? CardExpiry(month: 13, year: 34),
            try? CardExpiry(month: 12, year: 04),
            try? CardExpiry(month: 1, year: 10),
            try? CardExpiry(month: 12, year: 100),
        ]
        
        validDates.forEach { date in
            XCTAssertTrue(validateExpiryDate(cardExpiry: date))
        }
        
        invalidDates.forEach { date in
            XCTAssertFalse(validateExpiryDate(cardExpiry: date))
        }
        XCTAssertFalse(validateExpiryDate(cardExpiry: nil))
    }
}
