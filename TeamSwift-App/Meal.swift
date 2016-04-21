//
//  Meal.swift
//  TeamSwift-App
//
//  Created by Sam Wylock on 2/17/16.
//
//

import UIKit

class Meal: NSObject, NSCoding{
    
    // Mark: Properties
    
    var name : String

    var photo : UIImage?
    
    var desc : String
    
    //Mark: Types
    
    struct PropertyKey{
        static let nameKey = "name"
        
        static let photoKey = "photo"
        
        static let descKey = "desc"
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(desc, forKey: PropertyKey.descKey)
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")

    required convenience init?(coder aDecoder: NSCoder) {
    
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let desc = aDecoder.decodeObjectForKey(PropertyKey.descKey) as! String
        
        self.init(name: name, photo: photo, desc: desc)
        
    }
    
    init?(name : String, photo : UIImage?, desc : String){
        
        self.name  = name
        self.photo = photo
        self.desc = desc
        
        super.init()
        
        if name.isEmpty || desc.isEmpty{
            return nil
            
        }
        
    }
}