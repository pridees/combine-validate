import XCTest
@testable import CombineValidate

class InternalRegexTests: XCTestCase {
    func testRegularPatterns() {
        func testEmailPattern() {
            let email = "somemail@gmail.com"
            let nonEmail = "Some string"
            
            XCTAssertNotNil(email.range(of: RegularPattern.email.pattern, options: .regularExpression), "Regular email. Positive case failed")
            XCTAssertNil(nonEmail.range(of: RegularPattern.email.pattern, options: .regularExpression), "Regular email. Negative case failed")
        }
        
        func testStrongPattern() {
            let strongPassword = "dk%1P2Nd"
            let generatedStrongPassword = "t@yd!GANpuJ_dKw2L7AYXQoP"
            let weakPassword = "weakPassord"
            
            XCTAssertNotNil(
                strongPassword.range(of: RegularPattern.strongPassword.pattern, options: .regularExpression),
                "Strong password. Positive case failed"
            )
            
            XCTAssertNotNil(
                generatedStrongPassword.range(of: RegularPattern.strongPassword.pattern, options: .regularExpression),
                "Strong password. Positive case failed"
            )
            
            XCTAssertNil(
                weakPassword.range(of: RegularPattern.strongPassword.pattern, options: .regularExpression),
                "Strong password. Negative case. Failed"
            )
        }
    }
}
