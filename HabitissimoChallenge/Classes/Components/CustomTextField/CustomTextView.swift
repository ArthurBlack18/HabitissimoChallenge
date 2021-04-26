//
//

import Foundation
import UIKit


class CustomTextView: UITextView, UITextViewDelegate {
    
    var insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    
    var needed: Bool = false
    var max: Int = 0
    var min: Int = 0
    
    var placeholder = ""
    
    // Constantes para configurar
    var colorOff: UIColor!
    var colorOn: UIColor!
    

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
   
    
    // MARK: Config Methods
    func configAttributes() {
        self.backgroundColor = color0
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 1
        self.layer.borderColor = color1.cgColor
        self.textColor = color3

        font = fontRegular(15)

         colorOff = color5
         colorOn = color4
    }
    
    var value: String
    {
        if self.text == placeholder {
            return ""
        }
        else {
            return self.text ?? ""
        }
    }

    func config(placeholder: String, needed: Bool, minCharacters: Int = 0)
    {
        min = minCharacters
        
        self.placeholder = placeholder
        self.text = placeholder
        self.needed = needed
        self.min = minCharacters

        configAttributes()
                   
        self.textColor = colorOff
        self.textAlignment = .left
        self.delegate = self
        self.font = font
        self.text = placeholder
    }
    
    
    // MARK: Methods
    func validate() -> Bool
    {
        if needed && value == "" { return false }
            
        else if value.count < min { return false }
        
        return true
    }
    

    // MARK: TextView Delegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textColor == color5 && self.isFirstResponder {
            self.text = nil
            self.textColor = color4
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.text.isEmpty || self.text == "" {
            self.textColor = color5
            self.text = self.placeholder
        }
    }
    
    
}
