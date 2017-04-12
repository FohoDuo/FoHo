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
    init(dataSource: [AnyObject]) {
        recipes = dataSource
        super.init()
    }
    
    //returns the number of recipes collected
    func numRecipes() -> Int {
        return recipes.count
    }
    
    //returns a specific recipe from the collection
    func recipeAt(_ index:Int) -> RecipeSearchModel {
        let recipe = RecipeSearchModel(recipe: recipes[index])
        return recipe
    }

}
