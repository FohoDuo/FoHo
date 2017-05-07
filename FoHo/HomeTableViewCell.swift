//
//  HomeTableViewCell.swift
//  FoHo
//
//  Created by Scott Williams on 4/24/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    var tappedLeft: Bool = false
    var tappedRight: Bool = false
    
    @IBOutlet var rightRecipeName: UILabel!
    @IBOutlet var leftRecipeName: UILabel!
    @IBOutlet weak var rightImage: UIButton!
    @IBOutlet weak var leftImage: UIButton!
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
        
        leftImage.setBackgroundImage(recipe1.recipeImage(), for: UIControlState.normal)
        leftImage.imageView?.contentMode = .scaleAspectFit
        leftRecipeName.text = recipe1.recipeName()
        
        rightImage.imageView?.contentMode = .scaleAspectFit
        //rightImage.setImage(recipe2.recipeImage(), for: UIControlState.normal)
        rightImage.setBackgroundImage(recipe2.recipeImage(), for: UIControlState.normal)
        rightRecipeName.text = recipe2.recipeName()
        
    }
    
    func leftButton()->UIButton?{
        return leftImage
    }
    
    func rightButton()->UIButton?{
        return rightImage
    }

}
