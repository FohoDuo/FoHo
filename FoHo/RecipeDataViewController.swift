//
//  RecipeDataViewController.swift
//  FoHo
//
//  Created by Scott Williams on 4/14/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import Alamofire


class RecipeDataViewController: UIViewController {
    let appID = "42432972"
    let appKey = "ec024a2414433825635ad1d304916ee2"
    var recipeKey: String? //"Buddha-Bowl-1238769"
    var recipe: RecipeSearchData?
    
    @IBOutlet weak var instructionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//set recipe key here with old data
        
        
        let url = "http://api.yummly.com/v1/api/recipe/\(recipeKey!)?_app_id=\(appID)&_app_key=\(appKey)"
        print(url)
        
        //Magically calls the API and gets the data
        Alamofire.request(url).responseJSON { response in
            //print(response.request)  // original URL request
            //print(response.response) // HTTP URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                //might need this here dunno...?
                
                
                //Populate our recipes instance with the data from the API call
                self.recipe = RecipeSearchData(recipeData: JSON)
                print(self.recipe?.recipeName())
                
            }
        }
       
        //Needed after API call to populate images
        //self.collectionView?.reloadData()
        
        
        // Do any additional setup after loading the view.
    }
    
    func setRecipeID(id: String?) {
        print("passed id is: ", id)
        recipeKey = id
    }
    

    @IBAction func didTabButton(_ sender: UIButton) {
        print("YAYYAYAY")
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}