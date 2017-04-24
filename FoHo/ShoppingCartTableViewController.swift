//
//  ShoppingCartTableViewController.swift
//  FoHo
//
//  Created by Scott Williams on 4/21/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import CoreData

//Load the ingredients saved from the shopping cart database.
//allow the user to delete them as needed
//maybe allow manual entry?
//https://www.raywenderlich.com/145809/getting-started-core-data-tutorial
class ShoppingCartTableViewController: UITableViewController{
    
    var items: [NSManagedObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping Cart"
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel!.text = item.value(forKeyPath: "name") as? String
        cell.selectionStyle = .none
        print(indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("hi mom")
            
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let managedContext = appDelegate?.persistentContainer.viewContext
            managedContext?.delete(items[indexPath.row] as NSManagedObject)
            do {
                try managedContext?.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            tableView.beginUpdates()
            items.remove(at: indexPath.row)
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.backgroundColor == UIColor.green {
            print("change to green")
            cell?.backgroundColor = UIColor.white
            //cell?.textLabel?.layer.backgroundColor = UIColor.green.cgColor
        }
        else {
            print("change back")
            cell?.backgroundColor = UIColor.green
        }
        //tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.purple
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
    }
}
