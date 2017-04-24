//
//  IngredientsTableViewCell.swift
//  FoHo
//
//  Created by Brittney Ryn on 4/14/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import CoreData

class IngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var listItem: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(item: String){
        listItem.text = item
        addButton.backgroundColor = UIColor.darkGray
        addButton.layer.cornerRadius = 15
    }
    
    
    
    @IBAction func onClick(_ sender: Any) {
        print("button clicked@!@")
        print(listItem.text)
        
        //send the list item to the shopping
        //cart database
        
        
        
    }
    

}
