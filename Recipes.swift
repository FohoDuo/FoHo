//
//  Recipes.swift
//  FoHo
//
//  Created by Scott Williams on 4/12/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit

//container class managing a collection of RecipeSearchModels
class Recipes: NSObject {
    var recipes: [AnyObject]
    
    //constructor for container
    init(dataSource: Any) {
        
        //initialize to empty array to make super.init() happy just in case the if tests fail
        recipes = []
        
        //Change the object of type any to a dictionary since thats how AlamoFire returns JSON
        if let dictionary = dataSource as? Dictionary<String, AnyObject> {
            
            //parse the matches block from the dictionary
            if let matches = dictionary["matches"] {
                recipes = matches as! [AnyObject]
            }
        }
        super.init()
    }
    
    //returns the number of recipes collected
    func numRecipes() -> Int {
        return recipes.count
    }
    
    //returns a specific recipe from the collection
    func at(_ index:Int) -> RecipeSearchModel {
        let recipe = RecipeSearchModel(recipe: recipes[index])
        return recipe
    }

}
