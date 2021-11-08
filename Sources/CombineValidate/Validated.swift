/// Cases for validation result
///
/// - `Untouch` case as initial state
/// - `Success` case with payload
/// - `Failure` case with reason and localization table name
public enum Validated<Payload> : Equatable {
    case untouched
    case success(Payload?)
    case failure(reason: String, tableName: String?)
    
    public var isUntouched: Bool {
        guard case .untouched = self else { return false }
        return true
    }
    
    public var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }
    
    public static func == (lhs: Validated<Payload>, rhs: Validated<Payload>) -> Bool {
        switch (lhs, rhs) {
        case (.untouched, .untouched): return true
        case (.success, .success): return true
        case (.failure(let reasonLhs, let tableNameLhs), .failure(let reasonRhs, let tableNameRhs)):
            guard reasonLhs == reasonRhs && tableNameLhs == tableNameRhs else { return false }
            return true
        default: return false
        }
    }
}

extension Validated where Payload: RegexProtocol {
    var payload: Payload? {
        guard case let .success(payload) = self else { return nil }
        return payload
    }
}
