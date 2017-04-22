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
    var left_Recipe: RecipeSearchModel?
    var right_Recipe: RecipeSearchModel?
    var leftPair: (RecipeSearchModel, Bool)?
    var rightPair: (RecipeSearchModel, Bool)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func didTapLeftButton(_ sender: Any) {
        tappedLeft = true
    }
    

    @IBAction func didTapRightButton(_ sender: Any) {
         tappedRight = true
    }
    
    
    func setRecipes(recipe1: RecipeSearchModel, recipe2: RecipeSearchModel){
       leftImage.backgroundRect(forBounds: CGRect(x: 0, y: 0, width: 186, height: 158))
    
    
        //(frame: CGRect(x: 0, y: 0, width: 186, height: 158))
        leftImage.imageView?.contentMode = .scaleAspectFit
        leftImage.setImage(recipe1.recipeImage(), for: UIControlState.normal)
       
        leftImage.imageView?.contentMode = .scaleAspectFit
        // leftImage.tag = index
        
        //Image1.contentMode= .scaleAspectFill
        // Image1.titleEdgeInsets = UIEdgeInsetsMake(0, , 0, 0)
        rightImage.imageView?.contentMode = .scaleAspectFit
        rightImage.setImage(recipe2.recipeImage(), for: UIControlState.normal)
        //rightImage.tag = index + 1
        //Image2.imageView?.contentMode = .scaleAspectFit
        leftPair = (recipe1, tappedLeft)
        rightPair = (recipe2, tappedRight)
        
        
    }
    
    func leftButton()->UIButton?{
        return leftImage
    }
    
    func rightButton()->UIButton?{
        return rightImage
    }
    
    func returnLeftPair() -> (RecipeSearchModel, Bool)?{
        return leftPair!
        
    }
    
    func returnRightPair() -> (RecipeSearchModel, Bool)?{
        return rightPair!
        
    }
}

