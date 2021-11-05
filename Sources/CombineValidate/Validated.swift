import Foundation

public enum Validated<SuccessPayload> : Equatable {
    case untouched
    case success(SuccessPayload?)
    case failure(reason: String, tableName: String?)
    
    public var isUntouched: Bool {
        guard case .untouched = self else { return false }
        return true
    }
    
    public var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }
    
    public static func == (lhs: Validated<SuccessPayload>, rhs: Validated<SuccessPayload>) -> Bool {
        switch (lhs, rhs) {
        case (.untouched, .untouched): return true
        case (.success, .success): return true
        case (.failure, .failure): return true
        default: return false
        }
    }
}
