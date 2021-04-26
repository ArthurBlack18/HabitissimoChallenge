

import Foundation


class EstimationModel: Decodable
{
    var name: String = ""
    var phone: String = ""
    var mail: String = ""
    var location: LocationModel!
    var description: String = ""
    var subcategory: String = ""

    static func mapping(_ dicto: Dictionary<String, Any>) -> EstimationModel
    {
        let model = EstimationModel()
        
        model.name = dicto["name"] as? String ?? ""
        model.phone = dicto["phone"] as? String ?? ""
        model.mail = dicto["mail"] as? String ?? ""
        
        return model
    }
    
    static func mappingFromArray(_ response: [Dictionary<String,Any>]) -> [EstimationModel]
    {
        var array = [EstimationModel]()
        
        for dicto in response
        {
           array.append(EstimationModel.mapping(dicto))
        }
        
        return array
    }
}
