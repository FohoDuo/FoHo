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
    
    //gets time needed to total time
    func totalTime() -> String? {
        //print(recipe["totalTime"])
        if let time = recipe["totalTime"] {
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
    
    func webUrl() -> String? {
        if let dict = recipe["source"] {
            if let dictionary = dict as? Dictionary<String, AnyObject> {
                return dictionary["sourceRecipeUrl"] as? String
            }
        }
        return nil
    }
    
    //Looks through the available images, and returns the largest image available
    func recipeImage() -> UIImage {
        if let arr = recipe["images"] {
            if let array = arr as? [Dictionary<String, AnyObject>] {
                if let uri = array[0]["hostedLargeUrl"]{
                    print(uri)
                    if let url = URL(string: uri as! String),
                        let data = try? Data(contentsOf: url),
                        let image = UIImage(data: data) {
                        return image
                    }
                }
                else if let uri = array[0]["hostedMediumUrl"] {
                    if let url = URL(string: uri as! String),
                        let data = try? Data(contentsOf: url),
                        let image = UIImage(data: data) {
                        return image
                    }
                }
                else if let uri = array[0]["hostedSmallUrl"] {
                    if let url = URL(string: uri as! String),
                        let data = try? Data(contentsOf: url),
                        let image = UIImage(data: data) {
                        return image
                    }
                }
            }
        }
        
        //return some hard-coded thing if there isnt an image
        return UIImage(named: "heart.png")!
    }
    
    //returns the uri to the image used
    func recipeUri() -> String{
        if let arr = recipe["images"] {
            if let array = arr as? [Dictionary<String, AnyObject>] {
                if let uri = array[0]["hostedLargeUrl"]{
                    return uri as! String
                }
                else if let uri = array[0]["hostedMediumUrl"] {
                    return uri as! String
                }
                else if let uri = array[0]["hostedSmallUrl"] {
                    return uri as! String
                }
            }
        }
        return "heart.png"
    }
}



