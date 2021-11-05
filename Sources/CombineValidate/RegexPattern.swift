//
//  File.swift
//  
//
//  Created by Alex O on 04.11.2021.
//

import Foundation

/// Add your own patters with type extension
public typealias RegexPattern = String

extension RegexPattern {
    /// Regular email validation (Not enought conforming to RFC)
    static let email = #"((?!\.)[\w-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$"#
    
    /// Minimal requirements for basic strong password
    ///
    /// - 8 chars min
    /// - 1 special symbol
    /// - 1 Uppercase
    /// - 1 number
    static let strongPassword = #"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$"#
    
    /// Allows inserting expiry date as MM/YYYY or MM-YYYY format
    static let creditCardExpireDate = #"^(0[1-9]|1[0-2])(\/|-)([0-9]{4})$"#
    
    static let hexColor = #"/^#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$/"#
    
    
    /// Basic url validation
    static let url = #"^((https?|ftp|file):\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$"#
    
    static let ipv4 = #"/^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/"#
    
    static let northAmericanPostalCode = #"/(^\d{5}(-\d{4})?$)|(^[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$)/"#
    
    
    /// Hash tags like in Instagram `#WTF #CrazyCow`
    static let hashTag = #"/\B#([a-z0-9]{2,})(?![~!@#$%^&*()=+_`\-\|/'\[\]\{\}]|[?.,]*\w)/ig"#
    
    
    /// Youtube link looks like
    /// `https://www.youtube.com/watch?v=dQw4w9WgXcQ`
    static let youtubeURL = #"/(?:https?://)?(?:(?:(?:www\.?)?youtube\.com(?:/(?:(?:watch\?.*?(v=[^&\s]+).*)|(?:v(/.*))|(channel/.+)|(?:user/(.+))|(?:results\?(search_query=.+))))?)|(?:youtu\.be(/.*)?))/g"#
    
    static let number = #"^(-)?[0-9]{1,18}$"#
    
    static let positiveNumber = #"^\d+$"#
    
    static let negativeNumber = #"^-\d*\.?\d+$"#
    
    static let float = #"^(-)?[0-9]*.[0-9]*[1-9]+$"#
}


/// Credit card pattens uses with ``CreditCardValidator``
public enum CreditCardPattern: RegexPattern {
    /// American Express payment system
    case Amex = #"^(34|37)\d{13}$"#
    
    /// Internantion payment system
    case Visa = #"^4[0-9]{12}(?:\d{3})?$"#
    
    /// Internantion payment system
    case Mastercard = #"^(5{1}[0-5]{1})\d{14}$"#
    /// Debit and Prepaid card issuer
    ///
    /// IIN ranges: 0604, 5018, 5020, 5038, 5612, 5761, 5893, 6304, 6390, 6759, 6761, 6762, 6763
    case Maestro = #"^(?:0604|5018|5020|5038|5612|5761|5893|6304|6390|6759|6761|6762|6763)[0-9]{8,15}$"#
    
    /// Credit card brand from US
    case Discover = #"^(6011|6445)[0-9]{12}$"#
    
    /// Japan Credit Bureau
    ///
    /// [Wikipedia](https://en.wikipedia.org/wiki/JCB_Co.,_Ltd.)
    ///
    /// IIN ranges: 2131, 1800, 35
    case JSB = #"^(?:2131|1800|35\d{3})\d{11}$"#
    
    /// Chinese national payment system
    ///
    /// [Wikipedia](https://en.wikipedia.org/wiki/UnionPay)
    case UnionPay = #"^(62\d{14}|8171\d{12}(\d{3})?)$"#
    
    /// Russian payment system
    ///
    /// [Wikipedia](https://en.wikipedia.org/wiki/Mir_(payment_system))
    ///
    /// IIN ranges: 2200–2204
    case Mir = #"^(220)[0-4]{1}[0-9]{12}$"#

    public var pattern: RegexPattern { self.rawValue }
}
