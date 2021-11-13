import XCTest
@testable import CombineValidateExtended

class CreditCardPatternTests: XCTestCase {
    func testAmericanExpressPattern() {
        let americanExpressCard = cleanCardNumber("3700 0000 0000 002")
        XCTAssertTrue(
            CreditCardPattern.Amex.test(americanExpressCard),
            "AmericanExpress: \(americanExpressCard). Positive case failed"
        )
        
        let unExistedNumber = cleanCardNumber("0000 0000 0000 000")
        XCTAssertFalse(
            CreditCardPattern.Amex.test(unExistedNumber),
            "AmericanExpress: \(unExistedNumber). Negative case failed"
        )
    }
    
    func testMastercardPattern() {
        let mastercardIIRRange = 50...55
        
        for IIR in mastercardIIRRange {
            let cardNumber =  cleanCardNumber("\(IIR)00 0000 0000 4321")
            XCTAssertTrue(
                CreditCardPattern.Mastercard.test(cardNumber),
                "Mastercard: \(cardNumber). Positive case failed"
            )
        }
        
        let unExistedNumber = cleanCardNumber("5600 0000 0000 0000")
        
        XCTAssertFalse(
            CreditCardPattern.Mastercard.test(unExistedNumber),
            "Mastercard: \(unExistedNumber). Negative case failed"
        )
    }
    
    func testVisaPattern() {
        let visaCardNumber = cleanCardNumber("4377 0000 0000 0000")
        
        XCTAssertTrue(
            CreditCardPattern.Visa.test(visaCardNumber),
            "Mastercard: \(visaCardNumber). Positive case failed"
        )
        
        let unExistedNumber = cleanCardNumber("0000 0000 0000 0000")
        
        XCTAssertFalse(
            CreditCardPattern.Visa.test(unExistedNumber),
            "Mastercard: \(unExistedNumber). Negative case failed"
        )
    }
    
    func testMaestroPattern() {
        let maestroIIRRange = ["0604", "5018", "5020", "5038", "5612", "5761", "5893", "6304", "6390", "6759", "6761", "6762", "6763"]
        
        for IIR in maestroIIRRange {
            let cardNumber =  cleanCardNumber("\(IIR) 0000 0000 4321")
            XCTAssertTrue(
                CreditCardPattern.Maestro.test(cardNumber),
                "Maestro: \(cardNumber). Positive case failed"
            )
        }
        
        let unExistedNumber = cleanCardNumber("0000 0000 0000 0000")
        
        XCTAssertFalse(
            CreditCardPattern.Maestro.test(unExistedNumber),
            "Mastercard: \(unExistedNumber). Negative case failed"
        )
    }
    
    func testDiscoverPattern() {
        let discoverUS = cleanCardNumber("6011 0000 0000 0000")
        XCTAssertTrue(
            CreditCardPattern.Discover.test(discoverUS),
            "Discover US: \(discoverUS). Positive case failed"
        )
        
        let discoverGB = cleanCardNumber("6445 0000 0000 0000")
        XCTAssertTrue(
            CreditCardPattern.Discover.test(discoverGB),
            "Discover GB: \(discoverGB). Positive case failed"
        )
        
        let unExistedNumber = cleanCardNumber("0000 0000 0000 0000")
        XCTAssertFalse(
            CreditCardPattern.Discover.test(unExistedNumber),
            "Discover: \(unExistedNumber). Negative case failed"
        )
    }
    
    func testJSBPattern() {
        let jsbUsCard = cleanCardNumber("3569 9900 1009 5841")
        let jsbNativeIRRs = ["2131", "1800"]
        
        XCTAssertTrue(
            CreditCardPattern.JSB.test(jsbUsCard),
            "JSB GB: \(jsbUsCard). Positive case failed"
        )
        
        for IIR in jsbNativeIRRs {
            let cardNumber =  cleanCardNumber("\(IIR) 0000 0000 000")
            XCTAssertTrue(
                CreditCardPattern.JSB.test(cardNumber),
                "JSB GB: \(cardNumber). Positive case failed"
            )
        }
        
        let unExistedNumber = cleanCardNumber("0000 0000 0000 0000")
        XCTAssertFalse(
            CreditCardPattern.JSB.test(unExistedNumber),
            "JSB: \(unExistedNumber). Negative case failed"
        )
    }
    
    func testUnionPayPattern() {
        let unionPay = cleanCardNumber("6200 0000 0000 0000")
        
        XCTAssertTrue(
            CreditCardPattern.UnionPay.test(unionPay),
            "UnionPay: \(unionPay). Positive case failed"
        )
        
        let unionPayAlt1 = cleanCardNumber("8171 0000 0000 0000")
        XCTAssertTrue(
            CreditCardPattern.UnionPay.test(unionPayAlt1),
            "UnionPay: \(unionPayAlt1). Positive case failed"
        )
        
        let unionPayAlt2 = cleanCardNumber("8171 0000 0000 0000 000")
        XCTAssertTrue(
            CreditCardPattern.UnionPay.test(unionPayAlt2),
            "UnionPay: \(unionPayAlt2). Positive case failed"
        )
        
        let unExistedNumber = cleanCardNumber("0000 0000 0000 0000")
        XCTAssertFalse(
            CreditCardPattern.UnionPay.test(unExistedNumber),
            "UnionPay: \(unExistedNumber). Negative case failed"
        )
    }
    
    func testMirPattern() {
        let mirIRRs = 2200...2204
        
        for IIR in mirIRRs {
            let cardNumber =  cleanCardNumber("\(IIR) 0000 0000 0000")
            XCTAssertTrue(
                CreditCardPattern.Mir.test(cardNumber),
                "Mir: \(cardNumber). Positive case failed"
            )
        }
        
        let unExistedNumber = cleanCardNumber("0000 0000 0000 0000")
        
        XCTAssertFalse(
            CreditCardPattern.Mir.test(unExistedNumber),
            "Mir: \(unExistedNumber). Negative case failed"
        )
    }
}

fileprivate func cleanCardNumber(_ cardNumber: String) -> String {
    cardNumber.replacingOccurrences(of: " ", with: "")
}
