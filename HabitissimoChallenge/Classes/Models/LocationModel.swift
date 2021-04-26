
import Foundation


class LocationModel: Decodable
{
    var id: Int = 0
    var name: String = ""
    var zip: String = ""


    static func mapping(_ dicto: Dictionary<String, Any>) -> LocationModel
    {
        let model = LocationModel()
        
        model.id = dicto["id"] as? Int ?? 0
        model.name = dicto["name"] as? String ?? ""
        model.zip = dicto["zip"] as? String ?? ""
        
        return model
    }
    
    static func mappingFromArray(_ response: [Dictionary<String,Any>]) -> [LocationModel]
    {
        var array = [LocationModel]()
        
        for dicto in response
        {
           array.append(LocationModel.mapping(dicto))
        }
        
        return array
    }
}
