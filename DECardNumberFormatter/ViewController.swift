import UIKit

class ViewController: UIViewController {
   
   @IBOutlet weak var textField: DECardNumberTextField?
   
   // MARK: -
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      textField?.setup()
      performCardNumberFormatterTest()
   }
   
   // MARK: -
   
   private func performCardNumberFormatterTest() {
      let cardNumberFormatter = DECardNumberFormatter()
      
      // AmEx
      print(cardNumberFormatter.number(from: "34 12 123456 12345"))
      print(cardNumberFormatter.number(from: "37 12 123456 12345"))
      
      // Diners Club
      var cardNumber = "300 1 123456 1234"
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
      
      // Visa
      cardNumber = "4111111111111111"
      print(cardNumberFormatter.number(from: cardNumber))
      if cardNumberFormatter.isValidLuhnCardNumber(cardNumber) {
         print("Card number: \(cardNumber) - is valid!")
      }
   }
}
