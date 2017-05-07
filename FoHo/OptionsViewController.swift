//
//  OptionsViewController.swift
//  FoHo
//
//  Created by Scott Williams on 5/6/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import CoreData

class OptionsViewController: UIViewController, UIAlertViewDelegate {

    @IBOutlet weak var resetSearchButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    //user clicked the reset options button
    @IBAction func tappedResetSearch(_ sender: UIButton) {
        let alert: UIAlertView = UIAlertView()
        alert.title = "Warning"
        alert.message = "Are you sure you want to restore search options to their default state?"
        alert.addButton(withTitle: "Yes")
        alert.addButton(withTitle: "No")
        alert.delegate = self  // set the delegate here
        alert.tag = 10
        alert.show()
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
        //if the user clicked the reset search options button
        if alertView.tag == 10 {
            
            //if the user then clicked yes
            if buttonIndex == 0 {
                
                //***Deletes all records for the Options entity
                // create the delete request for the specified entity
                var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Options")
                var deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                
                // get reference to the persistent container
                var persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
                
                // perform the delete
                do {
                    try persistentContainer.viewContext.execute(deleteRequest)
                } catch let error as NSError {
                    print(error)
                }
                
                //Puts the default options into the database
                var counter = 0
                while counter < 52 {
                    save(onValue: false)
                    counter += 1
                }
                
                //***Deletes all records for the Time entity
                // create the delete request for the specified entity
                fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Time")
                deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                
                // get reference to the persistent container
                persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
                
                // perform the delete
                do {
                    try persistentContainer.viewContext.execute(deleteRequest)
                } catch let error as NSError {
                    print(error)
                }
                
            }
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
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    
}
