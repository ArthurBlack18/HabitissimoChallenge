

import UIKit
import MapKit
import SwiftUI


let iPhone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
let iPad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad

func delayedCall(_ delayInSeconds: Double = 0.0, closure: @escaping () -> Void) {
    let delayInMilliSeconds = Int(delayInSeconds * 1_000)
    let nanoseconds = DispatchTime.now() + DispatchTimeInterval.milliseconds(delayInMilliSeconds)
    DispatchQueue.main.asyncAfter(deadline: nanoseconds, execute: closure)
}

extension UINavigationController
{
    func pushViewControllerRemovingSelf(_ controller: UIViewController, animated: Bool)
    {
        var arrayControllers = self.viewControllers
        arrayControllers[arrayControllers.count-1] = controller
        self.setViewControllers(arrayControllers, animated: animated)
    }
    
    func pushViewControllerRemovingAll(_ controller: UIViewController, animated: Bool)
    {
        self.setViewControllers([controller], animated: animated)
    }
}

//Para ocultar el teclado en los SwiftUI forms
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


extension UIViewController {
    
#if os(iOS)

//Para ocultar el teclado tocando en cualquier parte de los ViewControllers. Necesario llamar a esta función en el viewDidLoad()
open func hideKeyboardWhenTappedAround(cancelTouches: Bool = false) {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = cancelTouches
    view.addGestureRecognizer(tap)
}

#endif
    
    
    // Dismisses keyboard
    @objc open func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func validateFields(_ objects: AnyObject...) -> Bool
    {
        var validate = true
        for object in objects {
            if let field = object as? CheckInterface, !field.validate() { validate = false }
        }
        
        return validate
    }
    
}


// MARK: Métodos
func size(_ iphone: CGFloat, ipad: CGFloat) -> CGFloat
{
    if iPad { return ipad }
    else
    {
        let widthScreen = UIScreen.main.bounds.size.width
        let widthReference: CGFloat = 375
        return (iphone * widthScreen)/widthReference
    }
}



func delay(_ delay: Double, function: @escaping ()->())
{
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: function)
}
