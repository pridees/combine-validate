import Combine
@testable import CombineValidate
import XCTest

final class OneOfRegexValidatorTests: XCTestCase {
    enum SocialLinkPattern: RegexPattern, RegexProtocol {
        case facebook = #"(?:https?:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*?(\/)?([\w\-\.]{5,})"#
        case linkedIn = #"^(http(s)?:\/\/)?([\w]+\.)?linkedin\.com\/(pub|in|profile)"#
        case instagram = #"(?:(?:http|https):\/\/)?(?:www.)?(?:instagram.com|instagr.am|instagr.com)\/(\w+)"#
    }

    class ViewModel: ObservableObject {
        
        @Published var socialProfileUrl = ""
        @Published var validationResult: Validated<SocialLinkPattern> = .untouched
        
        public lazy var socialProfileValidator: RichValidationPublisher<SocialLinkPattern> = {
            $socialProfileUrl.validateOneOfRegex(
                regexs: [.facebook, .linkedIn, .instagram],
                error: "Type one of social profile link (insta, facebook, linkedIn)",
                tableName: nil
            )
        }()
        
        private var subscription = Set<AnyCancellable>()
        
        init() {
            socialProfileValidator
                .assign(to: \.validationResult, on: self)
                .store(in: &subscription)
        }
    }
    
    let viewModel = ViewModel()
    
    func testIgnoreFirstValue() {
        XCTAssertEqual(viewModel.validationResult, .untouched)
    }
    
    func testExpectedInstagramInput() {
        viewModel.socialProfileUrl = "instagram.com/userprofile"
        
        XCTAssertEqual(viewModel.validationResult, .success(.instagram))
    }
    
    func testExpectedFacebookInput() {
        viewModel.socialProfileUrl = "facebook.com/userprofile"
        XCTAssertEqual(viewModel.validationResult, .success(.facebook))
    }
    
    func testExpectedLinkedInInput() {
        viewModel.socialProfileUrl = "linkedin.com/in/userprofile"
        XCTAssertEqual(viewModel.validationResult, .success(.linkedIn))
    }
    
    func testUnexpectedValue() {
        viewModel.socialProfileUrl = "http://youtube.com/userprofile"
        XCTAssertEqual(viewModel.validationResult, .failure(reason: "Type one of social profile link (insta, facebook, linkedIn)", tableName: nil))
    }
    
    func testEmptyValue() {
        viewModel.socialProfileUrl = ""
        XCTAssertEqual(viewModel.validationResult, .failure(reason: "Type one of social profile link (insta, facebook, linkedIn)", tableName: nil))
    }
}
