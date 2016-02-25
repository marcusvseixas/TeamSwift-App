//
//  Meal.swift
//  TeamSwift-App
//
//  Created by Sam Wylock on 2/17/16.
//
//

import UIKit

class Meal{
    
    // Mark: Properties
    
    var name : String

    var photo : UIImage?
    
    var desc : String

    init?(name : String, photo : UIImage, desc : String){
        
        self.name  = name
        self.photo = photo
        self.desc = desc
        
        if name.isEmpty || desc.isEmpty{
            return nil
            
        }
        
    }
}