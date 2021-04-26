import Foundation
import UIKit

class AppButton: UIButton
{
    var fontTitle: UIFont!
    var colorTitle: UIColor!
    var colorTitleOn: UIColor!
    var colorBackground: UIColor!
    var colorBackgroundOn: UIColor!
    var colorBorder: UIColor!
    var colorBorderOn: UIColor!
    var cornerRadius: CGFloat!
    
    
    // MARK: Config Methods
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        
        configAttributes()
        

//        self.addTarget(self, action: #selector(highlight), for: .touchDown)
//        self.addTarget(self, action: #selector(unhighlight), for: .touchUpInside)
//        self.addTarget(self, action: #selector(unhighlight), for: .touchDragOutside)
                
        config()
    }
    
    func config(fontTitle: UIFont? = nil, colorTitle: UIColor? = nil, colorTitleOn: UIColor? = nil, colorBackground: UIColor? = nil, colorBackgroundOn: UIColor? = nil, colorBorder: UIColor? = nil, colorBorderOn: UIColor? = nil, cornerRadius: CGFloat? = nil)
    {
        configAttributes()
        
        if let _ = fontTitle { self.fontTitle = fontTitle! }
        if let _ = colorTitle { self.colorTitle = colorTitle! }
        if let _ = colorTitleOn { self.colorTitleOn = colorTitleOn! }
        if let _ = colorBackground { self.colorBackground = colorBackground! }
        if let _ = colorBackgroundOn { self.colorBackgroundOn = colorBackgroundOn! }
        if let _ = colorBorder { self.colorBorder = colorBorder! }
        if let _ = colorBorderOn { self.colorBorderOn = colorBorderOn! }
        if let _ = cornerRadius { self.cornerRadius = cornerRadius! }
        
        config()
    }
    
    func configAttributes()
    {
        fontTitle = fontRegular(19)
        colorTitle = color0
        colorTitleOn = color0
        colorBackground = color2
        colorBackgroundOn = color6
        colorBorder = colorClear
        colorBorderOn = colorClear
        cornerRadius = 0

    }
    
    private func config()
    {
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .bottom

        self.titleLabel?.font = fontTitle
        
        self.setTitleColor(colorTitle, for: .normal)
        self.setTitleColor(colorTitleOn, for: .highlighted)
        self.setTitleColor(colorTitleOn, for: .selected)
        
        self.layer.cornerRadius = cornerRadius
        
        unhighlight()
    }
    
    
    // MARK: Highlight Methods
    override var isSelected: Bool
    {
        willSet(newValue)
        {
            if newValue { highlight() }
            else { unhighlight() }
        }
    }
    
    func unhighlight()
    {
        self.backgroundColor = colorBackground
//        self.setBorder(color: colorBorder, width: 1)
    }
    
    func highlight()
    {
        self.backgroundColor = colorBackgroundOn
//        self.setBorder(color: colorBorderOn, width: 1)
    }
}

class DarkerGreenButton: AppButton{
    
    override func configAttributes()
    {
        
        fontTitle = fontBold(19)
        colorTitle = color0
        colorTitleOn = color0
        colorBackground = color13
        colorBackgroundOn = color9
        colorBorder = colorClear
        colorBorderOn = colorClear
        cornerRadius = 0
    }
    
}


class OrangeButton: AppButton{
    
    override func configAttributes()
    {
        
        fontTitle = fontRegular(19)
        colorTitle = color0
        colorTitleOn = color0
        colorBackground = color1
        colorBackgroundOn = color7
        colorBorder = colorClear
        colorBorderOn = colorClear
        cornerRadius = 9
    }
    
}

