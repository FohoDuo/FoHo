//
//  RecipeSearchCollectionViewController.swift
//  FoHo
//
//  Created by Brittney Ryn on 4/12/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "RecipeCell"

class RecipeSearchCollectionViewController: UICollectionViewController{
    let appID = "42432972"
    let appKey = "ec024a2414433825635ad1d304916ee2"
    let query = "buddha+bowl"
    var recipes: Recipes?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(RecipeSearchCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
 

        // Do any additional setup after loading the view.
        
        //construct the URL used to call
        let url = "http://api.yummly.com/v1/api/recipes?_app_id=\(appID)&_app_key=\(appKey)&q=\(query)&maxResult=50&start=50"
        
        //Magically calls the API and gets the data
        Alamofire.request(url).responseJSON { response in
            //print(response.request)  // original URL request
            //print(response.response) // HTTP URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                //print("JSON: \(JSON)")
                
                //might need this here dunno...?
                self.collectionView?.reloadData()
                
                //Populate our recipes instance with the data from the API call
                self.recipes = Recipes(dataSource: JSON)
            }
        }

        //Needed after API call to populate images
        self.collectionView?.reloadData()
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        //if the API has returned, set the number of section to the number of recipes
        if recipes != nil {
            return (recipes?.numRecipes())!
        }
        //else just give it a default value of 1
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RecipeSearchCollectionViewCell
        
        //If the API call has gone through, populate the view with images
        if recipes != nil {
            cell.setCell(image: (recipes?.at(indexPath.row).recipeImage())!,
                            label:(recipes?.at(indexPath.row).recipeName())!)
        }
            
        //use some default image otherwise here
        else {
            cell.setCell(image: UIImage(named: "loading")!, label: "Loading...")
        }
        
        // Configure the cell
        cell.backgroundColor = UIColor.purple
    
        return cell
    }
    
    //checks which recipe was selected and passes up its ID to the next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailedRecipe" {
            let cell = sender as! RecipeSearchCollectionViewCell
            if let indexPath = collectionView?.indexPath(for: cell), let ds = recipes {
                let vc = segue.destination as! RecipeDataViewController
                vc.setRecipeID(id: ds.at(indexPath.row).recipeID())
            }
        }
    }

    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
