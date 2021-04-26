//
//
//  
//
//
//
//

import UIKit

class SplashController: UIViewController
{
    @IBOutlet var BGImageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    var finished = true

    
    // MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        BGImageView.backgroundColor = color12
        labelTitle.textColor = color1
        labelTitle.font = fontBold(25)
        labelTitle.text = NSLocalizedString("Habitissimo: Tu casa, mejor", comment: "")

        delay(2.3, function: goController)
    }
    
    func animateText()
    {
        UIView.animate(withDuration: 0.65, animations: {
            self.labelTitle.alpha = 0
        },
        completion: { finished
        in
            self.labelTitle.text = NSLocalizedString("Compre com confiança", comment: "")
            
            UIView.animate(withDuration: 0.65, animations: {
                self.labelTitle.alpha = 1
            })
        })
        
        
    }
    
    
    func goController()
    {
        if !finished
        {
            finished = true
            return
        }
        
        let vc = HomeViewController()
        navigationController?.pushViewControllerRemovingAll(vc, animated: true)
    }
    
    
    // MARK: Request Methods

}
