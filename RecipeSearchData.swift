//
//  RecipeSearchData.swift
//  FoHo
//
//  Created by Scott Williams on 4/12/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit

//Object containing specific information for a selected recipe
class RecipeSearchData: NSObject {
    
    var recipe: AnyObject
    
    
    
    //constructor
    init(recipeData: Any) {
        
        //make constructor happy
        recipe = recipeData as AnyObject
        
        //probably redundent but eh...
        if let dictionary = recipeData as? Dictionary<String, AnyObject> {
            recipe = dictionary as! AnyObject
        }
        
        super.init()
    }
    
    //gets the name of the recipe
    func recipeName() -> String? {
        if let name = recipe["name"] {
            return name as? String
        }
        return nil
    }
    
    //gets time needed to prep
    func prepTime() -> String? {
        if let time = recipe["prepTime"] {
            return time as? String
        }
        return nil
    }
    
    //gets cook time
    func cookTime() -> String? {
        if let time = recipe["cookTime"] {
            return time as? String
        }
        return nil
    }
    
    //returns number of serving recipe makes
    func numberOfServings() -> Int? {
        if let number = recipe["numberOfServings"] {
            return number as? Int
        }
        return nil
    }
    
    //gets 1-5 star rating
    func rating() -> Int? {
        if let rate = recipe["rating"] {
            return rate as? Int
        }
        return nil
    }
    
    //returns an array of ingredients
    ///TO-DO test if this returns corrctly
    func ingredients() -> [String] {
        if let list = recipe["ingredientLines"] {
            return (list as? [String])!
        }
        return [] //return an empty array
    }
    
    
//more complex json thingies
    //nutritionEstimates looks like a dictionary of dictionaries, should
    //be interesting to parse...
    
    //source
    
    //same with imagse

}



