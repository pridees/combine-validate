import Combine

/// Typealias for string represents regex pattern
public typealias RegexPattern = String

/// Describes enum instances when RawValues is ``RegexPattern``
public protocol RegexProtocol where Self: RawRepresentable, Self.RawValue == RegexPattern {
    var pattern: RegexPattern { get }
}

public extension RegexProtocol {
    var pattern: RegexPattern { self.rawValue }
}

/// Extensions with predefined popular regular expressions
///
/// Conforming to ``RegexPattern`` & ``RegexProtocol``
public enum RegularPattern: RegexPattern, RegexProtocol {
    /// Regular email validation (Not enought conforming to RFC)
    case email = #"((?!\.)[\w-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$"#
    
    /// Minimal requirements for basic strong password
    ///
    /// - 8 chars min
    /// - 1 special symbol
    /// - 1 Uppercase
    /// - 1 number
    case strongPassword = #"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$"#
    
    case notEmpty = #"[\S\s]+[\S]+"#
    
    case mustIncludeCapitalLetters = #"(?=.*[A-Z])"#
    
    case mustIncludeSpecialSymbols = #"(?=.*[\%\!-\/\:-\@\[-\`\{-\~])"#
    
    case mustIncludeNumbers = #"(?=.*[0-9])"#
    
    case mustIncludeSmallLetters = #"(?=.*[a-z])"#
    
    case wordAndDigitsOnly = #"^(\d|\w|\S){1,}$"#
    
    case anyInOneLine = #"^.+$"#
}
