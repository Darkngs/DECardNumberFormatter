import Foundation

public enum DECardNumberFormat {
   
   case de456
   
   case de465
   
   case de4444
}

public enum DECardNumberType {
   
   case amex
   
   case diners
   
   case other
   
   case uatp
}

public class DECardNumberFormatter {
   
   private func cardFormat(for cardType: DECardNumberType) -> DECardNumberFormat {
      var cardFormat: DECardNumberFormat = .de4444
      switch cardType {
      case .amex, .diners:
         cardFormat = .de465
      case .uatp:
         cardFormat = .de456
      default:
         break
      }
      return cardFormat
   }
   
   // MARK: -
   
   public func cardType(from cardNumber: String) -> DECardNumberType {
      if cardNumber.hasPrefix("34") || cardNumber.hasPrefix("37") {
         return .amex
      }
      if cardNumber.hasPrefix("300") ||
         cardNumber.hasPrefix("301") ||
         cardNumber.hasPrefix("302") ||
         cardNumber.hasPrefix("303") ||
         cardNumber.hasPrefix("304") ||
         cardNumber.hasPrefix("305") ||
         cardNumber.hasPrefix("309") ||
         cardNumber.hasPrefix("36") ||
         cardNumber.hasPrefix("38") ||
         cardNumber.hasPrefix("39") {
         return .diners
      }
      if cardNumber.hasPrefix("1") {
         return .uatp
      }
      return .other
   }
   
   public func clearNumber(from cardNumber: String) -> String {
      return cardNumber.replacingOccurrences(of: " ", with: "")
   }
   
   public func number(from cardNumber: String) -> String {
      var formattedCardNumber = clearNumber(from: cardNumber)
      let length = formattedCardNumber.count
      if length > 19 {
         return formattedCardNumber
      }
      
      let format = cardFormat(for: cardType(from: formattedCardNumber))
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
   
   func insert(_ string: String, index: Int) -> String {
      return String(prefix(index)) + string + String(suffix(count - index))
   }
}
