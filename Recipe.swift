//
//  Recipe.swift
//  FoHo
//
//  Created by Scott Williams on 4/12/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit


//Object containing specific information for a selected recipe
class Recipe: NSObject {

    var recipe: AnyObject
    
    init(recipe: AnyObject) {
        self.recipe = recipe
        super.init()
    }
    
    //nutritionEstimates looks like a dictionary of dictionaries, should 
    //be interesting to parse...
    
    
}
