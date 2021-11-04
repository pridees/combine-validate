import Combine
import Foundation

public typealias ValidationPublisher = AnyPublisher<Validated, Never>

extension Publishers {
    public static func RegexValidator(
        for publisher: Published<String>.Publisher,
        regex pattern: RegexPattern,
        errorMessage: String,
        tableName: String? = nil
    ) -> ValidationPublisher {
        publisher
            .dropFirst()
            .map { $0.range(of: pattern, options: .regularExpression) != nil }
            .map { $0 ? .success : .failure(reason: errorMessage, tableName: tableName) }
            .eraseToAnyPublisher()
    }
    
    public static func NotEmptyValidator(
        for publisher: Published<String>.Publisher,
        errorMessage: String,
        tableName: String? = nil
    ) -> ValidationPublisher {
        publisher
            .dropFirst()
            .map(\.isEmpty)
            .map { !$0 ? .success : .failure(reason: errorMessage, tableName: tableName) }
            .eraseToAnyPublisher()
    }
    
    public static func ToggleValidator(
        for publisher: Published<Bool>.Publisher,
        errorMessage: String,
        tableName: String? = nil
    ) -> ValidationPublisher {
        publisher
            .dropFirst()
            .map { $0 ? .success : .failure(reason: errorMessage, tableName: tableName) }
            .eraseToAnyPublisher()
    }
}
