//
//  RecipeSearchTableViewCell.swift
//  FoHo
//
//  Created by Brittney Ryn on 4/15/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import FaveButton



class RecipeSearchTableViewCell: UITableViewCell {
    
    @IBOutlet var leftImage: UIButton!
    @IBOutlet var rightImage: UIButton!
    
    var tappedLeft: Bool = false
    var tappedRight: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setRecipes(recipe1: RecipeSearchModel, recipe2: RecipeSearchModel){
       leftImage.backgroundRect(forBounds: CGRect(x: 0, y: 0, width: 186, height: 158))
    
        leftImage.imageView?.contentMode = .scaleAspectFit
        leftImage.setImage(recipe1.recipeImage(), for: UIControlState.normal)
       
        leftImage.imageView?.contentMode = .scaleAspectFit
        rightImage.imageView?.contentMode = .scaleAspectFit
        rightImage.setImage(recipe2.recipeImage(), for: UIControlState.normal)
        
    }
    
    func leftButton()->UIButton?{
        return leftImage
    }
    
    func rightButton()->UIButton?{
        return rightImage
    }
    

}

