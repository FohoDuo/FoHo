//
//  RecipeDataViewController.swift
//  FoHo
//
//  Created by Scott Williams on 4/14/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import FaveButton
import Alamofire

//View Controller that displays more detailed information regarding a specific recipe.
//Using the recipeID from the first API call in the search view controller, we make
//a second API call that gives us the more detailed information needed to populate this view
class RecipeDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var navBar: UINavigationBar!
    let appID = "42432972"
    let appKey = "ec024a2414433825635ad1d304916ee2"
    var recipeKey: String? //"Buddha-Bowl-1238769"
    var recipe: RecipeSearchData?
    
    @IBOutlet var heartButton: FaveButton!

    @IBOutlet var ingredients: UITableView!
    @IBOutlet weak var instructionButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBAction func didTapHeartButton(_ sender: Any) {
        print("Tapped the heart")
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize tableview delegates
        ingredients.delegate = self
        ingredients.dataSource = self
        heartButton.delegate = self
        heartButton.frame(forAlignmentRect: CGRect(x: 290, y: 200, width: 33, height: 33))

        print(recipeKey)
        let url = "http://api.yummly.com/v1/api/recipe/\(recipeKey!)?_app_id=\(appID)&_app_key=\(appKey)"
        
        //Magically calls the API and gets the data
        Alamofire.request(url).responseJSON { response in
            if let JSON = response.result.value {

                //Populate our recipes instance with the data from the API call
                self.recipe = RecipeSearchData(recipeData: JSON)
                
                //set up the view outlets
             //   self.recipeName.text = self.recipe?.recipeName()
                self.recipeImage.image = self.recipe?.recipeImage()
            }
            //self.instructionButton.layer.borderColor = UIColor.darkGray as! CGColor
        }
       
        ingredients.reloadData()
        self.view.addSubview(ingredients)
      //  navBar.items.Title = recipe?.recipeName()
        //navBar.titleTextAttributes = recipe?.recipeName()

        //self.title = recipe?.recipeName()
       // self.navigationItem.title = recipe?.recipeName()
    }
    
    //set recipe key here with old data
    func setRecipeID(id: String?) {
        print("passed id is: ", id)
        recipeKey = id
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
    
        //if the API call has returned, we can populate the tableview with ear=ch ingredient
        if recipe != nil{
            cell.setCell(item: recipe!.ingredients()[indexPath.row])
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
        let webPage = segue.destination as! RecipeWebViewController
        webPage.setUrl(url: (recipe?.webUrl())!)
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
