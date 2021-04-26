//
//  TCPickerViewThemeType.swift
//  Pods-TCPickerViewExample
//
//  Created by Taras Chernyshenko on 6/13/18.
//

import UIKit

public protocol TCPickerViewThemeType {
    var doneText: String { get }
    var closeText: String { get }
    
    var backgroundColor: UIColor { get }
    var titleColor: UIColor { get }
    var doneTextColor: UIColor { get }
    var closeTextColor: UIColor { get }
    var headerBackgroundColor: UIColor { get }
    var doneBackgroundColor: UIColor { get }
    var closeBackgroundColor: UIColor { get }
    var separatorColor: UIColor { get }
    
    var buttonsFont: UIFont { get }
    var titleFont: UIFont { get }
    
    var rowHeight: CGFloat { get }
    var headerHeight: CGFloat { get }
    var cornerRadius: CGFloat { get }
    
    var searchColor: UIColor {  get }
    init()
}

public final class TCPickerViewDefaultTheme: TCPickerViewThemeType {
    public required init() {}
}

extension TCPickerViewThemeType {
    public var doneText: String {
        return "Aceptar"
    }
    
    public var closeText: String {
        return "Cancelar"
    }
    
    public var backgroundColor: UIColor {
        return color6
    }
    
    public var titleColor: UIColor {
        return color6
    }
    
    public var doneTextColor: UIColor {
        return color6
    }
    
    public var closeTextColor: UIColor {
        return color6
    }
    
    public var headerBackgroundColor: UIColor {
        return color1
    }
    
    public var doneBackgroundColor: UIColor {
        return color1
    }
    
    public var closeBackgroundColor: UIColor {
        return color3
    }
    
    public var separatorColor: UIColor {
        return color3
    }
    
    public var buttonsFont: UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
    
    public var titleFont: UIFont{
        return UIFont.boldSystemFont(ofSize: 18)
    }
    
    public var rowHeight: CGFloat {
        return 50
    }
    
    public var headerHeight: CGFloat {
        return 60
    }
    
    public var cornerRadius: CGFloat {
        return 15.0
    }
    
    public var searchColor: UIColor {
        return .black
    }
}
