import Combine

/// Useful extension for Published wrapped values
extension Publisher where Output == String, Failure == Never {
    public func validateNonEmpty(
        error message: String,
        tableName: String? = nil
    ) -> ValidationPublisher {
        NotEmptyValidator(for: AnyPublisher(self), error: message, tableName: tableName)
    }
    
    public func validateWithRegex<R: RegexProtocol>(
        regex pattern: R,
        error message: String,
        tableName: String? = nil
    ) -> ValidationPublisher {
        RegexValidator(for: AnyPublisher(self), regex: pattern, error: message, tableName: tableName)
    }
    
    public func validateOneOfRegex<R: RegexProtocol>(
        regexs patterns: [R],
        error message: String,
        tableName: String? = nil
    ) -> ValidationPublisherOf<R> {
        OneOfRegexValidator(for: AnyPublisher(self), regexs: patterns, error: message, tableName: tableName)
    }
    
    public func validateWithMultiRegex<R: RegexProtocol>(
        regexs patterns: [R],
        errors messages: [String],
        tableName: String? = nil
    ) -> ValidationPublisher {
        MultiRegexValidator(for: AnyPublisher(self), regexs: patterns, errors: messages, tableName: tableName)
    }
}

extension Published.Publisher where Value == Bool {
    public func validateToggle(
        error message: String,
        tableName: String? = nil
    ) -> ValidationPublisher {
        ToggleValidator(for: AnyPublisher(self), error: message, tableName: tableName)
    }
}

