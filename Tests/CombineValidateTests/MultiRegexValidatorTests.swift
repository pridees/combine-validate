import XCTest
import Combine
@testable import CombineValidate

class MultiRegexValidatorTests: XCTestCase {
    class ViewModel: ObservableObject {
        
        @Published var specialText = ""
        @Published var validationResult: Validated<Void> = .untouched
        
        public lazy var specialTextValidator: ValidationPublisher = {
            $specialText.validateWithMultiRegex(
                regexs: [RegularPattern.mustIncludeNumbers, RegularPattern.mustIncludeSpecialSymbols, RegularPattern.mustIncludeCapitalLetters],
                errors: ["Should be one number at least", "Should be one special symbol at least", "Should be one capital letter at least"]
            )
        }()
        
        private var subscription = Set<AnyCancellable>()
        
        init() {
            specialTextValidator
                .assign(to: \.validationResult, on: self)
                .store(in: &subscription)
        }
    }
    
    let viewModel = ViewModel()
    
    func testIgnoreFirstValue() {
        XCTAssertEqual(viewModel.validationResult, .untouched)
    }
    
    func testFullyInvalidValue() {
        viewModel.specialText = ""
        
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.5)
        
        XCTAssertEqual(
            viewModel.validationResult,
            .failure(reason: "Should be one number at least", tableName: nil)
        )
    }
    
    func testValueWithOneNumber() {
        viewModel.specialText = "1"
        
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.5)
        
        XCTAssertEqual(viewModel.validationResult, .failure(reason: "Should be one special symbol at least", tableName: nil))
    }
    
    func testValueWithOneNumberAndSpecialSymbol() {
        viewModel.specialText = "1%"
        
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.5)
        
        XCTAssertEqual(
            viewModel.validationResult,
            .failure(reason: "Should be one capital letter at least", tableName: nil)
        )
    }
    
    func testValueWithOneNumberAndSpecialSymbolAndCapitalLetter() {
        viewModel.specialText = "1%A"
        
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.5)
        
        XCTAssertEqual(viewModel.validationResult, .success(.none))
    }
    
}
