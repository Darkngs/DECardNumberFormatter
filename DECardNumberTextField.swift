import UIKit

public class DECardNumberTextField: UITextField {
   
   private var shouldFormatPhoneNumber: Bool = true
   
   private weak var hiddenDelegate: UITextFieldDelegate?
   
   public var cardNumberFormatter = DECardNumberFormatter()
   
   override public var delegate: UITextFieldDelegate? {
      didSet {
         if delegate?.isKind(of: DECardNumberTextField.self) == false {
            hiddenDelegate = delegate
            delegate = self
         }
      }
   }
   
   // MARK: -
   
   @objc private func textFieldEditingChanged(_ textField: UITextField) {
      if shouldFormatPhoneNumber {
         let formattedText = cardNumberFormatter.number(from: textField.text ?? "")
         if !formattedText.isEmpty {
            textField.text = formattedText
         }
      } else if textField.text?.isEmpty == true {
         shouldFormatPhoneNumber = true
      }
   }
   
   // MARK: -
   
   public func setup() {
      if delegate == nil {
         delegate = self
      }
      addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
   }
}

extension DECardNumberTextField: UITextFieldDelegate {
   
   public func textFieldDidBeginEditing(_ textField: UITextField) {
      shouldFormatPhoneNumber = false
      
      guard let text = textField.text else {
         return
      }
      
      if text.isNumberOrEmpty() {
         shouldFormatPhoneNumber = true
      }
   }
   
   public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      if shouldFormatPhoneNumber {
         if !string.isNumberOrEmpty() {
            shouldFormatPhoneNumber = false
         }
      }
      
      return true
   }
   
   public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      return hiddenDelegate?.textFieldShouldReturn?(textField) ?? false
   }
}

private extension String {
   
   func isNumber() -> Bool {
      if Int(self) == nil {
         return false
      }
      
      return true
   }
   
   func isNumberOrEmpty() -> Bool {
      if isEmpty {
         return true
      }
      
      return isNumber()
   }
}
