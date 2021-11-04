//
//  File.swift
//  
//
//  Created by Alex O on 04.11.2021.
//

public enum Validated: Equatable {
    case untouched
    case success
    case failure(reason: String, tableName: String?)
    
    public var isUntouched: Bool {
        guard case .untouched = self else { return false }
        return true
    }
    
    public var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }
}
