//
//  RecipeSearchTableViewController.swift
//  FoHo
//
//  Created by Brittney Ryn on 4/8/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//
import UIKit
import Alamofire

class RecipeSearchTableViewController: UITableViewController, UISearchBarDelegate  {
    let appID = "42432972"
    let appKey = "ec024a2414433825635ad1d304916ee2"
    let query = "buddha+bowl"
    var recipes: Recipes?
    var clickedRecipe: Int?
    var counter: Int = 0
    
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
    
    func checkCounter(prev: Int, current: Int){
        if prev > current + 1{
            counter = prev - 2
        }
        else if current > prev + 1{
            counter = current + 2
        }
       else{
            counter = current
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwoRecipes", for: indexPath) as! RecipeSearchTableViewCell
        if recipes != nil {
            checkCounter(prev: counter, current: indexPath.row)
            cell.setRecipes(recipe1: (recipes?.at(counter))!,
                            recipe2:(recipes?.at(counter + 1))!)
            cell.leftButton()?.removeTarget(nil, action: nil, for: .allEvents)
            cell.leftButton()?.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
           cell.rightButton()?.removeTarget(nil, action: nil, for: .allEvents)
            cell.rightButton()?.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
            cell.leftButton()?.tag = counter
            cell.rightButton()?.tag = counter + 1
            //counter = indexPath.row + 1
            //let customIndexPath = NSIndexPath(row: indexPath.row + 1, section: indexPath.section)
            //let routine = NSFetchedResultsController.objectAtIndexPath(customIndexPath) as! SavedRoutines
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
    
    
}


extension RecipeSearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
