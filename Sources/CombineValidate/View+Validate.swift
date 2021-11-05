import Combine
import SwiftUI

extension TextField {
    public func validate<T>(
        for publisher: ValidationPublisher<T>,
        successImage: Image? = Image(systemName: "checkmark.circle"),
        failureImage: Image? = Image(systemName: "xmark.circle"),
        _ onValidate: ((Validated<T>) -> Void)? = nil
    ) -> some View {
        ValidationWrapper(self, publisher, successImage: successImage, failureImage: failureImage, onValidate)
    }
}

extension SecureField {
    public func validate<T>(
        for publisher: ValidationPublisher<T>,
        successImage: Image? = Image(systemName: "checkmark.circle"),
        failureImage: Image? = Image(systemName: "xmark.circle"),
        _ onValidate: ((Validated<T>) -> Void)? = nil
    ) -> some View {
        ValidationWrapper(self, publisher, successImage: successImage, failureImage: failureImage, onValidate)
    }
}

extension Toggle {
    public func validate<T>(
        for publisher: ValidationPublisher<T>,
        _ onValidate: ((Validated<T>) -> Void)? = nil
    ) -> some View {
        ValidationWrapper(self, publisher, successImage: nil, failureImage: nil, onValidate)
    }
}
