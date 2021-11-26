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
    }
    
    let viewModel = ViewModel()
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = .init()
    }
    
    func testIgnoreFirstValue() {
        
        viewModel.specialTextValidator
            .sink(receiveValue: { _ in })
            .store(in: &cancellables)
        
        XCTAssertEqual(viewModel.validationResult, .untouched)
    }
    
    func testFullyInvalidValue() {
        let expectation = XCTestExpectation(description: "Empty input expectation")
        
        viewModel.specialTextValidator
            .sink(receiveValue: { [weak self] result in
                self?.viewModel.validationResult = result
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.specialText = ""
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(
            viewModel.validationResult,
            .failure(reason: "Should be one number at least", tableName: nil)
        )
    }
    
    func testValueWithOneNumber() {
        let expectation = XCTestExpectation(description: "1 input expectation")
        
        viewModel.specialTextValidator
            .sink(receiveValue: { [weak self] result in
                self?.viewModel.validationResult = result
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.specialText = "1"
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.validationResult, .failure(reason: "Should be one special symbol at least", tableName: nil))
    }
    
    func testValueWithOneNumberAndSpecialSymbol() {
        let expectation = XCTestExpectation(description: "1% input expectation")
        
        viewModel.specialTextValidator
            .sink(receiveValue: { [weak self] result in
                self?.viewModel.validationResult = result
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.specialText = "1%"
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(
            viewModel.validationResult,
            .failure(reason: "Should be one capital letter at least", tableName: nil)
        )
    }
    
    func testValueWithOneNumberAndSpecialSymbolAndCapitalLetter() {
        let expectation = XCTestExpectation(description: "1%A input expectation")
        
        viewModel.specialTextValidator
            .sink(receiveValue: { [weak self] result in
                self?.viewModel.validationResult = result
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.specialText = "1%A"
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.validationResult, .success(.none))
    }
    
}
