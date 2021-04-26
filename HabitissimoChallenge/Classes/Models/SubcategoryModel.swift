
import Foundation

class SubcategoryModel: Decodable
{
    var id: String = ""
    var name: String = ""
    var icon: String = ""


    static func mapping(_ dicto: Dictionary<String, Any>) -> SubcategoryModel
    {
        let model = SubcategoryModel()
        
        model.id = dicto["id"] as? String ?? ""
        model.name = dicto["name"] as? String ?? ""
        model.icon = dicto["icon"] as? String ?? ""
        
        return model
    }
    
    static func mappingFromArray(_ response: [Dictionary<String,Any>]) -> [SubcategoryModel]
    {
        var array = [SubcategoryModel]()
        
        for dicto in response
        {
           array.append(SubcategoryModel.mapping(dicto))
        }
        
        return array
    }
}
