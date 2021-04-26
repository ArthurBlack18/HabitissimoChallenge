//
//
//

import Foundation
import CoreData


extension Estimation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Estimation> {
        return NSFetchRequest<Estimation>(entityName: "Estimation")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var mail: String?
    @NSManaged public var location: String?
    @NSManaged public var descript: String?
    @NSManaged public var category: String?

}
