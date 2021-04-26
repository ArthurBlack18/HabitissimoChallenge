

import Foundation


class LocationRequest: BaseRequest {
    
        func getLocations(functionOK: @escaping ([LocationModel]) -> Void){
            
            let url = URL(string: LOCATION_REQUEST_URL)!
            
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                
                guard let data = data else {
                    return
                }
                                
                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Dictionary<String,Any>] {
                        let locations = LocationModel.mappingFromArray(json)

                        functionOK(locations)
                        
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }

            task.resume()
        }
        
        
    }
    
    
