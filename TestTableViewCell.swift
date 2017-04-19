//
//  TestTableViewCell.swift
//  FoHo
//
//  Created by Scott Williams on 4/17/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {

   
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setThing(name: String) {
        print(name)
        label?.text = name
    }

}
