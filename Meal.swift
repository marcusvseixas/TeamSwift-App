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

    init?(name : String, photo : UIImage){
        
        self.name  = name
        self.photo = photo
        
        if name.isEmpty{
            return nil
            
        }
        
    }
}