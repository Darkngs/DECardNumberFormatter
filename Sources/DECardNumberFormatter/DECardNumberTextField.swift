import UIKit

public class DECardNumberTextField: UITextField {
   
   private var shouldFormatNumber = true
   
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
      if shouldFormatNumber {
         let formattedText = cardNumberFormatter.number(from: textField.text ?? "")
         if !formattedText.isEmpty {
            textField.text = formattedText
         }
      } else if textField.text?.isEmpty == true {
         shouldFormatNumber = true
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
      shouldFormatNumber = false
      
      guard let text = textField.text else {
         return
      }
      
      if text.isNumberOrEmpty() {
         shouldFormatNumber = true
      }
   }
   
   public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      guard string.isNumberOrEmpty() else {
         shouldFormatNumber = false
         return false
      }
      
      shouldFormatNumber = true
      
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
