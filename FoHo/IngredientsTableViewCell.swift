//
//  IngredientsTableViewCell.swift
//  FoHo
//
//  Created by Brittney Ryn on 4/14/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit

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
        addButton.backgroundColor = UIColor.purple
        addButton.layer.cornerRadius = 8
    }

}
