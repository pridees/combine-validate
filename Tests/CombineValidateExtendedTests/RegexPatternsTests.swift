import XCTest
@testable import CombineValidateExtended

final class RegexPatternsTests: XCTestCase {
    func testUrlPattern() {
        let url = "https://google.com"
        XCTAssertTrue(URLPatterns.url.test(url), "Simple URL. Positive case failed")
        
        let nonUrl = "Some string"
        XCTAssertFalse(URLPatterns.url.test(nonUrl), "Simple URL. Negative case failed")
    }
    
    func testYoutubeUrlPattern() {
        let youtubeURL = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    }
}
