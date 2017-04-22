//
//  RecipeSearchTableViewController.swift
//  FoHo
//
//  Created by Brittney Ryn on 4/8/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//
import UIKit
import Alamofire

class RecipeSearchTableViewController: UITableViewController {
    let appID = "42432972"
    let appKey = "ec024a2414433825635ad1d304916ee2"
    let query = "buddha+bowl"
    var recipes: Recipes?
    var clickedRecipe: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
                self.tableView?.reloadData()
                
                //Populate our recipes instance with the data from the API call
                self.recipes = Recipes(dataSource: JSON)
                self.tableView?.reloadData()
            }
        }
        self.tableView?.reloadData()
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
        //else just give it a default value of 1
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwoRecipes", for: indexPath) as! RecipeSearchTableViewCell
        if recipes != nil {
            cell.setRecipes(recipe1: (recipes?.at(indexPath.row))!,
                            recipe2:(recipes?.at(indexPath.row + 1))!)
            cell.leftButton()?.removeTarget(nil, action: nil, for: .allEvents)
            cell.leftButton()?.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
           cell.rightButton()?.removeTarget(nil, action: nil, for: .allEvents)
            cell.rightButton()?.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
            cell.leftButton()?.tag = indexPath.row
            cell.rightButton()?.tag = indexPath.row + 1
           // cell.leftButton().
            
            
        }
        else{
            print("Waiting")
        }
        
        cell.backgroundColor = UIColor.purple

        // Configure the cell...
        return cell
    }
    
    func buttonAction(sender: UIButton){
        print("In action")
        //if let button = sender as! UIButton{
       // clickedButton = sender as! UIButton
        clickedRecipe = sender.tag
       performSegue(withIdentifier: "leftRecipeSegue", sender: clickedRecipe)
        
        //}
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RecipeDataViewController
        vc.setRecipeID(id: recipes?.at((clickedRecipe)!).recipeID())
        
    }
    
    
}
