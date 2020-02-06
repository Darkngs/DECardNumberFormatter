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
      print(cardNumberFormatter.number(from: "34 12 123456 12345 1234"))
      print(cardNumberFormatter.number(from: "37 12 123456 12345 1234"))
      
      // Diners Club
      print(cardNumberFormatter.number(from: "300 1 123456 12345 1234"))
      
      // Other
      print(cardNumberFormatter.number(from: "4141 4141 4141 4141 123"))
      
      // UATP
      print(cardNumberFormatter.number(from: "1 234 12345 123456 1234"))
   }
}
