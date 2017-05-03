//
//  RecipeSearchTableViewController.swift
//  FoHo
//
//  Created by Brittney Ryn on 4/8/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//
import UIKit
import Alamofire
import CoreData

class RecipeSearchTableViewController: UITableViewController, UISearchBarDelegate  {
    let appID = "42432972"
    let appKey = "ec024a2414433825635ad1d304916ee2"
    let query = "buddha+bowl"
    var recipes: Recipes?
    var clickedRecipe: Int?
    var counter: Int = 0
    var dietParameter: String = ""
    var courseParameter: String = ""
    var cuisineParameter: String = ""
    
    var searchParameters: String?
    var searchActive: Bool = false
    
    //By initializing UISearchController without a searchResultsController, you are telling the search controller that you want use the same view that you’re searching to display the results. If you specify a different view controller here, that will be used to display the results instead.
    let searchController = UISearchController(searchResultsController: nil)
    
    //containers for object parameters
    let catagories: [String] = ["Diet options", "Course options", "Cuisine options"]
    let dietOptions: [String] =         ["388%5ELacto%20vegetarian", "389%5EOvo%20vegetarian", "390%5EPescetarian", "386%5EVegan", "403%5EPaleo"]
    let courseOptions: [String] = ["Main%20Dishes", "Desserts", "Side%20Dishes", "Lunch%20and%20Snacks", "Appetizers", "Salads", "Breads", "Breakfast%20and%20Brunch", "Soups", "Beverages", "Condiments%20and%20Sauces", "Cocktails"]
    let cuisineOptions: [String] = ["american", "italian", "asian", "mexican", "southern", "french", "southwestern", "barbecue", "indian", "chinese", "cajun", "english", "mediterranean", "greek", "spanish", "german", "thai", "moroccan", "irish", "japanese", "cuban", "hawaiin", "swedish", "hungarian", "portugese"]
    var optionsList: [Bool] = []
    var catagory1List: [Bool] = []
    var catagory2List: [Bool] = []
    var catagory3List: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //debug code to kill all objects from a specific entity
        /*
         // create the delete request for the specified entity
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Options")
         let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
         
         // get reference to the persistent container
         let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
         
         // perform the delete
         do {
         try persistentContainer.viewContext.execute(deleteRequest)
         } catch let error as NSError {
         print(error)
         }
         */
        
        
        //essentially, if this is the first time running the app, we need to
        //initialize an object in the database with all search options disabled
        //these can be changed and save via switches in the SideBarTVC
        if isEmpty {
            //currently 42 options, so insert 42 false values to the DB
            var counter = 0
            while counter < 42 {
                save(onValue: false)
                counter += 1
            }
            print("nothing in options array")
        }
        else {
            print("here")
        }
        
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
        //searchController.searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchController.searchBar.tintColor = #colorLiteral(red: 0.2219267856, green: 0.5662676973, blue: 0.6493632515, alpha: 1)
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.7758994699, green: 0.9258515835, blue: 0.9391316175, alpha: 1)
        searchController.searchBar.isTranslucent = true
        
      //  let fixed = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: self, action: nil)
       // fixed.width = 10
       // self.tabBarItem.
        
        
    }
    
    //check if the options entity has been populated or not
    var isEmpty : Bool {
        do{
            //1
            let appDelegate =
                UIApplication.shared.delegate as? AppDelegate
            let managedContext = appDelegate?.persistentContainer.viewContext
            
            //2
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Options")
            let count = try managedContext?.count(for: fetchRequest)
            
            return count == 0 ? true : false
        }catch{
            return true
        }
    }
    
    
    
    //saves a value to the DB
    func save(onValue: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Options", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(onValue, forKeyPath: "on")
        do {
            try managedContext.save()
            optionsList.append(onValue)
            print(optionsList.count)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    //make url based on values in optionsLists
    func makeURLOptions() {
        
        //&allowedCuisine[]=cuisine^cuisine-american
        //&allowedDiet[]=390^Pescetarian&allowedDiet[]=388^Lacto vegetarian
        
        //set the diet parameters given search preferences
        
        //must manually code in "[", "]", and "^"
        
        var counter = 0
        for i in catagory1List {
            if i == true {
                dietParameter += "&allowedDiet%5B%5D=" + dietOptions[counter]
            }
            counter += 1
        }
        
        counter = 0
        for i in catagory2List {
            if i == true {
                courseParameter += "&allowedCourse%5B%5D=course%5Ecourse-" + courseOptions[counter]
            }
            counter += 1
        }
        
        counter = 0
        for i in catagory3List {
            if i == true {
                cuisineParameter += "&allowedCuisine%5B%5D=cuisine%5Ecuisine-" + cuisineOptions[counter]
            }
            counter += 1
        }
    }
    
    
    
    
    
    func apiCall() {
        //  \(dietParameter)
        
        //construct the url
        let url = "https://api.yummly.com/v1/api/recipes?_app_id=\(appID)&_app_key=\(appKey)&q=\(searchParameters!)&q=&maxResult=50&start=0&requirePictures=true\(dietParameter)"
        
        //reset the parameters for the next search
        dietParameter = ""
        courseParameter = ""
        cuisineParameter = ""
        catagory1List = []
        catagory2List = []
        catagory3List = []
        optionsList = []
        
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
            else {
                print("its dead jim")
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
        //else just give it a default value of 1
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwoRecipes", for: indexPath) as! RecipeSearchTableViewCell
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
        print(segue.identifier)
        if segue.identifier == "sideBar" {
            //idk
        }
        else {
            let vc = segue.destination as! RecipeDataViewController
            vc.setRecipeID(id: recipes?.at((clickedRecipe)!).recipeID())
        }
        
    }
    
    
    //delegates for searching
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //When the search bar is first clicked, this means the user is ready
        //to search, thus now is the best time to fetch search options
        
        //fetch the search options from the database
        print("grabbing shit from DB")
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Options")
        do {
            let items = try managedContext.fetch(fetchRequest)
            for option in items {
                optionsList.append(option.value(forKeyPath: "on") as! Bool)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        //populate the subcontainers to make accessing the options easier
        counter = 0
        for _ in dietOptions {
            catagory1List.append(optionsList[counter])
            counter += 1
        }
        for _ in courseOptions {
            catagory2List.append(optionsList[counter])
            counter += 1
        }
        for _ in cuisineOptions {
            catagory3List.append(optionsList[counter])
            counter += 1
        }
        print(counter,catagory1List.count,catagory2List.count,catagory3List.count)
        
        
        
        print("fetched ", optionsList.count, " options from DB")
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        catagory1List = []
        catagory2List = []
        catagory3List = []
        optionsList = []
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //assign string here i think
        print("activated")
        makeURLOptions()
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
