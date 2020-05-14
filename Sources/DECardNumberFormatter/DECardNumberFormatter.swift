// Developed by Mykola Darkngs Golyash
// 2020
// http://golyash.com

import Foundation

public enum DECardBrand {
   
   case AmEx
   
   case DinersClub
   
   case Discover
   
   case JCB
   
   case MasterCard
   
   case UATP
   
   case UnionPay
   
   case Visa
   
   case Unknown
}

public enum DECardNumberFormat {
   
   case de456
   
   case de465
   
   case de4444
}

public class DECardNumberFormatter {
   
   private let maxLength = 19
   
   // MARK: -
   
   public init() {
      
   }
   
   // MARK: -
   
   private func cardFormat(for cardType: DECardBrand) -> DECardNumberFormat {
      var cardFormat: DECardNumberFormat = .de4444
      switch cardType {
      case .AmEx, .DinersClub:
         cardFormat = .de465
      case .UATP:
         cardFormat = .de456
      default:
         break
      }
      return cardFormat
   }
   
   // MARK: -
   
   public func cardBrand(from cardNumber: String) -> DECardBrand {
      var prefixes = ["34", "37"]
      if cardNumber.hasPrefix(prefixes) {
         return .AmEx
      }
      
      prefixes = ["300", "301", "302", "303", "304", "305", "309", "36", "38", "39"]
      if cardNumber.hasPrefix(prefixes) {
         return .DinersClub
      }
      
      prefixes = ["60", "64", "65"]
      if cardNumber.hasPrefix(prefixes) {
         return .Discover
      }
      
      if cardNumber.hasPrefix("35") {
         return .JCB
      }
      
      prefixes = ["22", "23", "24", "25", "26", "27", "50", "51", "52", "53", "54", "55", "56", "57", "58", "67"]
      if cardNumber.hasPrefix(prefixes) {
         return .MasterCard
      }
      
      if cardNumber.hasPrefix("1") {
         return .UATP
      }
      
      if cardNumber.hasPrefix("62") {
         return .UnionPay
      }
      
      if cardNumber.hasPrefix("4") {
         return .Visa
      }
      
      return .Unknown
   }
   
   public func clearNumber(from cardNumber: String) -> String {
      let numbers = Set("0123456789")
      return cardNumber.filter {
         numbers.contains($0)
      }
   }
   
   public func isValidLuhnCardNumber(_ cardNumber: String) -> Bool {
      let reversedDigits = clearNumber(from: cardNumber).reversed().map {
         Int(String($0))!
      }
      let checkSum = reversedDigits.enumerated().reduce(0) { sum, pair in
         let (reversedIndex, digit) = pair
         return sum + (reversedIndex % 2 == 0 ? digit : (((digit * 2 - 1) % 9) + 1))
      }
      return checkSum % 10 == 0
   }
   
   public func number(from cardNumber: String) -> String {
      var formattedCardNumber = clearNumber(from: cardNumber)
      let length = formattedCardNumber.count
      if length > maxLength {
         let index = formattedCardNumber.index(formattedCardNumber.startIndex, offsetBy: maxLength)
         formattedCardNumber = String(formattedCardNumber.prefix(upTo: index))
      }
      
      let format = cardFormat(for: cardBrand(from: formattedCardNumber))
      if length > 4 {
         formattedCardNumber = formattedCardNumber.insert(" ", index: 4)
      }
      if format == .de456 {
         if length > 9 {
            formattedCardNumber = formattedCardNumber.insert(" ", index: 10)
         }
         if length > 15 {
            formattedCardNumber = formattedCardNumber.insert(" ", index: 17)
         }
      }
      if format == .de465 {
         if length > 10 {
            formattedCardNumber = formattedCardNumber.insert(" ", index: 11)
         }
         if length > 15 {
            formattedCardNumber = formattedCardNumber.insert(" ", index: 17)
         }
      }
      if format == .de4444 {
         if length > 8 {
            formattedCardNumber = formattedCardNumber.insert(" ", index: 9)
         }
         if length > 12 {
            formattedCardNumber = formattedCardNumber.insert(" ", index: 14)
         }
         if length > 16 {
            formattedCardNumber = formattedCardNumber.insert(" ", index: 19)
         }
      }
      
      return formattedCardNumber
   }
}

private extension String {
   
   func hasPrefix(_ prefixes: [String]) -> Bool {
      for prefix in prefixes {
         if hasPrefix(prefix) {
            return true
         }
      }
      return false
   }
   
   func insert(_ string: String, index: Int) -> String {
      return String(prefix(index)) + string + String(suffix(count - index))
   }
}
