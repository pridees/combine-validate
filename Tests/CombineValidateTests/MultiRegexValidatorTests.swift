import XCTest
import Combine
@testable import CombineValidate

class MultiRegexValidatorTests: XCTestCase {
    class ViewModel: ObservableObject {
        
        @Published var email = ""
        @Published var validationResult: Validated<Void> = .untouched
        
        public lazy var emailValidator: ValidationPublisher = {
            $email.validateWithMultiRegex(
                regexs: [RegularPattern.mustIncludeNumbers, RegularPattern.mustIncludeSpecialSymbols, RegularPattern.mustIncludeCapitalLetters],
                errors: ["Should be one number at least", "Should be one special symbol at least", "Should be one capital letter at least"],
                tableName: nil
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
    
    func testFullyInvalidValue() {
        viewModel.email = ""
        
        XCTAssertEqual(
            viewModel.validationResult,
            .failure(reason: "Should be one number at least", tableName: nil)
        )
    }
    
    func testValueWithOneNumber() {
        viewModel.email = "1"
        
        XCTAssertEqual(viewModel.validationResult, .failure(reason: "Should be one special symbol at least", tableName: nil))
    }
    
    func testValueWithOneNumberAndSpecialSymbol() {
        viewModel.email = "1%"
        
        XCTAssertEqual(
            viewModel.validationResult,
            .failure(reason: "Should be one capital letter at least", tableName: nil)
        )
    }
    
    func testValueWithOneNumberAndSpecialSymbolAndCapitalLetter() {
        viewModel.email = "1%A"
        
        XCTAssertEqual(viewModel.validationResult, .success(.none))
    }
    
}
