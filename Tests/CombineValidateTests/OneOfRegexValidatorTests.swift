import XCTest
import Combine
@testable import CombineValidate

final class OneOfRegexValidatorTests: XCTestCase {
    enum SocialLinkPattern: RegexPattern, RegexProtocol {
        case facebook = #"(?:https?:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*?(\/)?([\w\-\.]{5,})"#
        case linkedIn = #"^(http(s)?:\/\/)?([\w]+\.)?linkedin\.com\/(pub|in|profile)"#
        case instagram = #"(?:(?:http|https):\/\/)?(?:www.)?(?:instagram.com|instagr.am|instagr.com)\/(\w+)"#
    }

    class ViewModel: ObservableObject {
        
        @Published var socialProfileUrl = ""
        @Published var validationResult: Validated<SocialLinkPattern> = .untouched
        
        public lazy var socialProfileValidator: ValidationPublisherOf<SocialLinkPattern> = {
            $socialProfileUrl.validateOneOfRegex(
                regexs: [.facebook, .linkedIn, .instagram],
                error: "Type one of social profile link (insta, facebook, linkedIn)"
            )
        }()
    }
    
    let viewModel = ViewModel()
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = .init()
    }
    
    func testIgnoreFirstValue() {
        viewModel.socialProfileValidator
            .sink(receiveValue: { _ in })
            .store(in: &cancellables)
        
        XCTAssertEqual(viewModel.validationResult, .untouched)
    }
    
    func testExpectedInstagramInput() {
        let expectation = XCTestExpectation(description: "Instagram input expectation")
        
        viewModel.socialProfileValidator
            .sink(receiveValue: { [weak self] result in
                self?.viewModel.validationResult = result
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.socialProfileUrl = "instagram.com/userprofile"
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.validationResult, .success(.instagram))
    }
    
    func testExpectedFacebookInput() {
        let expectation = XCTestExpectation(description: "Facebook input expectation")
        
        viewModel.socialProfileValidator
            .sink(receiveValue: { [weak self] result in
                self?.viewModel.validationResult = result
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.socialProfileUrl = "facebook.com/userprofile"

        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.validationResult, .success(.facebook))
    }
    
    func testExpectedLinkedInInput() {
        let expectation = XCTestExpectation(description: "Linkedin input expectation")
        
        viewModel.socialProfileValidator
            .sink(receiveValue: { [weak self] result in
                self?.viewModel.validationResult = result
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.socialProfileUrl = "linkedin.com/in/userprofile"
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.validationResult, .success(.linkedIn))
    }
    
    func testUnexpectedValue() {
        let expectation = XCTestExpectation(description: "Youtube input expectation")
        
        viewModel.socialProfileValidator
            .sink(receiveValue: { [weak self] result in
                self?.viewModel.validationResult = result
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.socialProfileUrl = "http://youtube.com/userprofile"
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.validationResult, .failure(reason: "Type one of social profile link (insta, facebook, linkedIn)", tableName: nil))
    }
    
    func testEmptyValue() {
        let expectation = XCTestExpectation(description: "Invalid input expectation")
        
        viewModel.socialProfileValidator
            .sink(receiveValue: { [weak self] result in
                self?.viewModel.validationResult = result
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.socialProfileUrl = ""
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.validationResult, .failure(reason: "Type one of social profile link (insta, facebook, linkedIn)", tableName: nil))
    }
}
