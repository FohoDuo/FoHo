//
//  SideBarTableViewController.swift
//  
//
//  Created by Scott Williams on 4/26/17.
//
//

import UIKit

class SideBarTableViewController: UITableViewController {

    let catagories: [String] = ["Diet options", "Course options", "Cuisine options"]
    let dietOptions: [String] = ["Lacto vegetarian","Ovo vegetarian","Pescetarian","Vegan","Vegetarian"]
    let courseOptions: [String] = ["Main Dishes", "Desserts", "Side Dishes", "Lunch and Snacks", "Appetizers", "Salads", "Breads", "Breakfast and Brunch", "Soups", "Beverages", "Condiments and Sauces", "Cocktails"]
    let cuisineOptions: [String] = ["American", "Italian", "Asian", "Mexican", "Southern & Soul Food", "French", "Southwestern", "Barbecue", "Indian", "Chinese", "Cajun & Creole", "English", "Mediterranean", "Greek", "Spanish", "German", "Thai", "Moroccan", "Irish", "Japanese", "Cuban", "Hawaiin", "Swedish", "Hungarian", "Portugese"]
    
    //these need to be saved in order to know what is turned off and on
    //all off by default
    var switchStates1: [Bool] = []
    var switchStates2: [Bool] = []
    var switchStates3: [Bool] = []
    var optionsList: [Bool] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("number of options: ", courseOptions.count + dietOptions.count + cuisineOptions.count)
        var counter = 0
        
        while counter < dietOptions.count {
            switchStates1.append(false)
            counter += 1
        }
        counter = 0
        while counter < courseOptions.count {
            switchStates2.append(false)
            counter += 1
        }
        counter = 0
        while counter < cuisineOptions.count {
            switchStates3.append(false)
            counter += 1
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func setOptions(options: [Bool]) {
        
    }
    
    /*
    func updateSwitchStates(index: Int) {
        if switchStates[index] == false {
            switchStates[index] = true
        }
        else {
            switchStates[index] = false
        }
        
    }
 */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return catagories[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return dietOptions.count
        }
        if section == 1 {
            return courseOptions.count
        }
        if section == 2 {
            return cuisineOptions.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideBarCell", for: indexPath) as! SideBarTableViewCell
        if(indexPath.section == 0) {
            cell.setCell(text: dietOptions[indexPath.row], index: indexPath, sender: self)
            cell.switch.isOn = switchStates1[indexPath.row]
        }
        else if indexPath.section == 1 {
            cell.setCell(text: courseOptions[indexPath.row], index: indexPath, sender: self)
            print(switchStates2.count,indexPath.row)
            cell.switch.isOn = switchStates2[indexPath.row]
        }
        else {
            cell.setCell(text: cuisineOptions[indexPath.row], index: indexPath,sender: self)
            cell.switch.isOn = switchStates3[indexPath.row]
        }
        // Configure the cell...
        
       
        return cell
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
