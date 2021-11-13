import XCTest
import Combine
@testable import CombineValidate

class RegexValidatorTests: XCTestCase {
    class ViewModel: ObservableObject {
        
        @Published var email = ""
        @Published var validationResult: Validated<Void> = .untouched
        
        public lazy var emailValidator: ValidationPublisher = {
            $email.validateWithRegex(
                regex: RegularPattern.email,
                error: "Should be email"
            )
        }()
            
        private var subscription = Set<AnyCancellable>()
        
        init() {
            emailValidator
                .assign(to: \.validationResult, on: self)
                .store(in: &subscription)
        }
    }
    
    let viewModel = ViewModel()
    
    func testIgnoreFirstValue() {
        XCTAssertEqual(viewModel.validationResult, .untouched)
    }
    
    func testValidEmailValue() {
        viewModel.email = "someemail@gmail.com"
        
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.5)

        XCTAssertEqual(viewModel.validationResult, .success(.none))
    }
    
    func testInvalidEmailValue() {
        viewModel.email = "someemailgmail.com"

        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.5)
        
        XCTAssertEqual(viewModel.validationResult, .failure(reason: "Should be email", tableName: nil))
    }
}