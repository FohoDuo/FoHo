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
    
    
    

    @IBOutlet var heartButton: FaveButton!
    @IBOutlet var timeCook: UILabel!
    @IBOutlet var numberOfServings: UILabel!

    @IBOutlet var ingredients: UITableView!
    @IBOutlet weak var instructionButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!

    
    @IBAction func didTapHeartButton(_ sender: Any) {
        if !fromFavorites{
        print("Tapped the heart")
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
         //   for item in items{
                //print(item)
                
           // }
            print(items[0].value(forKey: "id"))

             //try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
             }
        }
        
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize tableview delegates
        ingredients.delegate = self
        ingredients.dataSource = self
        heartButton.delegate = self
        heartButton.frame(forAlignmentRect: CGRect(x: 290, y: 200, width: 33, height: 33))
        if(!fromFavorites){
        print(recipeKey)
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
                //navigationController?.navigationBar.titleTextAttributes =               // self.navigationItem.titleView?.laye
            }
            //self.instructionButton.layer.borderColor = UIColor.darkGray as! CGColor
        }
       
        ingredients.reloadData()
        self.view.addSubview(ingredients)
        }
        
        else{
            
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
            
            let attributes = [NSFontAttributeName : UIFont(name: "futura", size: 16)!, NSForegroundColorAttributeName : #colorLiteral(red: 0.1520104086, green: 0.4011090714, blue: 0.4621073921, alpha: 1)] as [String : Any]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
            self.navigationItem.title = name

            
        }
    }
    func setFavorited(recipe: NSManagedObject){
        favRecipe = recipe
        fromFavorites = true
    }
    
    //set recipe key here with old data
    func setRecipeID(id: String?) {
        print("passed id is: ", id)
        recipeKey = id
        fromFavorites = false
    }
    
    //probably not needed, just keeping in case we want something to happen
    //on click besides segueing
    @IBAction func didTabButton(_ sender: UIButton) {
        print("YAYYAYAY")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ingredients.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //if the API call has returned, give this the number of ingredients
        if recipe != nil {
            return recipe!.ingredients().count
        }
        
        //else just let it be 1 for now
        return 1
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredients", for: indexPath) as! IngredientsTableViewCell
        var ingredientList = recipe?.ingredients()
        if fromFavorites{
            ingredientList = favRecipe?.value(forKeyPath: "ingredients") as! NSArray as? [String]
        }
        //if the API call has returned, we can populate the tableview with ear=ch ingredient
        if recipe != nil{
            cell.setCell(item: (ingredientList?[indexPath.row] as! String))
        }
            
        //use come empty value of hardcoded loading string otherwise
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
