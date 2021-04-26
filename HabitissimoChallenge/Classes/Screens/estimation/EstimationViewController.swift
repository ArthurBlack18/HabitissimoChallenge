//
//

import UIKit
import CoreData

class EstimationViewController: UIViewController, TCPickerViewOutput {


    @IBOutlet var nameTextField: CustomTextField!
    @IBOutlet var mailTextField: CustomTextField!
    @IBOutlet var phoneTextField: CustomTextField!
    
    @IBOutlet var descriptionTextView: CustomTextView!
    
    @IBOutlet var labelLocation: UILabel!
    @IBOutlet var labelCategory: UILabel!
    @IBOutlet var labelSubcategory: UILabel!
    
    @IBOutlet var locationField: UILabel!
    @IBOutlet var categoryField: UILabel!
    @IBOutlet var subcategoryField: UILabel!
    
    @IBOutlet var buttonLocation: UIButton!
    
    @IBOutlet var submitButton: OrangeButton!
    @IBOutlet var buttonCategory: UIButton!
    @IBOutlet var buttonSubcategory: UIButton!
    
    
    @IBOutlet var viewSubcategory: UIView!
    
    
    var locations = [LocationModel]()
    var categories = [CategoryModel]()
    var subcategories = [SubcategoryModel]()
    
    var managedObjectContext: NSManagedObjectContext?


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = NSLocalizedString("Nuevo presupuesto", comment: "")
        
        self.viewSubcategory.isHidden = true
        
        self.hideKeyboardWhenTappedAround()
        
        LocationRequest().getLocations { (locations) in
            self.locations = locations
        }
        
        CategoryRequest().getCategories { (categories) in
            self.categories = categories
        }
        
        config()

    }
    
    func config(){
        self.nameTextField.config(fieldType: .default, placeholder: "Nombre", needed: true)
        
        self.mailTextField.config(fieldType: .email, placeholder: "Correo Electrónico", needed: true)
        
        self.phoneTextField.config(fieldType: .phone, placeholder: "Número de teléfono", needed: true)
        
        self.descriptionTextView.config(placeholder: "Escribe una descripción de lo que quieres hacer. Cuanto más detallada sea la descripción, más preciso será el presupuesto obtenido. ", needed: true)
        
        self.labelLocation.text = NSLocalizedString("Localización", comment: "")
        self.labelLocation.textColor = color4
        self.labelLocation.font = fontRegular(15)
        
        self.labelCategory.text = NSLocalizedString("Categoría", comment: "")
        self.labelCategory.textColor = color4
        self.labelCategory.font = fontRegular(15)
        
        self.labelSubcategory.text = NSLocalizedString("Subcategoría", comment: "")
        self.labelSubcategory.textColor = color4
        self.labelSubcategory.font = fontRegular(15)
        
        self.locationField.textColor = color5
        self.locationField.font = fontItalic(15)
        
        self.categoryField.textColor = color5
        self.categoryField.font = fontItalic(15)
        
        self.subcategoryField.textColor = color5
        self.subcategoryField.font = fontItalic(15)
        
        self.submitButton.setTitle(NSLocalizedString("Pedir presupuesto", comment: ""), for: .normal)
        self.submitButton.backgroundColor = color1
        self.submitButton.tintColor = color0
    }

    
    @IBAction func locationPressed(_ sender: Any) {
        
        let picker: TCPickerView = TCPickerView()
        
        picker.title = "Ubicación"
                
        let values = self.locations.map { String($0.name) + " (" + String($0.zip) + ")" }
        let pickerValues = values.map { TCPickerView.Value(title: $0) }
        picker.values = pickerValues
        picker.delegate = self
        picker.selection = .single
        picker.completion = { (selectedIndexes) in
            for i in selectedIndexes {
                print(pickerValues[i].title)
                self.locationField.text = pickerValues[i].title
            }
        }
        picker.closeAction = {
            print("Handle close action here")
        }
        picker.show()
        
    }
    
    
    @IBAction func categoryPressed(_ sender: Any) {
        
        let picker: TCPickerView = TCPickerView()
        
        picker.title = "Categorías"
                
        let values = self.categories.map { String($0.name) }
        let pickerValues = values.map { TCPickerView.Value(title: $0) }
        picker.values = pickerValues
        picker.delegate = self
        picker.selection = .single
        picker.completion = { (selectedIndexes) in
            for i in selectedIndexes {
                self.categoryField.text = pickerValues[i].title
                self.allowSubcategories(categoryIndex: i)
            }
        }
        picker.closeAction = {
            print("Handle close action here")
        }
        
        picker.show()
        
    }
    
    
    @IBAction func subcategoryPressed(_ sender: Any) {
        
        let picker: TCPickerView = TCPickerView()
        
        picker.title = "Subcategorías"
                
        let values = self.subcategories.map { String($0.name) }
        let pickerValues = values.map { TCPickerView.Value(title: $0) }
        picker.values = pickerValues
        picker.delegate = self
        picker.selection = .single
        picker.completion = { (selectedIndexes) in
            for i in selectedIndexes {
                self.subcategoryField.text = pickerValues[i].title
            }
        }
        picker.closeAction = {
            print("Handle close action here")
        }
        
        picker.show()
    }
    
    
    
    func allowSubcategories(categoryIndex: Int){
        self.viewSubcategory.isHidden = false

        
        SubcategoryRequest().getSubcategories(categoryID: self.categories[categoryIndex].id) { (subcategories) in
            self.subcategories = subcategories
        }
    }


    @IBAction func submit(_ sender: Any) {
        
        if !validateForm()
        {
            let alert = UIAlertController(title: "Atención", message: "Debes completar correctamente todos los campos", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
             })
            
            //Add OK button to a dialog message
            alert.addAction(ok)

            // Present alert to user
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        

        addEstimation()
        
        let vc = HomeViewController()
        navigationController?.pushViewControllerRemovingAll(vc, animated: true)
        
    }
    

    func validateForm() -> Bool {
        if nameTextField.validate() && phoneTextField.validate() && mailTextField.validate() && descriptionTextView.validate(){
            return true
        }
        
        return false
    }


    func pickerView(_ pickerView: TCPickerViewInput, didSelectRowAtIndex index: Int) {

    }
    
    

    
    
    
    
    func addEstimation() {
        guard let managedObjectContext = managedObjectContext else {
            fatalError("No Managed Object Context Available")
        }
        
        // Create Estimation
        let estimation = Estimation(context: managedObjectContext)

        // Populate Estimation
        estimation.name = nameTextField.text
        estimation.mail = mailTextField.text
        estimation.phone = phoneTextField.text
        estimation.descript = descriptionTextView.text
        estimation.location = locationField.text
        estimation.category = categoryField.text
        
        do {
            // Save Estimation to Persistent Store
            try managedObjectContext.save()

        } catch {
            print("Unable to Save Estimation, \(error)")
        }
    }
    
    
}
