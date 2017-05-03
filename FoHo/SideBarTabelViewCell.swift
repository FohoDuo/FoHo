//
//  SideBarTabelViewCell.swift
//  FoHo
//
//  Created by Scott Williams on 5/2/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import SideMenu

class SideBarTableViewCell: UITableViewCell {
    
    //@IBOutlet weak var sideBarLabel: UILabel!
    
   // @IBOutlet weak var `switch`: UISwitch!
    
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
        
        // Configure the view for the selected state
    }
    
    func setCell(text: String, index: IndexPath, sender: SideBarTableViewController) {
        sideBarLabel.text = text
        self.index = index
        source = sender
    }
    
    
    
    
    
    
    
    @IBAction func switchTouched(_ sender: UISwitch) {
        print("switched")
        if sender.isOn {
            print("now on")
        }
        else {
            print("is off")
        }
        
        if index.section == 0 {
            source?.updateSwitchStates(index: index.row)
        }
        else if index.section == 1 {
            source?.updateSwitchStates(index: index.row + (source?.dietOptions.count)!)
        }
        else {
            source?.updateSwitchStates(index: index.row + (source?.dietOptions.count)! + (source?.courseOptions.count)!)
        }
        //source?.updateSwitchStates(index: index)
        /*
         if index.section == 0 {
         if source?.switchStates1[index.row] == true {
         source?.switchStates1[index.row] = false
         }
         else {
         source?.switchStates1[index.row] = true
         }
         }
         if index.section == 1 {
         if source?.switchStates2[index.row] == true {
         source?.switchStates2[index.row] = false
         }
         else {
         source?.switchStates2[index.row] = true
         }
         }
         if index.section == 2 {
         if source?.switchStates3[index.row] == true {
         source?.switchStates3[index.row] = false
         }
         else {
         source?.switchStates3[index.row] = true
         }
         }
         */
        
    }


    
}
