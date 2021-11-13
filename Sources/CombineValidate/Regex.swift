import Combine

/// Typealias for string represents regex pattern
public typealias RegexPattern = String

/// Describes enum instances when RawValues is ``RegexPattern``
public protocol RegexProtocol
where
    Self: RawRepresentable,
    Self.RawValue == RegexPattern
{
    
    var pattern: RegexPattern { get }
    
    /// Test provided string by regex within (it has default implementation)
    /// - Parameters:
    ///     - string: StringProtocol
    /// - Returns:
    ///     Boolean value with True if testing finished successfully
    func test<T: StringProtocol>(_ string: T) -> Bool
}

/// Default implementations for protocol API
public extension RegexProtocol {
    
    /// Returns the RawValue
    var pattern: RegexPattern { self.rawValue }
    
   
    func test<T: StringProtocol>(_ string: T) -> Bool {
        string.range(of: self.pattern, options: .regularExpression) != nil
    }
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
    case strongPassword = #"^(?=.*?[0-9])(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[^\w\s]).{8,}$"#
    
    case notEmpty = #"([[:graph:]])+"#
    
    /// String must include either 1 or more capital letter.
    /// Cannot be empty.
    case mustIncludeCapitalLetters = #"(?=.*[A-Z])"#
    
    /// String must include either 1 or more spectial symbol. % ! \ : @ [ { ` ~
    /// Cannot be empty.
    case mustIncludeSpecialSymbols = #"(?=.*[\%\!-\/\:-\@\[-\`\{-\~])"#
    
    /// String must include either 1 or more digit symbol.
    /// Cannot be empty.
    case mustIncludeNumbers = #"(?=.*[0-9])"#
    
    /// String must include either 1 or more lowercased letter.
    /// Cannot be empty.
    case mustIncludeSmallLetters = #"(?=.*[a-z])"#
    
    /// String must be consist from words or digits without whitespaces and new lines
    /// Cannot be empty.
    case wordAndDigitsOnly = #"^(\d|\w|\S){1,}$"#
}
