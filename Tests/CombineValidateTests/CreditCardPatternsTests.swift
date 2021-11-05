import XCTest
@testable import CombineValidate

class CreditCardPatternTests: XCTestCase {
    func testAmericanExpressPattern() {
        let americanExpressCard = cleanCardNumber("3700 0000 0000 002")
        
        XCTAssertNotNil(
            americanExpressCard.range(of: CreditCardPattern.Amex.pattern, options: .regularExpression),
            "AmericanExpress: \(americanExpressCard). Positive case failed"
        )
        
        let unExistedNumber = cleanCardNumber("0000 0000 0000 000")
        
        XCTAssertNil(
            unExistedNumber.range(of: CreditCardPattern.Amex.pattern, options: .regularExpression),
            "AmericanExpress: \(unExistedNumber). Negative case failed"
        )
    }
    
    func testMastercardPattern() {
        let mastercardIIRRange = 50...55
        
        for IIR in mastercardIIRRange {
            let cardNumber =  cleanCardNumber("\(IIR)00 0000 0000 4321")
            XCTAssertNotNil(
                cardNumber.range(of: CreditCardPattern.Mastercard.pattern, options: .regularExpression),
                "Mastercard: \(cardNumber). Positive case failed"
            )
        }
        
        let unExistedNumber = cleanCardNumber("5600 0000 0000 0000")
        
        XCTAssertNil(
            unExistedNumber.range(of: CreditCardPattern.Mastercard.pattern, options: .regularExpression),
            "Mastercard: \(unExistedNumber). Negative case failed"
        )
    }
    
    func testVisaPattern() {
        let visaCardNumber = cleanCardNumber("4377 0000 0000 0000")
        
        XCTAssertNotNil(
            visaCardNumber.range(of: CreditCardPattern.Visa.pattern, options: .regularExpression),
            "Mastercard: \(visaCardNumber). Positive case failed"
        )
        
        let unExistedNumber = cleanCardNumber("0000 0000 0000 0000")
        
        XCTAssertNil(
            unExistedNumber.range(of: CreditCardPattern.Visa.pattern, options: .regularExpression),
            "Mastercard: \(unExistedNumber). Negative case failed"
        )
    }
    
    func testMaestroPattern() {
        let maestroIIRRange = ["0604", "5018", "5020", "5038", "5612", "5761", "5893", "6304", "6390", "6759", "6761", "6762", "6763"]
        
        for IIR in maestroIIRRange {
            let cardNumber =  cleanCardNumber("\(IIR) 0000 0000 4321")
            XCTAssertNotNil(
                cardNumber.range(of: CreditCardPattern.Maestro.pattern, options: .regularExpression),
                "Maestro: \(cardNumber). Positive case failed"
            )
        }
        
        let unExistedNumber = cleanCardNumber("0000 0000 0000 0000")
        
        XCTAssertNil(
            unExistedNumber.range(of: CreditCardPattern.Maestro.pattern, options: .regularExpression),
            "Mastercard: \(unExistedNumber). Negative case failed"
        )
    }
    
    func testDiscoverPattern() {
        let discoverUS = cleanCardNumber("6011 0000 0000 0000")
        let discoverGB = cleanCardNumber("6445 0000 0000 0000")
        
        XCTAssertNotNil(
            discoverUS.range(of: CreditCardPattern.Discover.pattern, options: .regularExpression),
            "Discover US: \(discoverUS). Positive case failed"
        )
        
        XCTAssertNotNil(
            discoverGB.range(of: CreditCardPattern.Discover.pattern, options: .regularExpression),
            "Discover GB: \(discoverGB). Positive case failed"
        )
        
        let unExistedNumber = cleanCardNumber("0000 0000 0000 0000")
        
        XCTAssertNil(
            unExistedNumber.range(of: CreditCardPattern.Discover.pattern, options: .regularExpression),
            "Discover: \(unExistedNumber). Negative case failed"
        )
    }
    
    func testJSBPattern() {
        let jsbUsCard = cleanCardNumber("3569 9900 1009 5841")
        let jsbNativeIRRs = ["2131", "1800"]
        
        XCTAssertNotNil(
            jsbUsCard.range(of: CreditCardPattern.JSB.pattern, options: .regularExpression),
            "JSB GB: \(jsbUsCard). Positive case failed"
        )
        
        for IIR in jsbNativeIRRs {
            let cardNumber =  cleanCardNumber("\(IIR) 0000 0000 000")
            XCTAssertNotNil(
                cardNumber.range(of: CreditCardPattern.JSB.pattern, options: .regularExpression),
                "JSB GB: \(cardNumber). Positive case failed"
            )
        }
        
        let unExistedNumber = cleanCardNumber("0000 0000 0000 0000")
        
        XCTAssertNil(
            unExistedNumber.range(of: CreditCardPattern.JSB.pattern, options: .regularExpression),
            "JSB: \(unExistedNumber). Negative case failed"
        )
    }
    
    func testUnionPayPattern() {
        let unionPay = cleanCardNumber("6200 0000 0000 0000")
        let unionPayAlt1 = cleanCardNumber("8171 0000 0000 0000")
        let unionPayAlt2 = cleanCardNumber("8171 0000 0000 0000 000")
        
        XCTAssertNotNil(
            unionPay.range(of: CreditCardPattern.UnionPay.pattern, options: .regularExpression),
            "UnionPay: \(unionPay). Positive case failed"
        )
        
        XCTAssertNotNil(
            unionPayAlt1.range(of: CreditCardPattern.UnionPay.pattern, options: .regularExpression),
            "UnionPay: \(unionPayAlt1). Positive case failed"
        )
        
        XCTAssertNotNil(
            unionPayAlt2.range(of: CreditCardPattern.UnionPay.pattern, options: .regularExpression),
            "UnionPay: \(unionPayAlt2). Positive case failed"
        )
        
        let unExistedNumber = cleanCardNumber("0000 0000 0000 0000")
        
        XCTAssertNil(
            unExistedNumber.range(of: CreditCardPattern.UnionPay.pattern, options: .regularExpression),
            "UnionPay: \(unExistedNumber). Negative case failed"
        )
    }
    
    func testMirPattern() {
        let mirIRRs = 2200...2204
        
        for IIR in mirIRRs {
            let cardNumber =  cleanCardNumber("\(IIR) 0000 0000 0000")
            XCTAssertNotNil(
                cardNumber.range(of: CreditCardPattern.Mir.pattern, options: .regularExpression),
                "Mir: \(cardNumber). Positive case failed"
            )
        }
        
        let unExistedNumber = cleanCardNumber("0000 0000 0000 0000")
        
        XCTAssertNil(
            unExistedNumber.range(of: CreditCardPattern.Mir.pattern, options: .regularExpression),
            "Mir: \(unExistedNumber). Negative case failed"
        )
    }
}

fileprivate func cleanCardNumber(_ cardNumber: String) -> String {
    cardNumber.replacingOccurrences(of: " ", with: "")
}
