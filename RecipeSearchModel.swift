//
//  RecipeSearchModel.swift
//  FoHo
//
//  Created by Scott Williams on 4/12/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit

//Object for holding idividual search results for display in a list view
class RecipeSearchModel: NSObject {
    
    //dictionary of objects obtained from JSON
    let recipe: AnyObject
    
    //constructor
    init(recipe: AnyObject) {
        self.recipe = recipe
        super.init()
    }
    
    //gets the recipe name from the dictionary
    func recipeName() -> String? {
        if let name = recipe["recipeName"] {
            return name as? String
        }
        return nil
    }
    
    //returns the id key for the recipe
    func recipeID() -> String? {
        if let id = recipe["id"] {
            return id as? String
        }
        return nil
    }
    
    //returns the rating given by yummily
    func rating() -> Int? {
        if let rating = recipe["rating"] {
            return rating as? Int
        }
        return nil
    }
    
    //gets the recipe image
    func recipeImage() -> UIImage? {
        if let urls = (recipe["smallImageUrls"] as! NSArray) as Array? {
            let uriString = urls[0]
            let uri = uriString as! String
            //return uri
            if let url = URL(string: uri),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                image.stretchableImage(withLeftCapWidth: 186, topCapHeight: 155)
                return image
            }
        }
        return UIImage(contentsOfFile: "forkknife")
    }
    
}
