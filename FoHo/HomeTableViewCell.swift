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
    
    @IBOutlet weak var leftImageSquare: UIView!
    
    @IBOutlet weak var rightImageSquare: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setRecipes(recipe1: RecipeSearchModel, recipe2: RecipeSearchModel){
        
        leftImageSquare.layer.borderWidth = 0.23
        leftImageSquare.layer.borderColor = UIColor.black.cgColor
        leftImageSquare.layer.cornerRadius = 2
        leftImage.backgroundRect(forBounds: CGRect(x: 0, y: 0, width: 186, height: 158))
        leftImage.layer.cornerRadius = 2
        leftImage.layer.borderWidth = 0.1
        leftImage.layer.borderColor = UIColor.black.cgColor
        leftImage.setBackgroundImage(recipe1.recipeImage(), for: UIControlState.normal)
        leftImage.imageView?.contentMode = .scaleAspectFit
        leftRecipeName.text = recipe1.recipeName()
        
        
        rightImageSquare.layer.borderWidth = 0.23
        rightImageSquare.layer.borderColor = UIColor.black.cgColor
        rightImageSquare.layer.cornerRadius = 2
        rightImage.layer.cornerRadius = 2
        rightImage.layer.borderWidth = 0.1
        rightImage.layer.borderColor = UIColor.black.cgColor
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
