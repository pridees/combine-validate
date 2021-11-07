//
//  File.swift
//  
//
//  Created by Alex O on 03.11.2021.
//

import Combine

/// Useful extension for Published wrapped values
extension Published.Publisher where Value == String {
    public func validateNonEmpty(
        error message: String,
        tableName: String? = nil
    ) -> ValidationPublisher {
        Publishers.NotEmptyValidator(for: self, error: message, tableName: tableName)
    }
    
    public func validateWithRegex<R: RegexProtocol>(
        regex pattern: R,
        error message: String,
        tableName: String? = nil
    ) -> ValidationPublisher {
        Publishers.RegexValidator(for: self, regex: pattern, error: message, tableName: tableName)
    }
    
    public func validateOneOfRegex<R: RegexProtocol>(
        regexs patterns: [R],
        error message: String,
        tableName: String? = nil
    ) -> RichValidationPublisher<R> {
        Publishers.OneOfRegexValidator(for: self, regexs: patterns, error: message, tableName: tableName)
    }
    
    public func validateWithMultiRegex<R: RegexProtocol>(
        regexs patterns: [R],
        errors messages: [String],
        tableName: String? = nil
    ) -> ValidationPublisher {
        Publishers.MultiRegexValidator(for: self, regexs: patterns, errors: messages, tableName: tableName)
    }
}

extension Published.Publisher where Value == Bool {
    public func validateToggle(
        error message: String,
        tableName: String? = nil
    ) -> ValidationPublisher {
        Publishers.ToggleValidator(for: self, error: message, tableName: tableName)
    }
}

