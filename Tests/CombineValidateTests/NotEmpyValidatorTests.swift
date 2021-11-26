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
        
        init() {
            subscription = nameNotEmptyValidator
                .assign(to: \.validationResult, on: self)
        }
    }
    
    let viewModel = ViewModel()
    
    func testIgnoreFirstValue() {
        XCTAssertEqual(viewModel.validationResult, .untouched)
    }
    
    func testInputEmptyValue() {
        viewModel.name = ""
        
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.3)
        
        XCTAssertEqual(viewModel.validationResult, .failure(reason: "Should not empty", tableName: nil))
    }
    
    func testInputNonEmptyValue() {
        viewModel.name = "alex"
        
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.3)

        XCTAssertEqual(viewModel.validationResult, .success(.none))
    }
}
