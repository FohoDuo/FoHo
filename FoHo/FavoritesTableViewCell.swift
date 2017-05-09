//
//  FavoritesTableViewCell.swift
//  FoHo
//
//  Created by Brittney Ryn on 5/5/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import CoreData

//Cells to be displayed in the favorites table view
class FavoritesTableViewCell: UITableViewCell {
    

    @IBOutlet weak var recipeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(object: NSManagedObject){
        if let imageData = object.value(forKeyPath: "recipeImage") as? String{
            if let url = URL(string: imageData),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                recipeImage.image = image
            }
        }
    }
    
    
}
