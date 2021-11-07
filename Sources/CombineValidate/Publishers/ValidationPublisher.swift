import Combine

public typealias ValidationPublisher = AnyPublisher<Validated<Void>, Never>

public typealias RichValidationPublisher<T> = AnyPublisher<Validated<T>, Never>
