//
//  File.swift
//  
//
//  Created by Alex O on 03.11.2021.
//

#if canImport(Combine)
import Combine

extension Published.Publisher where Value == String {
    public func validateNonEmpty(
        errorMessage: String,
        tableName: String? = nil
    ) -> ValidationPublisher<Void> {
        Publishers.NotEmptyValidator(for: self, errorMessage: errorMessage, tableName: tableName)
    }
    
    public func validateWithRegex(
        regex pattern: RegexPattern,
        errorMessage: String,
        tableName: String? = nil
    ) -> ValidationPublisher<Void> {
        Publishers.RegexValidator(for: self, regex: pattern, errorMessage: errorMessage, tableName: tableName)
    }
}

extension Published.Publisher where Value == Bool {
    public func validateToggle(
        errorMessage: String,
        tableName: String? = nil
    ) -> ValidationPublisher<Void> {
        Publishers.ToggleValidator(for: self, errorMessage: errorMessage, tableName: tableName)
    }
}
#endif
