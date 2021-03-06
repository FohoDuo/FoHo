//
//  RecipeDataViewController.swift
//  FoHo
//
//  Created by Scott Williams on 4/14/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//
import UIKit
import FaveButton
import CoreData
import Alamofire
import Social

//View Controller that displays more detailed information regarding a specific recipe.
//Using the recipeID from the first API call in the search view controller, we make
//a second API call that gives us the more detailed information needed to populate this view
class RecipeDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var navBar: UINavigationBar!
    let appID = "42432972"
    let appKey = "ec024a2414433825635ad1d304916ee2"
    var recipeKey: String? //"Buddha-Bowl-1238769"
    var recipe: RecipeSearchData? // Comes From Search
    var favRecipe: NSManagedObject? // Comes From Favorites
    var fromFavorites: Bool = false
    var info: String = ""
    var items: NSArray?
    
    
    @IBOutlet var heartButton: FaveButton!
    @IBOutlet var timeCook: UILabel!
    @IBOutlet var numberOfServings: UILabel!
    
    @IBOutlet var ingredients: UITableView!
    @IBOutlet weak var instructionButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    
    
    //Functionality for when the user clicks the favorite button
    @IBAction func didTapHeartButton(_ sender: Any) {
        if !fromFavorites{
            
            //Save the recipe to the data base when the button is first selected
            if heartButton.isSelected == true {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                
                //1
                let managedContext = appDelegate.persistentContainer.viewContext
                
                //2
                let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
                let item = NSManagedObject(entity: entity, insertInto: managedContext)
                
                //3
                item.setValue(recipe?.recipeName(), forKeyPath: "recipeName")
                item.setValue(recipeKey, forKey: "id")
                item.setValue(recipe?.recipeUri(), forKey: "recipeImage")
                item.setValue(recipe?.totalTime(), forKeyPath: "totalTime")
                item.setValue(recipe?.ingredients(), forKey: "ingredients")
                item.setValue(recipe?.numberOfServings(), forKey: "numServings")
                item.setValue(recipe?.webUrl(), forKey: "webUrl")
                
                
                //4
                do {
                    try managedContext.save()
                    //items.append(item)
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
                do{
                    let items = try managedContext.fetch(fetchRequest)
                } catch let error as NSError {
                    print("Could not fetch. \(error), \(error.userInfo)")
                }
            }
                
            //We remove the favorite by parsing the database string so it matches
            //the recipeKey
            else {
                //1) Set app delegate
                guard let appDelegate =
                    UIApplication.shared.delegate as? AppDelegate else {
                        return
                }
                
                //2) Set managed context
                let managedContext = appDelegate.persistentContainer.viewContext
                
                
                //3) Set fetch request
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
                do {
                    let items = try managedContext.fetch(fetchRequest)
                    for item in items {
                        
                        //the key in the database is stored as a weird optional string without quotes,
                        //so we need to get the key out of it
                        var temp: String = String(describing: item.value(forKey: "id"))
                        var index = 0
                        var temp2: String = ""
                        var insert = false
                        
                        for c in temp.characters {
                            if c == ")" {
                                insert = false
                            }
                            if insert {
                                temp2 += String(c)
                            }
                            if c == "(" {
                                insert = true
                            }
                            index += 1
                        }
                        
                        //if the database key equals the recipes key, remove it from the database
                        if temp2 == recipeKey! {
                            managedContext.delete(item)
                        }
                    }
                    
                    //5) Save the updated entity
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not fetch. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareView.alpha = 0
        
        //initialize tableview delegates
        ingredients.delegate = self
        ingredients.dataSource = self
        heartButton.delegate = self
        heartButton.frame(forAlignmentRect: CGRect(x: 290, y: 200, width: 33, height: 33))
        
        //if we have navigated to this view from a search result, make an api call to populate the data
        if(!fromFavorites){
            let url = "http://api.yummly.com/v1/api/recipe/\(recipeKey!)?_app_id=\(appID)&_app_key=\(appKey)"
            
            //Magically calls the API and gets the data
            Alamofire.request(url).responseJSON { response in
                if let JSON = response.result.value {
                    
                    //Populate our recipes instance with the data from the API call
                    self.recipe = RecipeSearchData(recipeData: JSON)
                    
                    //set up the view outlets
                    self.recipeImage.image = self.recipe?.recipeImage()
                    self.title = self.recipe?.recipeName()
                    
                    self.info = (self.recipe?.totalTime())! + " | " + (self.recipe?.numberOfServings()?.description)! + " servings"
                    self.timeCook.text = self.info
                    let attributes = [NSFontAttributeName : UIFont(name: "futura", size: 16)!, NSForegroundColorAttributeName : #colorLiteral(red: 0.1520104086, green: 0.4011090714, blue: 0.4621073921, alpha: 1)] as [String : Any]
                    self.navigationController?.navigationBar.titleTextAttributes = attributes
                    self.navigationItem.title = self.recipe?.recipeName()
                    self.setFavButton()
                    
                }
            }
        }
            
        //we have came from the favorites list, so populate data from database
        else {
            if let imageData = favRecipe?.value(forKey: "recipeImage") as? String{
                if let url = URL(string: imageData),
                    let data = try? Data(contentsOf: url),
                    let image = UIImage(data: data){
                    self.recipeImage.image = image
                }
            }
            
            let name = favRecipe?.value(forKey: "recipeName") as? String
            self.title = name
            
            let time = favRecipe?.value(forKey: "totalTime") as? String
            let numServings = favRecipe?.value(forKeyPath: "numServings") as? Int
            
            self.info = time! + " | " + numServings!.description + " servings"
            self.timeCook.text = self.info
            self.items = favRecipe?.value(forKeyPath: "ingredients") as! NSArray
            
            let attributes = [NSFontAttributeName : UIFont(name: "futura", size: 16)!, NSForegroundColorAttributeName : #colorLiteral(red: 0.1520104086, green: 0.4011090714, blue: 0.4621073921, alpha: 1)] as [String : Any]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
            self.navigationItem.title = name
            self.recipeKey = favRecipe?.value(forKey: "id") as? String
            setFavButton()
        }
        
        ingredients.reloadData()
        self.view.addSubview(ingredients)
    }
    
    
    func setFavorited(recipe: NSManagedObject){
        favRecipe = recipe
        fromFavorites = true
    }
    
    //Code to preset the favorite button should the recipe already be favorited
    func setFavButton() {
        
        
        //1) Set app delegate
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        //2) Set managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //3) Set fetch request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        do {
            let items = try managedContext.fetch(fetchRequest)
            for item in items {
                
                var temp: String = String(describing: item.value(forKey: "id"))
                
                var index = 0
                
                var temp2: String = ""
                var insert = false
                
                for c in temp.characters {
                    if c == ")" {
                        insert = false
                    }
                    if insert {
                        temp2 += String(c)
                    }
                    if c == "(" {
                        insert = true
                    }
                    index += 1
                }
                if temp2 == recipeKey! {
                    heartButton.isSelected = true
                }
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    
    //set recipe key here with old data
    func setRecipeID(id: String?) {
        recipeKey = id
        fromFavorites = false
    }
    
    //probably not needed, just keeping in case we want something to happen
    //on click besides segueing
    @IBAction func didTabButton(_ sender: UIButton) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ingredients.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //if the API call has returned, give this the number of ingredients
        if recipe != nil || favRecipe != nil {
            if fromFavorites{
                return items!.count
            }
            else{
                return recipe!.ingredients().count
            }
        }
        
        //else just let it be 1 for now
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredients", for: indexPath) as! IngredientsTableViewCell
        
        //if the API call has returned, we can populate the tableview with ear=ch ingredient
        if recipe != nil || favRecipe != nil{
            if fromFavorites{
                cell.setCell(item: (items?[indexPath.row] as! String))
                print(indexPath.row)
                fromFavorites = true
            }
            else{
                let ingredientList = recipe?.ingredients()
                cell.setCell(item: (ingredientList?[indexPath.row])!)
            }
        }
            
            //use some empty value of hardcoded loading string otherwise
        else{
            cell.setCell(item: "")
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    //Sets the webview page up one we move to it
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var url = recipe?.webUrl()
        if fromFavorites{
            url = favRecipe?.value(forKey: "webUrl") as? String
        }
        let webPage = segue.destination as! RecipeWebViewController
        webPage.setUrl(url: url!)
    }
    
    
    
    @IBOutlet weak var shareView: UIView!
    
    
    //brings up the share recipe view
    @IBAction func touchedShare(_ sender: UIButton) {
        
        shareView.alpha = 1
        shareView.layer.cornerRadius = 2
        shareView.layer.borderWidth = 0.23
        shareView.layer.borderColor = UIColor.black.cgColor
        shareView.backgroundColor = #colorLiteral(red: 0.2810869217, green: 0.3669615388, blue: 0.7158250213, alpha: 1)
    }
    
    //code to share to facebook
    @IBAction func fbTapped(_ sender: UIButton) {
        let vc = SLComposeViewController(forServiceType:SLServiceTypeFacebook)
        vc?.add(recipe?.recipeImage())
        vc?.add(URL(string: (recipe?.webUrl())!))
        vc?.setInitialText("From FoHo: I found a new recipe!    ")
        self.present(vc!, animated: true, completion: nil)
        
        shareView.alpha = 0
    }
    
    //code to share to twitter
    @IBAction func twTapped(_ sender: UIButton) {
        let vc = SLComposeViewController(forServiceType:SLServiceTypeTwitter)
        vc?.add(recipe?.recipeImage())
        vc?.add(URL(string: (recipe?.webUrl())!))
        vc?.setInitialText("From FoHo: I found a new recipe!    ")
        
        self.present(vc!, animated: true, completion: nil)
        
        shareView.alpha = 0
    }
    
    //code to not share and go back
    @IBAction func cancelTapped(_ sender: UIButton) {
        shareView.alpha = 0
    }
    
}
