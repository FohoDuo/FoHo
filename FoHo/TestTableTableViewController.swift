//
//  TestTableTableViewController.swift
//  FoHo
//
//  Created by Scott Williams on 4/14/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import Alamofire

class TestTableTableViewController: UITableViewController, UISearchBarDelegate {
    

    //url variables

    let appID = "42432972"
    let appKey = "ec024a2414433825635ad1d304916ee2"
    let query = "buddha+bowl"
    
    var recipes: Recipes?
    var callReady: Bool = false
    
    var searchParameters: String?
    var searchActive: Bool = false
    
    //By initializing UISearchController without a searchResultsController, you are telling the search controller that you want use the same view that you’re searching to display the results. If you specify a different view controller here, that will be used to display the results instead.
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
    }
    
    
    func apiCall() {
        
        //construct the url
        let url = "http://api.yummly.com/v1/api/recipes?_app_id=\(appID)&_app_key=\(appKey)&q=\(searchParameters!)&maxResult=50&start=50"
        
        print(url)
        Alamofire.request(url).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                //might need this here dunno...?
                self.tableView.reloadData()
                
                //Populate our recipes instance with the data from the API call
                self.recipes = Recipes(dataSource: JSON)
                self.tableView.reloadData()
            }
        }
    }
    
    //delegates for searching
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //assign string here i think
        print("activated")
        
        apiCall()
        //self.viewDidLoad()
        self.tableView?.reloadData()
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.tableView?.reloadData()
    }

    func filterContentForSearchText(searchText: String, scope: String = "ALL") {
        // do something to change white spaces in the string to "+"
        //assign searchParameters the modified string
        searchParameters = searchText.replacingOccurrences(of: " ", with: "+")
        print("search text", searchParameters)
        tableView.reloadData()
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
        // #warning Incomplete implementation, return the number of items
        
        //if the API has returned, set the number of section to the number of recipes
        if recipes != nil {
            return (recipes?.numRecipes())!
        }
        //else just give it a default value of 1
        return 1
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        if segue.identifier == "toDetailedRecipe" {
            let cell = sender as! RecipeSearchCollectionViewCell
            if let indexPath = tableView?.indexPath(for: cell), let ds = recipes {
                let vc = segue.destination as! RecipeDataViewController
                vc.setRecipeID(id: ds.at(indexPath.row).recipeID())
            }
        }
         */
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("I MADE IT")
        let cell = tableView.dequeueReusableCell(withIdentifier: "TEST", for: indexPath) as! TestTableViewCell
        
        //If the API call has gone through, populate the view with images
        print("cell work")
        if recipes != nil {
            cell.setThing(name: (recipes?.at(indexPath.row).recipeName())!)
            /*
            cell.setCell(image: (recipes?.at(indexPath.row).recipeImage())!,
                         label:(recipes?.at(indexPath.row).recipeName())!)
             */
        }
            
            //use some default image otherwise here
        else {
            cell.setThing(name: "")
            /*
            cell.setCell(image: UIImage(named: "loading")!, label: "Loading...")
             */
        }
        
        // Configure the cell
        //cell.backgroundColor = UIColor.purple
        
        return cell
    }
    
    
    
    
    
/*
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...

        return cell
    }
 */
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}



extension TestTableTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}


