import Foundation
import Combine

public func NotEmptyValidator(
    for publisher: Published<String>.Publisher,
    error message: String,
    tableName: String? = nil
) -> ValidationPublisher {
    publisher
        .dropFirst()
        .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
        .map(\.isEmpty)
        .map { !$0 ? .success(.none) : .failure(reason: message, tableName: tableName) }
        .eraseToAnyPublisher()
}

public func RegexValidator<Pattern>(
    for publisher: Published<String>.Publisher,
    regex pattern: Pattern,
    error message: String,
    tableName: String? = nil
) -> ValidationPublisher where Pattern: RegexProtocol {
    publisher
        .dropFirst()
        .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
        .map { pattern.test($0) }
        .map { $0 ? .success(.none) : .failure(reason: message, tableName: tableName) }
        .eraseToAnyPublisher()
}

public func OneOfRegexValidator<Pattern>(
    for publisher: Published<String>.Publisher,
    regexs patterns: [Pattern],
    error message: String,
    tableName: String? = nil
) -> RichValidationPublisher<Pattern> where Pattern: RegexProtocol {
    publisher
        .dropFirst()
        .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
        .map { value in
            for pattern in patterns {
                if  pattern.test(value) {
                    return .success(pattern)
                }
            }
            return .failure(reason: message, tableName: tableName)
        }
        .eraseToAnyPublisher()
}

public func MultiRegexValidator<Pattern>(
    for publisher: Published<String>.Publisher,
    regexs patterns: [Pattern],
    errors messages: [String],
    tableName: String? = nil
) -> ValidationPublisher where Pattern: RegexProtocol {
    publisher
        .dropFirst()
        .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
        .map { (value: String) -> [Validated<Void>] in
            var validationResults: [Validated<Void>] = .init(repeating: .untouched, count: patterns.count)
            
            for (index, pattern) in patterns.enumerated() {
                if pattern.test(value) {
                    validationResults[index] = .success(.none)
                } else {
                    validationResults[index] = .failure(reason: messages[index], tableName: tableName)
                }
            }
            return validationResults
        }
        .map { $0.allSatisfy { $0.isSuccess }
            ? .success(.none)
            : $0.first { $0 != .untouched && $0 != .success(.none) }!
        }
        .eraseToAnyPublisher()
}

public func ToggleValidator(
    for publisher: Published<Bool>.Publisher,
    error message: String,
    tableName: String? = nil
) -> ValidationPublisher {
    publisher
        .dropFirst()
        .map { $0 ? .success(.none) : .failure(reason: message, tableName: tableName) }
        .eraseToAnyPublisher()
}
