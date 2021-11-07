import XCTest
@testable import CombineValidateExtended

final class RegexPatternsTests: XCTestCase {
    func testUrlPattern() throws {
        let url = "https://google.com"
        let nonUrl = "Some string"
        
        XCTAssertNotNil(url.range(of: URLPatterns.url.pattern, options: .regularExpression), "Simple URL. Positive case failed")
        XCTAssertNil(nonUrl.range(of: URLPatterns.url.pattern, options: .regularExpression), "Simple URL. Negative case failed")
    }
}
