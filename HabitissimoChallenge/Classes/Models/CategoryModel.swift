
import Foundation

class CategoryModel: Decodable
{
    var id: String = ""
    var name: String = ""


    static func mapping(_ dicto: Dictionary<String, Any>) -> CategoryModel
    {
        let model = CategoryModel()
        
        model.id = dicto["id"] as? String ?? ""
        model.name = dicto["name"] as? String ?? ""
        
        return model
    }
    
    static func mappingFromArray(_ response: [Dictionary<String,Any>]) -> [CategoryModel]
    {
        var array = [CategoryModel]()
        
        for dicto in response
        {
           array.append(CategoryModel.mapping(dicto))
        }
        
        return array
    }
}
