
import Foundation


class CategoryRequest: BaseRequest {
    
        func getCategories(functionOK: @escaping ([CategoryModel]) -> Void){
            
            let url = URL(string: CATEGORY_REQUEST_URL)!
            
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                
                guard let data = data else {
                    return
                }
                                
                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Dictionary<String,Any>] {
                        let categories = CategoryModel.mappingFromArray(json)

                        functionOK(categories)
                        
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }

            task.resume()
        }
        
        
    }
