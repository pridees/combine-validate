import XCTest
import Combine
@testable import CombineValidate

final class ToggleValidatorTests: XCTestCase {
    class ViewModel: ObservableObject {
        @Published public var toggle = false
        
        @Published public var validationResult: Validated<Void> = .untouched
        
        public var subscription: AnyCancellable? = nil
        
        public lazy var toggleValidator: ValidationPublisher = {
            $toggle.validateToggle(error: "Should be checked", tableName: nil)
        }()
        
        init() {
            subscription = toggleValidator
                .assign(to: \.validationResult, on: self)
        }
    }
    
    let viewModel = ViewModel()
    
    func testIgnoreFirstValue() {
        XCTAssertEqual(viewModel.validationResult, .untouched)
    }
    
    func testCheckToggle() {
        viewModel.toggle = true
        XCTAssertEqual(viewModel.validationResult, .success(.none))
    }
    
    func testUncheckToggle() {
        viewModel.toggle = false
        XCTAssertEqual(viewModel.validationResult, .failure(reason: "Should be checked", tableName: nil))
    }
}
