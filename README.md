# **DECardNumberFormatter**

## Formats
- 4-5-6 • (4-5-6-4)
- 4-6-5 • (4-6-5-4)
- 4-4-4-4 • (4-4-4-4-3)

## Example - DECardNumberFormatter
```swift
let cardNumberFormatter = DECardNumberFormatter()

// AmEx
print(cardNumberFormatter.number(from: "34 12 123456 12345 1234"))
print(cardNumberFormatter.number(from: "37 12 123456 12345 1234"))

// Diners Club
var cardNumber = "300 1 123456 12345 1234"
print(cardNumberFormatter.number(from: cardNumber))
if cardNumberFormatter.isValidLuhnCardNumber(cardNumber) {
   print("Card number: \(cardNumber) - is valid!")
}

// Other
cardNumber = "4111111111111111"
print(cardNumberFormatter.number(from: cardNumber))
if cardNumberFormatter.isValidLuhnCardNumber(cardNumber) {
   print("Card number: \(cardNumber) - is valid!")
}

// UATP
cardNumber = "1 234 12345 123456 1234"
print(cardNumberFormatter.number(from: cardNumber))
if cardNumberFormatter.isValidLuhnCardNumber(cardNumber) {
   print("Card number: \(cardNumber) - is valid!")
}
```
##### Output
```
3412 123456 12345 1234
3712 123456 12345 1234
3001 123456 12345 1234
4111 1111 1111 1111
Card number: 4111111111111111 - is valid!
1234 12345 123456 1234
```

## Example - DECardNumberTextField
```swift
let textField = DECardNumberTextField()
textField.setup()
```
