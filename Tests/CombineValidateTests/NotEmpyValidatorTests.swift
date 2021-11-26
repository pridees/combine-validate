import XCTest
import Combine
@testable import CombineValidate

final class NotEmptyValidatorTests: XCTestCase {
    class ViewModel: ObservableObject {
        @Published public var name = ""
        
        @Published public var validationResult: Validated<Void> = .untouched
        
        public var subscription: AnyCancellable? = nil
        
        public lazy var nameNotEmptyValidator: ValidationPublisher = {
            $name.validateNonEmpty(error: "Should not empty")
        }()
    }
    
    override func setUp() {
        super.setUp()
        cancellables = .init()
    }
    
    let viewModel = ViewModel()
    
    var cancellables: Set<AnyCancellable>!
    
    func testIgnoreFirstValue() {
        viewModel.nameNotEmptyValidator
            .sink(receiveValue: { _ in })
            .store(in: &cancellables)
        
        XCTAssertEqual(viewModel.validationResult, .untouched)
    }
    
    func testInputEmptyValue() {
        let expectation = XCTestExpectation(description: "Empty input expectation")
        
        viewModel.nameNotEmptyValidator
            .sink(receiveValue: { [weak self] value in
                self?.viewModel.validationResult = value
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        
        viewModel.name = ""
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.validationResult, .failure(reason: "Should not empty", tableName: nil))
    }
    
    func testInputNonEmptyValue() {
        let expectation = XCTestExpectation(description: "User input expectation")
        
        viewModel.nameNotEmptyValidator
            .sink(receiveValue: { [weak self] value in
                self?.viewModel.validationResult = value
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.name = "alex"
        
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(viewModel.validationResult, .success(.none))
    }
}
