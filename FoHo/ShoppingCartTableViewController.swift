//
//  ShoppingCartTableViewController.swift
//  FoHo
//
//  Created by Scott Williams on 4/21/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import CoreData
import MGSwipeTableCell

//Load the ingredients saved from the shopping cart database.
//allow the user to delete them as needed
//maybe allow manual entry?
//https://www.raywenderlich.com/145809/getting-started-core-data-tutorial
class ShoppingCartTableViewController: UITableViewController, MGSwipeTableCellDelegate {
    
    var items: [NSManagedObject] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping Cart"
        tableView.register(MGSwipeTableCell.self,
                           forCellReuseIdentifier: "Cell")

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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")
        
        //3
        do {
            items = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MGSwipeTableCell
        let item = items[indexPath.row]
        cell.textLabel!.text = item.value(forKeyPath: "name") as? String
   //     cell.detailTextLabel!.text = "Detail text"
        cell.delegate = self as! MGSwipeTableCellDelegate //optional
        
        //configure left buttons
        cell.leftButtons = [MGSwipeButton(title: "", icon: UIImage(named:"unCheckMark.png"), backgroundColor: .green),
                            MGSwipeButton(title: "", icon: UIImage(named:"fav.png"), backgroundColor: .blue)]
        //
        cell.leftButtons[0].tag = 10
        
        cell.leftSwipeSettings.transition = .rotate3D
        
        //configure right buttons
        cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: .red),
                             MGSwipeButton(title: "More",backgroundColor: .lightGray)]
        cell.rightSwipeSettings.transition = .rotate3D
        
        return cell
    }
    
    
//swipe delegates
    
    
    /**
     * Called when the user clicks a swipe button or when a expandable button is automatically triggered
     * @return YES to autohide the current swipe buttons
     **/
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        //if direction.rawValue == 0, then the user swiped left
           //button 0 is the green button
           //button 1 is the blue button
        //if direction.rawValue == 1, then the user swiped right
           //button 1 is the gray button
           //button 0 is the red button
        print("direction swiped is: ", direction.rawValue)
        print("button pressed: ", index)
        
        if direction.rawValue == 0 && index == 0 {
            print("green")
            if cell.leftButtons[0].tag == 10 {
                cell.leftButtons[0] = MGSwipeButton(title: "", icon: UIImage(named:"checkMark.png"), backgroundColor: .green)
                cell.leftButtons[0].tag = 11
                print("assigned")
            }
            else if cell.leftButtons[0].tag == 11 {
                cell.leftButtons[0] = MGSwipeButton(title: "", icon: UIImage(named:"unCheckMark.png"), backgroundColor: .green)
                cell.leftButtons[0].tag = 10
                print("unassigned")
            }
        }
        cell.refreshButtons(false)
        cell.refreshContentView()
        
        return false
    }
    
    
    
    
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
     let item = items[indexPath.row]
     cell.textLabel?.text = item.value(forKeyPath: "name") as? String
     return cell
     
     }
     */
    

    
    //some crazy function to set up the "+" item button
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Item", message: "Add a new item to the cart", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let textField = alert.textFields?.first,
                let itemToSave = textField.text else {
                    return
                }
            self.save(itemName: itemToSave)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func save(itemName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //3
        item.setValue(itemName, forKeyPath: "name")
        
        //4
        do {
            try managedContext.save()
            items.append(item)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
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
        return items.count
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
