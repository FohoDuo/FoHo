//
//  SideBarTabelViewCell.swift
//  FoHo
//
//  Created by Scott Williams on 5/2/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit

//Cell class to be used by SideBarTableViewController
class SideBarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sideBarLabel: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    var index: IndexPath = IndexPath()
    var source: SideBarTableViewController? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //Sets up the cell with the specific option name, creates a switch,
    //and recieved a pointer to the calling tableView so it can get
    //notified if a search option is updated
    func setCell(text: String, index: IndexPath, sender: SideBarTableViewController) {
        sideBarLabel.text = text
        self.index = index
        source = sender
    }
    
    //Checks if a switch was touched and changes the value
    @IBAction func switchTouched(_ sender: UISwitch) {
        
        //section 0 contains diet optins
        if index.section == 0 {
            source?.updateSwitchStates(index: index.row)
        }
            
        //section 1 contains allergy options
        else if index.section == 1 {
            source?.updateSwitchStates(index: index.row + (source?.dietOptions.count)!)
        }
         
        //section 2 contains course options
        else if index.section == 1 {
            source?.updateSwitchStates(index: index.row + (source?.dietOptions.count)! + (source?.allergyOptions.count)!)
        }
        
        
        //section 2 contains cuisine options
        else {
            source?.updateSwitchStates(index: index.row + (source?.dietOptions.count)! + (source?.allergyOptions.count)! + (source?.courseOptions.count)!)
        }
    }
}
