
import Foundation


class SubcategoryRequest: BaseRequest {
    
    func getSubcategories(categoryID: String, functionOK: @escaping ([SubcategoryModel]) -> Void){
            
            let url = URL(string: CATEGORY_REQUEST_URL + "/" + categoryID)!
            
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                
                guard let data = data else {
                    return
                }
                                
                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Dictionary<String,Any>] {
                        let subcategories = SubcategoryModel.mappingFromArray(json)

                        functionOK(subcategories)
                        
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }

            task.resume()
        }
        
        
    }
