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
    }
    
    let viewModel = ViewModel()
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = .init()
    }
    
    func testIgnoreFirstValue() {
        viewModel.emailValidator
            .sink(receiveValue: { _ in })
            .store(in: &cancellables)
        
        XCTAssertEqual(viewModel.validationResult, .untouched)
    }
    
    func testValidEmailValue() {
        let expectation = XCTestExpectation(description: "Valid email input expectation")
        
        viewModel.emailValidator
            .sink(receiveValue: { [weak self] result in
                self?.viewModel.validationResult = result
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.email = "someemail@gmail.com"
        
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(viewModel.validationResult, .success(.none))
    }
    
    func testInvalidEmailValue() {
        let expectation = XCTestExpectation(description: "Invalid email input expectation")
        
        viewModel.emailValidator
            .sink(receiveValue: { [weak self] result in
                self?.viewModel.validationResult = result
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.email = "someemailgmail.com"

        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.validationResult, .failure(reason: "Should be email", tableName: nil))
    }
}
