//
//

import UIKit

enum FieldType
{
    case `default`
    case phone
    case number
    case password
    case email
    case web
    case longText
}

class CustomTextField: UITextField, UITextFieldDelegate {
    
    var insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    
    var needed: Bool = false
    var max: Int = 0
    var min: Int = 0
    var security: Bool = false
    
    var fieldType: FieldType!
    
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
        self.contentVerticalAlignment = .bottom


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

    func config(fieldType: FieldType, placeholder: String, needed: Bool, minCharacters: Int = 0)
    {
        min = minCharacters
        
        self.fieldType = fieldType
        self.placeholder = placeholder
        self.needed = needed
        self.min = minCharacters

        configAttributes()
                   
        
        switch(fieldType)
        {
            case .phone:
                self.keyboardType = .phonePad
            case .number:
                self.keyboardType = .decimalPad
            case .password:
                security = true
            case .email:
                self.keyboardType = .emailAddress
                self.autocapitalizationType = .none
                self.autocorrectionType = .no
            case .web:
                self.keyboardType = .webSearch
                self.autocapitalizationType = .none
                self.autocorrectionType = .no
            default:
                break
        }
       
        self.textColor = colorOff
        self.textAlignment = .left
        self.delegate = self
        self.font = font
        self.text = placeholder
    }
    
    
    // MARK: Methods
    func validate() -> Bool
    {
        var returned = true
        if needed && value == "" { returned = false }
        else if fieldType == .email
        {
            if value == "" { returned = needed ? false : true }
            else { returned = isValidEmail(self.value) }
        }
        else if fieldType == .web
        {
            if value == "" { returned = needed ? false : true }
            else { returned = isValidWeb(self.value) }
        }
        else if value.count < min { returned = false }

        return returned
    }
    
    
//TODO: if a field is incomplete, show it in red color
//func showErrorDisclaimer(){
//
//    setBorder(color: color7, width: 2)
//}
    
    
    
    

    // MARK: TextField Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.text == placeholder
        {
            textField.text = ""
            textField.textColor = colorOn
            textField.isSecureTextEntry = security
        }
        
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if textField.text == ""
        {
            textField.text = placeholder
            textField.textColor = colorOff
            textField.isSecureTextEntry = false
        }
        
        return true
    }

    
    
    // MARK: Utils Methods
    func isValidEmail(_ email: String) -> Bool
    {
        let laxString = ".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", laxString)
        return emailTest.evaluate(with: email)
    }
    
    func isValidWeb(_ web: String) -> Bool
    {
        if let url = URL(string: web), let url2 = URL(string: "http:\(web)") {
            return UIApplication.shared.canOpenURL(url) || UIApplication.shared.canOpenURL(url2)
        }
        
        return false
    }
}
