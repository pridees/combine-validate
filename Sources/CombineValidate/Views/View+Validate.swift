import Combine
import SwiftUI

extension TextField {
    public func validate(
        for publisher: ValidationPublisher,
        configuration: ValidationWrapper<Self, Void>.Configuration = .default
    ) -> some View {
        ValidationWrapper(self, publisher, configuration: configuration)
    }
    
    public func validate<T: RegexProtocol>(
        for publisher: RichValidationPublisher<T>,
        configuration: ValidationWrapper<Self, T>.Configuration = .default
    ) -> some View {
        ValidationWrapper(self, publisher, configuration: configuration)
    }
}

extension SecureField {
    public func validate(
        for publisher: ValidationPublisher,
        configuration: ValidationWrapper<Self, Void>.Configuration = .default
    ) -> some View {
        ValidationWrapper(self, publisher, configuration: configuration)
    }
}

extension Toggle {
    public func validate(
        for publisher: ValidationPublisher
    ) -> some View {
        ValidationWrapper(self, publisher, configuration: .hintOnly)
    }
}
