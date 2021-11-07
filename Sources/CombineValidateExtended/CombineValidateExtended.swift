import Combine
import CombineValidate

/// Credit card validtaion pattens are conforming to ``CombineValidateRegexPattern`` & ``CombineValidate.RegexProtocol``
public enum CreditCardPattern: RegexPattern, RegexProtocol {
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
    case JSB = #"^(2131|1800|35\d{3})\d{11}$"#
    
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
    
    /// Allows inserting expiry date as MM/YYYY or MM-YYYY format
    case cardExpireDate = #"^(0[1-9]|1[0-2])(\/|-)([0-9]{4})$"#

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
