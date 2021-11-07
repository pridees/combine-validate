//
//  File.swift
//  
//
//  Created by Alex O on 04.11.2021.
//

import Combine

/// Typealias for string represents regex pattern
public typealias RegexPattern = String

public protocol RegexProtocol where Self: RawRepresentable, Self.RawValue == RegexPattern {
    var pattern: RegexPattern { get }
}


/// Extensions with predefined popular regular expressions
///
/// Uses ``
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
    
    case wordAndDigitsOnly = #"^(\d|\w|\S){1,}$"#
    
    case anyInOneLine = #"^.+$"#
    
    public var pattern: RegexPattern { self.rawValue }
}


public enum NumberPattern: RegexPattern, RegexProtocol {
    case anyNumber = #"^(-)?[0-9]{1,18}$"#
    
    case positiveNumber = #"^\d+$"#
    
    case negativeNumber = #"^-\d*\.?\d+$"#
    
    case anyFloat = #"^(-)?[0-9]*.[0-9]*[1-9]+$"#
    
    public var pattern: RegexPattern { self.rawValue }
}

public enum URLPatterns: RegexPattern, RegexProtocol {
    /// Basic url validation
    case url = #"^((https?|ftp|file):\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$"#
    
    /// Youtube link looks like
    /// `https://www.youtube.com/watch?v=dQw4w9WgXcQ`
    case youtubeURL = #"/(?:https?://)?(?:(?:(?:www\.?)?youtube\.com(?:/(?:(?:watch\?.*?(v=[^&\s]+).*)|(?:v(/.*))|(channel/.+)|(?:user/(.+))|(?:results\?(search_query=.+))))?)|(?:youtu\.be(/.*)?))/g"#
    
    public var pattern: RegexPattern { self.rawValue }
}

//public enum Patterns: RegexPattern, RegexProtocol  {
//
//    case hexColor = #"/^#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$/"#
//
//    case ipv4 = #"/^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/"#
//
//    case northAmericanPostalCode = #"/(^\d{5}(-\d{4})?$)|(^[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$)/"#
//
//    /// Hash tags like in Instagram `#WTF #CrazyCow`
//    case hashTag = #"/\B#([a-z0-9]{2,})(?![~!@#$%^&*()=+_`\-\|/'\[\]\{\}]|[?.,]*\w)/ig"#
//
//    public var pattern: RegexPattern { self.rawValue }
//}
