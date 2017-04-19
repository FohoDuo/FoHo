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
    
    @IBOutlet var Image1: UIButton!
    @IBOutlet var Image2: UIButton!
    
    var tappedOne: Bool = false
    var tappedTwo: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapImage1(_ sender: UIButton) {
        tappedOne = true
    }
    
    
    @IBAction func didTapImage2(_ sender: UIButton) {
        tappedTwo = true
    }
    
    func setCell(image: UIImage, image2: UIImage, label: String, label2: String){
        
        Image1.setImage(image, for: UIControlState.normal)
        Image2.setImage(image2, for: UIControlState.normal)
       // Image1.isTouchInside
        //print(label)
        //print(uri)
        //if let url = URL(string: uri),
        //let data = try? Data(contentsOf: url),
        //let image = UIImage(data: data) {
        //print(image)
       // recipeImage?.image = image
        // }
        //recipeName?.text = label
        // self.layer.contents = (id)[UIImage imageNamed:recipeImage].CGImage;
        //recipeImage?.contentMode = .scaleAspectFit
        // recipeName.bringSubview(toFront: label)
        //heartButton.view.layer.zPosition = 1;
        //let y = recipeName?.frame.origin.y + recipeName?.font.ascender + 15
        /*let heartButton = FaveButton(
         frame: CGRect(x:30, y:40, width: 33, height: 35),
         faveIconNormal: UIImage(named: "heart")
         )
         heartButton.delegate = self
         superview?.addSubview(heartButton)*/
        // superview?.bringSubview(toFront: recipeName)
        //superview?.bringSubview(toFront: heartButton)
        
    }
    
    func returnButtons() -> [(UIButton, Bool)]{
        return [(Image1, tappedOne), (Image2, tappedTwo)]
        
    }

}
