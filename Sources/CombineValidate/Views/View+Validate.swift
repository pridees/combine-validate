import Combine
import SwiftUI

extension TextField {
    public func validate(
        for publisher: ValidationPublisher,
        configuration: ValidationWrapper<Self, Void>.Configuration = .default,
        _ onValidate: ((Validated<Void>) -> Void)? = nil
    ) -> some View {
        ValidationWrapper(self, publisher, configuration: configuration)
    }
    
    public func validate<T: RegexProtocol>(
        for publisher: RichValidationPublisher<T>,
        configuration: ValidationWrapper<Self, T>.Configuration = .default,
        _ onValidate: ((Validated<T>) -> Void)? = nil
    ) -> some View {
        ValidationWrapper(self, publisher, configuration: configuration)
    }
}

extension SecureField {
    public func validate(
        for publisher: ValidationPublisher,
        configuration: ValidationWrapper<Self, Void>.Configuration = .default,
        _ onValidate: ((Validated<Void>) -> Void)? = nil
    ) -> some View {
        ValidationWrapper(self, publisher, configuration: configuration)
    }
}

extension Toggle {
    public func validate(
        for publisher: ValidationPublisher,
        _ onValidate: ((Validated<Void>) -> Void)? = nil
    ) -> some View {
        ValidationWrapper(self, publisher, configuration: .hintOnly)
    }
}
