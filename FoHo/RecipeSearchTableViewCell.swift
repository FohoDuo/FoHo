//
//  RecipeSearchTableViewCell.swift
//  FoHo
//
//  Created by Brittney Ryn on 4/15/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit

class RecipeSearchTableViewCell: UITableViewCell {
    
    @IBOutlet var leftImage: UIButton!
    @IBOutlet var rightImage: UIButton!
    
    @IBOutlet var leftImageSquare: UIView!
    @IBOutlet var rightImageSquare: UIView!
    
    @IBOutlet var rightImageName: UILabel!
    @IBOutlet var leftImageName: UILabel!
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
    
    //Set up the two recipe images in the cell
    func setRecipes(recipe1: RecipeSearchModel, recipe2: RecipeSearchModel){
        leftImageSquare.layer.borderWidth = 0.23
        leftImageSquare.layer.borderColor = UIColor.black.cgColor
        leftImageSquare.layer.cornerRadius = 2
        leftImage.backgroundRect(forBounds: CGRect(x: 0, y: 0, width: 186, height: 158))
        leftImage.layer.cornerRadius = 2
        leftImage.layer.borderWidth = 0.1
        leftImage.layer.borderColor = UIColor.black.cgColor
        leftImage.imageView?.contentMode = .scaleAspectFit
        leftImageName.text = recipe1.recipeName()
        leftImage.setBackgroundImage(recipe1.recipeImage(), for: UIControlState.normal)
        leftImage.imageView?.contentMode = .scaleAspectFit
        
        rightImageSquare.layer.borderWidth = 0.23
        rightImageSquare.layer.borderColor = UIColor.black.cgColor
        rightImageSquare.layer.cornerRadius = 2
        rightImage.imageView?.contentMode = .scaleAspectFit
        rightImage.layer.cornerRadius = 2
        rightImage.layer.borderWidth = 0.1
        rightImage.layer.borderColor = UIColor.black.cgColor
        rightImage.setBackgroundImage(recipe2.recipeImage(), for: UIControlState.normal)
        rightImageName.text = recipe2.recipeName()
        
    }
    
    func leftButton()->UIButton?{
        return leftImage
    }
    
    func rightButton()->UIButton?{
        return rightImage
    }
    

}

