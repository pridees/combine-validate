import Combine

/// Publisher for regular validation cases
///
/// Uses with:
/// - ``NotEmptyValidator(for:error:tableName:)``
/// - ``ToggleValidator(for:error:tableName:)``
/// - ``RegexValidator(for:regex:error:tableName:)``
/// - ``MultiRegexValidator(for:regexs:errors:tableName:)``
public typealias ValidationPublisher = AnyPublisher<Validated<Void>, Never>

/// Rich publisher with success cases payload
///
/// Use when you want to push through pipeline particular success case conforming ``RegexProtocol``
/// Uses with ``OneOfRegexValidator(for:regexs:error:tableName:)``
public typealias ValidationPublisherOf<T> = AnyPublisher<Validated<T>, Never>
