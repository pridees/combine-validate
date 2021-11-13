import XCTest
@testable import CombineValidate

class InternalRegexTests: XCTestCase {
    func testEmail() {
        let email = "somemail@gmail.com"
        XCTAssertTrue(RegularPattern.email.test(email), "Tested \(email) should be email")
        
        let nonEmail = "Some string"
        XCTAssertFalse(RegularPattern.email.test(nonEmail), "Tested \(nonEmail) as negative case should be passed successfully")
        
        let nonEmailEmptyString = ""
        XCTAssertFalse(RegularPattern.email.test(nonEmailEmptyString), "Tested \(nonEmail) as negative case should be passed successfully")
    }
    
    func testStrongPassword() {
        let strongPassword = "dk%1P2Nd"
        XCTAssertTrue(
            RegularPattern.strongPassword.test(strongPassword),
            "Strong password. Positive case failed"
        )
        
        let generatedStrongPassword = "t@yd!GANpuJ_dKw2L7AYXQoP"
        XCTAssertTrue(
            RegularPattern.strongPassword.test(generatedStrongPassword),
            "Strong password. Positive case failed"
        )
        
        let weakPassword = "weakPassord"
        XCTAssertFalse(
            RegularPattern.strongPassword.test(weakPassword),
            "Strong password. Negative case. Failed"
        )
    }
    
    func testNonEmpty() {
        let notEmpty = "S"
        XCTAssertTrue(
            RegularPattern.notEmpty.test(notEmpty),
            "Not empty. Positive case failed"
        )
        
        let notEmptyWithWhiteSpace = " 1 "
        XCTAssertTrue(
            RegularPattern.notEmpty.test(notEmptyWithWhiteSpace),
            "Not empty with whitespace. Positive case. Failed"
        )
        
        let empty = ""
        XCTAssertFalse(
            RegularPattern.notEmpty.test(empty),
            "Not empty. Negative case. Failed"
        )
        
        let emptyWithWhiteSpace = " "
        XCTAssertFalse(
            RegularPattern.notEmpty.test(emptyWithWhiteSpace),
            "Not empty with whitespace. Negative case. Failed"
        )
    }
    
    func testMustIncludeCapitalLetters() {
        let capitalLettersOnly = "ABCD"
        XCTAssertTrue(
            RegularPattern.mustIncludeCapitalLetters.test(capitalLettersOnly),
            "Must include capital letter: \(capitalLettersOnly). Positive case. Failed"
        )
        
        let mixedLetters = "AbCd"
        XCTAssertTrue(
            RegularPattern.mustIncludeCapitalLetters.test(mixedLetters),
            "Must include capital letter: \(mixedLetters). Positive case. Failed"
        )
        
        let lowercasedOnly = "abcd"
        XCTAssertFalse(
            RegularPattern.mustIncludeCapitalLetters.test(lowercasedOnly),
            "Must include capital letter: \(lowercasedOnly). Negative case. Failed"
        )
        
        let whitespaces = "  "
        XCTAssertFalse(
            RegularPattern.mustIncludeCapitalLetters.test(whitespaces),
            "Must include capital letter: empty string with whitespace. Negative case. Failed"
        )
        
        let empty = ""
        XCTAssertFalse(
            RegularPattern.mustIncludeCapitalLetters.test(empty),
            "Must include capital letter: empty string. Negative case. Failed"
        )
    }
    
    func testMustIncludeSpecialSymbols() {
        let symbols = ["%", "!", "\\", ":", "@", "[", "{", "`", "~"]
                       
        for symbol in symbols {
            XCTAssertTrue(
                RegularPattern.mustIncludeSpecialSymbols.test(symbol),
                "Must include special symbol: \(symbol). Positive case. Failed"
            )
        }
        
        let anyOtherSymbols = "1a"
        XCTAssertFalse(
            RegularPattern.mustIncludeSpecialSymbols.test(anyOtherSymbols),
            "Must include special symbol: \(anyOtherSymbols). Negative case. Failed"
        )
        
        let whitespaces = "  "
        XCTAssertFalse(
            RegularPattern.mustIncludeSpecialSymbols.test(whitespaces),
            "Must include special symbol: empty string with whitespace. Negative case. Failed"
        )
        
        let empty = ""
        XCTAssertFalse(
            RegularPattern.mustIncludeSpecialSymbols.test(empty),
            "Must include special symbol: empty string. Negative case. Failed"
        )
    }
    
    func testMustIncludeDigitNumbers() {
        let numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        
        for number in numbers {
            XCTAssertTrue(
                RegularPattern.mustIncludeNumbers.test(number),
                "Must include digit number: \(number). Positive case. Failed"
            )
        }
        
        let anyOtherSymbolsWithDigit = "1a"
        XCTAssertTrue(
            RegularPattern.mustIncludeNumbers.test(anyOtherSymbolsWithDigit),
            "Must include digit number: \(anyOtherSymbolsWithDigit). Positive case. Failed"
        )
        
        let withoudDigit = "av%"
        XCTAssertFalse(
            RegularPattern.mustIncludeNumbers.test(withoudDigit),
            "Must include digit number: \(withoudDigit). Negative case. Failed"
        )
        
        let whitespaces = "  "
        XCTAssertFalse(
            RegularPattern.mustIncludeNumbers.test(whitespaces),
            "Must include digit number: empty string with whitespace. Negative case. Failed"
        )
        
        let empty = ""
        XCTAssertFalse(
            RegularPattern.mustIncludeNumbers.test(empty),
            "Must include digit number: empty string. Negative case. Failed"
        )
    }
    
    func testMustIncludeSmallLetters() {
        let lowercasedLettersOnly = "abcd"
        XCTAssertTrue(
            RegularPattern.mustIncludeSmallLetters.test(lowercasedLettersOnly),
            "Must include lowercased letter: \(lowercasedLettersOnly). Positive case. Failed"
        )
        
        let mixedLetters = "AbCd"
        XCTAssertTrue(
            RegularPattern.mustIncludeSmallLetters.test(mixedLetters),
            "Must include lowercased letter: \(mixedLetters). Positive case. Failed"
        )
        
        let uppercasedOnly = "ABCD"
        XCTAssertFalse(
            RegularPattern.mustIncludeSmallLetters.test(uppercasedOnly),
            "Must include lowercased letter: \(uppercasedOnly). Negative case. Failed"
        )
        
        let whitespaces = " "
        XCTAssertFalse(
            RegularPattern.mustIncludeCapitalLetters.test(whitespaces),
            "Must include lowercased letter: empty string with whitespaces. Negative case. Failed"
        )
        
        let empty = ""
        XCTAssertFalse(
            RegularPattern.mustIncludeCapitalLetters.test(empty),
            "Must include lowercased letter: empty string. Negative case. Failed"
        )
    }
    
    func testwordAndDigitsOnly() {
        let wordsOnly = "AccesS"
        XCTAssertTrue(
            RegularPattern.wordAndDigitsOnly.test(wordsOnly),
            "Words and digits only: \(wordsOnly). Positive case. Failed"
        )
        
        let digitsOnly = "12345"
        XCTAssertTrue(
            RegularPattern.wordAndDigitsOnly.test(digitsOnly),
            "Words and digits only: \(digitsOnly). Positive case. Failed"
        )
        
        let wordsAndSpecialSymbols = "Asdb%^"
        XCTAssertTrue(
            RegularPattern.wordAndDigitsOnly.test(wordsAndSpecialSymbols),
            "Words and digits only: \(wordsAndSpecialSymbols). Positive case. Failed"
        )
        
        let digitsAndSpecialSymbols = "13{24_431"
        XCTAssertTrue(
            RegularPattern.wordAndDigitsOnly.test(digitsAndSpecialSymbols),
            "Words and digits only: \(digitsAndSpecialSymbols). Positive case. Failed"
        )
        
        let whitespaces = "  "
        XCTAssertFalse(
            RegularPattern.wordAndDigitsOnly.test(whitespaces),
            "Words and digits only: empty string with whitespace. Negative case. Failed"
        )
        
        let empty = ""
        XCTAssertFalse(
            RegularPattern.wordAndDigitsOnly.test(empty),
            "Words and digits only: empty string. Negative case. Failed"
        )
    }
}
