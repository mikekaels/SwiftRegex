//
//  Regex.swift
//  SwiftRegex
//
//  Created by Santo Michael on 17/01/23.
//

import Foundation

    /// Enum for rules/constraints for the Regex validation
public enum RegexType: Hashable {
        /// Regex for email validation
    case email
    
        /// Regex for phone number validation
        ///
    case phoneNumber
    
        /// Regex for url validation
    case url
    
        /// Regex to validate text which only contain letters
    case onlyLetters
    
        /// Regex to validate text which only contain numbers
    case onlyNumbers
    
        /// Regex to validate text which only contain capital
    case onlyCapitalLetters
    
        /// Regex to validate text which only contain lower case
    case onlyLowerCase
    
        /// Regex to validate text which only contain special character
    case onlySpecialCharacter
    
        /// Regex for text to validate the minimum characters
        /// - Parameter min: minimum of the characters
    case minCharacters(min: Int)
    
        /// Regex for text to validate the maximum characters
        /// - Parameter max: maximum of the characters
    case maxCharacters(max: Int)
    
        /// Regex for text to validate the minimum letters
        /// - Parameter min: minimum of the letters
    case letters(min: Int = 1)
    
        /// Regex for text to validate the minimum capital letters
        /// - Parameter min: minimum of the capital letters
    case capitalLetters(min: Int = 1)
    
        /// Regex for text to validate the lower case letters
        /// - Parameter min: minimum of the lower case letters
    case lowerCaseLetters(min: Int = 1)
    
        /// Regex for text to validate the minimum numbers
        /// - Parameter min: minimum of the numbers
    case numbers(min: Int = 1)
    
        /// Regex for text to validate the minimum special character
        /// - Parameter min: minimum of the special characters
    case specialCharacters(min: Int = 1)
    
    public var regexString: String {
        switch self {
            case .email:
                return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            case .phoneNumber:
                return "^[0-9+]{0,1}+[0-9]{10,13}$"
            case .url:
                return "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
            case .onlyLetters:
                return "^[a-zA-Z]+$"
            case .onlyNumbers:
                return "^[0-9]+$"
            case .onlyCapitalLetters:
                return "^[A-Z]+$"
            case .onlyLowerCase:
                return "^[a-z]+$"
            case .onlySpecialCharacter:
                return "^[^A-Za-z0-9]+$"
            case .minCharacters(let n):
                return "(?=.{\(n),})"
            case .maxCharacters(let n):
                return "(?=^.{0,\(n)}$)"
            case .letters(let n):
                return "[A-Za-z]{\(n)}"
            case .capitalLetters(let n):
                return "(?=.*[A-Z]{\(n)})"
            case .lowerCaseLetters(let n):
                return "[a-z]{\(n),}"
            case .numbers(let n):
                return "[0-9]{\(n)}"
            case .specialCharacters(let n):
                return "(?=.*[^A-Za-z0-9]{\(n)})"
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.regexString == rhs.regexString
    }
}

    /// Struct Regex is a model contains pattern and error message.
    /// Use this when implementing validateText function of String extension
public struct Regex {
    public let pattern: RegexType
    public let errorMessage: String
    
    public init(_ pattern: RegexType, errorMessage: String) {
        self.pattern = pattern
        self.errorMessage = errorMessage
    }
}

public extension String {
    
        /// Function to validate a text with the additional rule/constraint.
        /// It will return an array of strings when the text doesn't match with the patterns,
        /// instead returning nil when every constraint match the need.
        ///
        /// The password validation in the following example:
        ///
        ///     let errorMessage = text.validateText(constraints: [
        ///         Regex.init(.numbers(), errorMessage: "At least 1 number"),
        ///         Regex.init(.capitalLetters(), errorMessage: "At least 1 capital letters"),
        ///         Regex.init(.minCharacters(min: 8), errorMessage: "Minimum 8 characters"),
        ///         Regex.init(.specialCharacters(), errorMessage: "At least 1 special characters")
        ///     ])
        ///
        /// Using the `.validateText` method to validate text (String)
        ///
        /// - Parameter constraints: an array of Regex
        /// - Returns: Optional array of Strings or Nil
    func validateText(constraints: [Regex]) -> [String]? {
        let arr = Array(self).sorted(by: { $0 > $1 }) // O(n)
        var result: [String] = []
        
        for pattern in constraints { /// O(n)
            if String(arr).range(of: pattern.pattern.regexString, options: .regularExpression) == nil {
                result.append(pattern.errorMessage)
            }
        }
        
        if result.isEmpty { return nil }
        else { return result }
    }
    
    
        /// Function to validate a url text with the error message as the paramater.
        /// it will return a string when the text doesn't match with the pattern,
        /// instead returning nil when match the constraints
        ///
        /// The url validation in the following example:
        ///
        ///     let errorMessage = text.validateURL(errorMessage: "Url invalid")
        ///
        /// Using the `.validateURL` method to validate text with a url value (String)
        ///
        /// - Parameter errorMessage: text for the error message
        /// - Returns: Optional String or String
    func validateURL(errorMessage: String) -> String? {
        if self.range(of: RegexType.url.regexString, options: .regularExpression) == nil {
            return errorMessage
        } else {
            return nil
        }
    }
}
