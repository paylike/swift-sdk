import PaylikeClient
@testable import PaylikeSDK
import XCTest

final class FormatterTests: XCTestCase {
    
    func test_CardNumberFormatter() throws {
        
        let formatter = CardNumberFormatter()
                
        let inputStrings = [
            0: "",
            1: "1",
            2: "1234",
            3: "12345678",
            4: "1234567812345678",
            5: "1234asdf1234"
        ]
        let displayedStrings = [
            0: "",
            1: "1",
            2: "1234",
            3: "1234 5678",
            4: "1234 5678 1234 5678",
            5: "1234 asdf 1234"
        ]
        let valueStrings = [
            0: "",
            1: "1",
            2: "1234",
            3: "12345678",
            4: "1234567812345678",
            5: "12341234"
        ]
                
        inputStrings.forEach { index, input in
            XCTAssertEqual(displayedStrings[index], formatter.displayString(for: input))
            XCTAssertEqual(valueStrings[index], formatter.value(from: input))
        }
    }
    
    func test_CardVerificationCodeFormatter() throws {
        let formatter = CardVerificationCodeFormatter()

        let inputStrings = [
            0: "",
            1: "1",
            2: "123",
            3: "1asdf23",
            4: "1asd",
            5: "1234"
        ]
        let displayedStrings = [
            0: "",
            1: "1",
            2: "123",
            3: "1asdf23",
            4: "1asd",
            5: "1234"
        ]
        let valueStrings = [
            0: "",
            1: "1",
            2: "123",
            3: "123",
            4: "1",
            5: "123"
        ]
        
        inputStrings.forEach { index, input in
            XCTAssertEqual(displayedStrings[index], formatter.displayString(for: input))
            XCTAssertEqual(valueStrings[index], formatter.value(from: input))
        }
    }
    
    func test_ExpiryDateFormatter() throws {
        let formatter = ExpiryDateFormatter()
        
        let inputStrings = [
            0: "",
            1: "1",
            2: "123",
            3: "1asdf23",
            4: "1asd",
            5: "1234"
        ]
        let displayedStrings = [
            0: "",
            1: "1",
            2: "12 / 3",
            3: "1a / sdf23",
            4: "1a / sd",
            5: "12 / 34"
        ]
        let valueStrings = [
            0: "",
            1: "1",
            2: "123",
            3: "123",
            4: "1",
            5: "1234"
        ]
        
        inputStrings.forEach { index, input in
            XCTAssertEqual(displayedStrings[index], formatter.displayString(for: input))
            XCTAssertEqual(valueStrings[index], formatter.value(from: input))
        }
    }

}
