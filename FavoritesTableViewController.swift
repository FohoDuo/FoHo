//
//  FavoritesTableViewController.swift
//  FoHo
//
//  Created by Brittney Ryn on 5/5/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import CoreData

class FavoritesTableViewController: UITableViewController {
    
    var Favorited: [NSManagedObject] = []
    var mealType: [String] = ["Main Dishes", "Desserts", "Side Dishes", "Lunch and Snacks", "Appetizers", "Salads", "Breads", "Breakfast and Brunch", "Soups", "Beverages", "Condiments and Sauces", "Cocktails"]
    var colors = [#colorLiteral(red: 0.2871333339, green: 0.6674844371, blue: 0.7044274964, alpha: 1), #colorLiteral(red: 0.2219267856, green: 0.5662676973, blue: 0.6493632515, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        
        //3
        do {
            Favorited = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
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
        return Favorited.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as! FavoritesTableViewCell
        let item = Favorited[indexPath.row]
        // cell.recipeName.text = "Cookie"//item.value(forKeyPath: "recipeName") as? String
        cell.setCell(object: item)
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = colors[0]
        }
        else{
            cell.backgroundColor = colors[1]
        }

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("hi mom")
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let managedContext = appDelegate?.persistentContainer.viewContext
            managedContext?.delete(Favorited[indexPath.row] as NSManagedObject)
            do {
                try managedContext?.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            tableView.beginUpdates()
            Favorited.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        
        if editingStyle == .insert {
            print("cmon")
        }
        
    }
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "favToRecipeData"{
            let cell = sender as! FavoritesTableViewCell
            if let indexPath = tableView.indexPath(for: cell){
                let recipeData = segue.destination as! RecipeDataViewController
                recipeData.setFavorited(recipe: Favorited[indexPath.row])
            }
        }
        
    }
}
