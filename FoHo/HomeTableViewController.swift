//
//  HomeTableViewController.swift
//  FoHo
//
//  Created by Scott Williams on 4/24/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import Alamofire

class HomeTableViewController: UITableViewController {
    let appID = "42432972"
    let appKey = "ec024a2414433825635ad1d304916ee2"
    let query = ""
    var recipes: Recipes?
    var clickedRecipe: Int?
    var counter: Int = 0
    
    var searchParameters: String?
    var searchActive: Bool = false
    
    
    

    var startingIndex: String = "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startingIndex = String(arc4random_uniform(1000000))
        print(startingIndex)
        apiCall()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func apiCall() {
        
        //construct the url
        let url = "http://api.yummly.com/v1/api/recipes?_app_id=\(appID)&_app_key=\(appKey)&q=&maxResult=50&start=\(startingIndex)&requirePictures=true"
        
        print(url)
        Alamofire.request(url).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                //might need this here dunno...?
                self.tableView.reloadData()
                
                //Populate our recipes instance with the data from the API call
                
                self.recipes = Recipes(dataSource: JSON)
                print(self.recipes?.numRecipes())
                self.tableView.reloadData()
            }
            else {
                print("It's dead jim")
                print(response)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if recipes != nil {
            return (recipes?.numRecipes())! / 2
        }
        //else just give it a default value of 0
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        if recipes != nil {
            counter = indexPath.row * 2
            cell.setRecipes(recipe1: (recipes?.at(counter))!,
                            recipe2:(recipes?.at(counter + 1))!)
            cell.leftButton()?.removeTarget(nil, action: nil, for: .allEvents)
            cell.leftButton()?.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
            cell.rightButton()?.removeTarget(nil, action: nil, for: .allEvents)
            cell.rightButton()?.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
            cell.leftButton()?.tag = counter
            cell.rightButton()?.tag = counter + 1
            print("\nIteration")
            print("Index:", indexPath.row)
            print("Counters:", counter, ", ", counter + 1, "\n")
            
        }
        else{
            print("Waiting")
        }
        //  let nextIndexPath:NSIndexPath = NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section)
        //cell.backgroundColor = UIColor.purple
        
        // Configure the cell...
        return cell
    }
    
    func buttonAction(sender: UIButton){
        print("In action")
        //if let button = sender as! UIButton{
        // clickedButton = sender as! UIButton
        clickedRecipe = sender.tag
        performSegue(withIdentifier: "HomeLeftButtonImage", sender: clickedRecipe)
        
        //}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RecipeDataViewController
        vc.setRecipeID(id: recipes?.at((clickedRecipe)!).recipeID())
        
    }


}
