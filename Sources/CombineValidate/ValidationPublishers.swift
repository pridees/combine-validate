import Combine
import Foundation

public typealias ValidationPublisher<T> = AnyPublisher<Validated<T>, Never>

extension Publishers {
    public static func RegexValidator(
        for publisher: Published<String>.Publisher,
        regex pattern: RegexPattern,
        errorMessage: String,
        tableName: String? = nil
    ) -> ValidationPublisher<Void> {
        publisher
            .dropFirst()
            .map { $0.range(of: pattern, options: .regularExpression) != nil }
            .map { $0 ? .success(()) : .failure(reason: errorMessage, tableName: tableName) }
            .eraseToAnyPublisher()
    }
    
    public static func NotEmptyValidator(
        for publisher: Published<String>.Publisher,
        errorMessage: String,
        tableName: String? = nil
    ) -> ValidationPublisher<Void> {
        publisher
            .dropFirst()
            .map(\.isEmpty)
            .map { !$0 ? .success(()) : .failure(reason: errorMessage, tableName: tableName) }
            .eraseToAnyPublisher()
    }
    
    public static func ToggleValidator(
        for publisher: Published<Bool>.Publisher,
        errorMessage: String,
        tableName: String? = nil
    ) -> ValidationPublisher<Void> {
        publisher
            .dropFirst()
            .map { $0 ? .success(()) : .failure(reason: errorMessage, tableName: tableName) }
            .eraseToAnyPublisher()
    }
    
    public static func CreditCardValidator(
        for publisher: Published<String>.Publisher,
        cards patterns: [CreditCardPattern],
        errorMessage: String,
        tableName: String? = nil
    ) -> ValidationPublisher<CreditCardPattern> {
        publisher
            .dropFirst()
            .map { number in
                for card in patterns {
                    if number.range(of: card.pattern, options: .regularExpression) != nil {
                        return .success(card)
                    }
                }
                return .failure(reason: errorMessage, tableName: tableName)
            }
            .eraseToAnyPublisher()
    }
}
