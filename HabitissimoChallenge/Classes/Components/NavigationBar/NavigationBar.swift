//
//  
//  
//
//
//
//

import UIKit

enum ButtonType: String
{
    case none
    case menu = "menu"
    case back = "back"
    case logout = "logout"
    case search = "lupa"
}

class NavigationBar: UIView
{
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonRight: UIButton!
    
    var typeLeft: ButtonType!

    
    // MARK: View lifecycle
    override func awakeFromNib()
    {
        self.backgroundColor = color1
        
//        labelTitle.font = font500Regular(14)
        labelTitle.textColor = color0
    }
    
    func config(delegate: AnyObject, selectorLeft: Selector, selectorRight: Selector)
    {
        buttonLeft.removeTarget(nil, action: nil, for: UIControl.Event.allEvents)
        buttonLeft.addTarget(delegate, action: selectorLeft, for: UIControl.Event.touchUpInside)
        
        buttonRight.removeTarget(nil, action: nil, for: UIControl.Event.allEvents)
        buttonRight.addTarget(delegate, action: selectorRight, for: UIControl.Event.touchUpInside)
    }
    
    func config(text: String, typeLeft: ButtonType, typeRight: ButtonType = .none)
    {
        self.typeLeft = typeLeft
    
        labelTitle.text = text
        
        selectImage(button: buttonLeft, buttonType: typeLeft)
        selectImage(button: buttonRight, buttonType: typeRight)
    }

    func selectImage(button: UIButton, buttonType: ButtonType)
    {
        button.isUserInteractionEnabled = true
        
        if buttonType == .none
        {
            button.setImage(nil, for: UIControl.State.normal)
            button.isUserInteractionEnabled = false
            
            return
        }
        
        let nameImg = buttonType.rawValue
        button.setImage(UIImage(named: "bt_\(nameImg)_topbar_off.png"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "bt_\(nameImg)_topbar_on.png"), for: UIControl.State.highlighted)
        button.setImage(UIImage(named: "bt_\(nameImg)_topbar_on.png"), for: UIControl.State.selected)
    }
}
