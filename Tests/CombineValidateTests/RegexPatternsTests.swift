import XCTest
@testable import CombineValidate

final class RegexPatternsTests: XCTestCase {
    func testUrlPattern() throws {
        let url = "https://google.com"
        let nonUrl = "Some string"
        
        XCTAssertNotNil(url.range(of: RegexPattern.url, options: .regularExpression), "Simple URL. Positive case failed")
        XCTAssertNil(nonUrl.range(of: RegexPattern.url, options: .regularExpression), "Simple URL. Negative case failed")
    }
    
    func testEmailPattern() {
        let email = "somemail@gmail.com"
        let nonEmail = "Some string"
        
        XCTAssertNotNil(email.range(of: RegexPattern.email, options: .regularExpression), "Regular email. Positive case failed")
        XCTAssertNil(nonEmail.range(of: RegexPattern.email, options: .regularExpression), "Regular email. Negative case failed")
    }
    
    func testStrongPattern() {
        let strongPassword = "dk%1P2Nd"
        let generatedStrongPassword = "t@yd!GANpuJ_dKw2L7AYXQoP"
        let weakPassword = "weakPassord"
        
        XCTAssertNotNil(
            strongPassword.range(of: RegexPattern.strongPassword, options: .regularExpression),
            "Strong password. Positive case failed"
        )
        
        XCTAssertNotNil(
            generatedStrongPassword.range(of: RegexPattern.strongPassword, options: .regularExpression),
            "Strong password. Positive case failed"
        )
        
        XCTAssertNil(
            weakPassword.range(of: RegexPattern.strongPassword, options: .regularExpression),
            "Strong password. Negative case. Failed"
        )
    }
}
