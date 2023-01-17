# SwiftRegex
Regex for Swift code
![This is an image](https://ik.imagekit.io/m1ke1magek1t/Github_Readme_/Swift_Regex_j5WM--g1N.png?ik-sdk-version=javascript-1.4.3&updatedAt=1673932121304)


You can copy this file ([Regex](https://github.com/mikekaels/SwiftRegex/blob/main/SwiftRegex/Regex.swift)) into your code 

# This regex handling many kind of validation as the list below:
- URL
- Email
- Password
- Phone Number
- Only contain letters
- Only contain digits
- Only contain lower case letters
- Only contain capital letters
- Only contain special characters
- Minimum characters
- Maximum characters
- Minimum letters
- Minimum capital letters
- Minimum lower case letters
- Minimum digits
- Minimum special character

# How to validate text
```
  let string = "text"
  // Unwrap with if let because it will return optional Array of Strings
  if let errorMessage = string.validateText(constraints: [
     Regex.init(.minCharacters(min: 10), errorMessage: "Minimum 10 character"),
     Regex.init(.capitalLetters(min: 1), errorMessage: "Minimum 1 capital letters")
  ]) {
     print(errorMessage.joined(separator: ", ")) 
     // > Minimum 10 character, Minimum 1 capital letters
  }
```

# How to validate URL
```
  let string = "htp://privy.id"
  if let errorMessage = string.validateURL(errorMessage: "Invalid URL") {
     print(errorMessage)
     // > Invalid URL
  }
```
