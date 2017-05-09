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
    var allergyParameter: String = ""
    var courseParameter: String = ""
    var cuisineParameter: String = ""
    var timeParameter: String = ""
    
    var searchParameters: String?
    var searchActive: Bool = false
    
    //By initializing UISearchController without a searchResultsController, you are telling the search controller that you want use the same view that you’re searching to display the results. If you specify a different view controller here, that will be used to display the results instead.
    let searchController = UISearchController(searchResultsController: nil)
    
    //containers for url string parameters
    let catagories: [String] = ["Diet options", "Course options", "Cuisine options"]
    let dietOptions: [String] =         ["388%5ELacto%20vegetarian", "389%5EOvo%20vegetarian", "390%5EPescetarian", "386%5EVegan", "403%5EPaleo"]
    let allergyOptions: [String] = ["396%5EDairy-Free", "397%5EEgg-Free", "393%5EGluten-Free", "394%5EPeanut-Free", "398%5ESeafood-Free", "399%5ESesame-Free", "400%5ESoy-Free", "401%5ESulfite-Free", "395%5ETree%20Nut-Free", "392%5EWheat-Free"]
    let courseOptions: [String] = ["Main%20Dishes", "Desserts", "Side%20Dishes", "Lunch%20and%20Snacks", "Appetizers", "Salads", "Breads", "Breakfast%20and%20Brunch", "Soups", "Beverages", "Condiments%20and%20Sauces", "Cocktails"]
    let cuisineOptions: [String] = ["american", "italian", "asian", "mexican", "southern", "french", "southwestern", "barbecue", "indian", "chinese", "cajun", "english", "mediterranean", "greek", "spanish", "german", "thai", "moroccan", "irish", "japanese", "cuban", "hawaiin", "swedish", "hungarian", "portugese"]
    var timeValue: Int = 0
    var timeOn = Bool()
    
    //containers for which search options are enabled and disabled
    var optionsList: [Bool] = []
    var catagory1List: [Bool] = []
    var catagory2List: [Bool] = []
    var catagory3List: [Bool] = []
    var catagory4List: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //essentially, if this is the first time running the app, we need to
        //initialize an object in the database with all search options disabled
        //these can be changed and save via switches in the SideBarTVC
        if isEmpty {
            //currently 52 options, so insert 52 false values to the DB
            var counter = 0
            while counter < 52 {
                save(onValue: false)
                counter += 1
            }
        }

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = #colorLiteral(red: 0.2219267856, green: 0.5662676973, blue: 0.6493632515, alpha: 1)
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.7758994699, green: 0.9258515835, blue: 0.9391316175, alpha: 1)
        searchController.searchBar.isTranslucent = true
    }
    
    //check if the options entity has been populated or not
    var isEmpty : Bool {
        do{
            //1) Set app delegate
            let appDelegate =
                UIApplication.shared.delegate as? AppDelegate
            
            //2) Set managed context
            let managedContext = appDelegate?.persistentContainer.viewContext
            
            //3) Set fetch request
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Options")
            let count = try managedContext?.count(for: fetchRequest)
            
            //4) Checks the number of items fetched
            return count == 0 ? true : false
        } catch{
            return true
        }
    }
    
    
    //saves a value to the database. Used to set up the default options
    func save(onValue: Bool) {
        
        //1) Set app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //2) Set managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //3) Grab the desired entity
        let entity = NSEntityDescription.entity(forEntityName: "Options", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //4) Saves a new record into the entity
        item.setValue(onValue, forKeyPath: "on")
        do {
            //5) Save the entity
            try managedContext.save()
            optionsList.append(onValue)
            print(optionsList.count)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    //make url based on values in optionsLists
    func makeURLOptions() {

        //iterate through each list of options, appending appropriate strings
        //to the url as needed
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
                allergyParameter += "&allowedAllergy%5B%5D=" + allergyOptions[counter]
            }
            counter += 1
        }
        
        counter = 0
        print(counter)
        for i in catagory3List {
            if i == true {
                print(counter)
                print(courseOptions.count)
                courseParameter += "&allowedCourse%5B%5D=course%5Ecourse-" + courseOptions[counter]
            }
            counter += 1
        }
        
        counter = 0
        for i in catagory4List {
            if i == true {
                cuisineParameter += "&allowedCuisine%5B%5D=cuisine%5Ecuisine-" + cuisineOptions[counter]
            }
            counter += 1
        }
        if timeOn {
            timeParameter += "&maxTotalTimeInSeconds=" + String(60 * Int(timeValue))
        }
    }
    
    
    //reset the parameters for the next search
    func resetParameters() {
        
        dietParameter = ""
        allergyParameter = ""
        courseParameter = ""
        cuisineParameter = ""
        timeParameter = ""
        catagory1List = []
        catagory2List = []
        catagory3List = []
        catagory4List = []
        optionsList = []
    }
    
    //Finishes putting the URL together and makes an api call via alamofire
    func apiCall() {
        
        //construct the url
        let url = "https://api.yummly.com/v1/api/recipes?_app_id=\(appID)&_app_key=\(appKey)&q=\(searchParameters!)&q=&maxResult=50&start=0&requirePictures=true\(dietParameter)\(timeParameter)"
        
        resetParameters()
        
        print(url)
        Alamofire.request(url).responseJSON { response in
            
            if let JSON = response.result.value {
                
                //might need this here dunno...?
                self.tableView.reloadData()
                
                //Populate our recipes instance with the data from the API call
                self.recipes = Recipes(dataSource: JSON)
                self.tableView.reloadData()
            }
            else {
                print("It's dead jim")
                print(response)
            }
        }
    }


    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recipes != nil {
            return (recipes?.numRecipes())! / 2
        }
        //else just give it a default value of 0
        return 0
    }
    
//***Some magic Brittney came up with, her job to document***
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
        }
        return cell
    }
    
    func buttonAction(sender: UIButton){
        clickedRecipe = sender.tag
        performSegue(withIdentifier: "leftRecipeSegue", sender: clickedRecipe)
    }

    
    
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        //1) Set app delegate
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        //2) Set managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //3) Set fetch request
        var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Options")
        do {
            let items = try managedContext.fetch(fetchRequest)
            for option in items {
                
                //4) Grab each value from the fetch and put into optionsList
                optionsList.append(option.value(forKeyPath: "on") as! Bool)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Time")
        do {
            let items = try managedContext.fetch(fetchRequest)
            for option in items {
                
                //4) Grab each value from the fetch
                timeOn = ((option.value(forKeyPath: "on") as! Bool))
                timeValue = ((option.value(forKeyPath: "timeValue") as! Int))
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
        for _ in allergyOptions {
            catagory2List.append(optionsList[counter])
            counter += 1
        }
        for _ in courseOptions {
            catagory3List.append(optionsList[counter])
            counter += 1
        }
        for _ in cuisineOptions {
            catagory4List.append(optionsList[counter])
            counter += 1
        }

        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        //Resets the options since the user may change them before the next search
        catagory1List = []
        catagory2List = []
        catagory3List = []
        catagory4List = []
        optionsList = []
        searchActive = false
    }
    
    //user pressed enter, so perfrom the search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //assign string here
        makeURLOptions()
        apiCall()
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
        tableView.reloadData()
    }
    
    
}


extension RecipeSearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
