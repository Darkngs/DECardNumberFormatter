# **DECardNumberFormatter**

## Formats
- 4-5-6 (4-5-6-4)
- 4-6-5 (4-6-5-4)
- 4-4-4-4 (4-4-4-4-3)

## Example - DECardNumberFormatter
```swift
let cardNumberFormatter = DECardNumberFormatter()

// AmEx
print(cardNumberFormatter.number(from: "34 12 123456 12345 1234"))
print(cardNumberFormatter.number(from: "37 12 123456 12345 1234"))

// Diners Club
print(cardNumberFormatter.number(from: "300 1 123456 12345 1234"))

// Other
print(cardNumberFormatter.number(from: "4141 4141 4141 4141 123"))

// UATP
print(cardNumberFormatter.number(from: "1 234 12345 123456 1234"))
```
##### Output
```
3412 123456 12345 1234
3712 123456 12345 1234
3001 123456 12345 1234
4141 4141 4141 4141 123
1234 12345 123456 1234
```

## Example - DECardNumberTextField
```swift
let textField = DECardNumberTextField()
textField.setup()
```
