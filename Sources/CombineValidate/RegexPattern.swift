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
    
    /// Validate North American phone numbers with capture groups for the Area Code, Exchange Code, Line Number, and Extension.
    static let northAmericanPhone = #"(?=(?:^(?:\+?1\s*(?:[.-]\s*)?)?(?!(?:(?:.*\(.*)|(?:.*\).*)))(?:[2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))|(?:.*\((?:[2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\).*))(?:\+?1\s*(?:[.-]\s*)?)?(?:\(?([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\)?)\s*(?:[.-]\s*)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d{1,15}))?$"#
    
    /// Minimal requirements for basic strong password
    ///
    /// - 8 chars min
    /// - 1 special symbol
    /// - 1 Uppercase
    /// - 1 number
    static let strongPassword = #"/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/gm"#
    
    static let defaultDate = ""
    
    /// Credit card pattern
    ///
    /// - MasterCard -  ^5[1-5]\d+
    /// - Visa - ^4\d+
    /// - Amex - ^3[47]\d+
    /// - Discover - 6011|65|64...
    static let creditCard = #"(^5[1-5]|^4|^3[47])|(^6011|65|64[4-9]|622(1(2[6-9]|[3-9]\d)|[2-8]\d{2}|9([01]\d|2[0-5])))\d+"#
    
    /// Allows inserting expiry date as MM/YYYY or MM-YYYY format
    static let creditCardExpireDate = #"^(0[1-9]|1[0-2])(\/|-)([0-9]{4})$"#
    
    static let hexColor = #"/^#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$/"#
    
    
    /// Basic url validation
    static let url = #"/^((http?|https?|ftp|file):\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/"#
    
    static let ipv4 = #"/^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/"#
    
    static let northAmericaPostalCode = #"/(^\d{5}(-\d{4})?$)|(^[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$)/"#
    
    
    /// Hash tags like in Instagram `#WTF #CrazyCow`
    static let hashTag = #"/\B#([a-z0-9]{2,})(?![~!@#$%^&*()=+_`\-\|/'\[\]\{\}]|[?.,]*\w)/ig"#
    
    
    /// Youtube link looks like
    /// `https://www.youtube.com/watch?v=dQw4w9WgXcQ`
    static let youtubeURL = #"/(?:https?://)?(?:(?:(?:www\.?)?youtube\.com(?:/(?:(?:watch\?.*?(v=[^&\s]+).*)|(?:v(/.*))|(channel/.+)|(?:user/(.+))|(?:results\?(search_query=.+))))?)|(?:youtu\.be(/.*)?))/g"#
    
    static let anyNubmer = #"d"#
    
    static let positiveNumber = #"^\d+$"#
    static let negativeNumber = #"^-\d*\.?\d+$"#
    
    static let anyFloat = #"^[0-9]*.[0-9]*[1-9]+$"#
}


