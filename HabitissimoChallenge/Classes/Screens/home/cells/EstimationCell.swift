//
//

import UIKit

class EstimationCell: UITableViewCell {
    
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelSubcategory: UILabel!
    
    @IBOutlet var labelPhone: UILabel!
    @IBOutlet var labelLocation: UILabel!
    
    @IBOutlet var labelEmail: UILabel!
    
    @IBOutlet var labelDescription: UILabel!
    
    static let identifier = "EstimationCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
        self.backgroundView?.backgroundColor = color4
        
        self.labelName.textColor = color2
        self.labelName.font = fontRegular(15)
        self.labelSubcategory.textColor = color2
        self.labelSubcategory.font = fontRegular(15)
        
        self.labelPhone.textColor = color2
        self.labelPhone.font = fontRegular(15)
        self.labelLocation.textColor = color2
        self.labelLocation.font = fontRegular(15)
        
        self.labelEmail.textColor = color2
        self.labelEmail.font = fontRegular(15)
        
        self.labelDescription.textColor = color2
        self.labelDescription.font = fontItalic(12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: CONFIG METHODS
    func config(model: EstimationModel){
        labelName.text = model.name
        labelSubcategory.text = model.subcategory
        labelEmail.text = model.mail
        labelDescription.text = model.description
    }
}
