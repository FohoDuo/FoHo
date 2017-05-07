//
//  FavoritesTableViewCell.swift
//  FoHo
//
//  Created by Brittney Ryn on 5/5/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import CoreData

class FavoritesTableViewCell: UITableViewCell {
    

    @IBOutlet weak var recipeImage: UIImageView!
    //@IBOutlet weak var recipeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(object: NSManagedObject){
        let name = object.value(forKeyPath: "recipeName") as? String
        if let imageData = object.value(forKeyPath: "recipeImage") as? String{
            if let url = URL(string: imageData),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                recipeImage.image = image
            }
        }
        
        let ingredients = object.value(forKeyPath: "ingredients") as! NSArray
     //   recipeName.text = name
        
        
        
    }
    
    
}
