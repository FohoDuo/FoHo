//
//  RecipeSearchTableViewCell.swift
//  FoHo
//
//  Created by Brittney Ryn on 4/8/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import FaveButton

class RecipeSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
  //  @IBOutlet weak var heartButton: FaveButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(uri: String, label: String){
            if let url = URL(string: uri),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                recipeImage.image = image
        }
        recipeName.text = label
       // self.layer.contents = (id)[UIImage imageNamed:recipeImage].CGImage;
        recipeImage.contentMode = .scaleAspectFit
       // recipeName.bringSubview(toFront: label)
        //heartButton.view.layer.zPosition = 1;
        let y = recipeName.frame.origin.y + recipeName.font.ascender + 15
        let heartButton = FaveButton(
            frame: CGRect(x:350, y:y, width: 33, height: 35),
            faveIconNormal: UIImage(named: "heart")
        )
        heartButton.delegate = self
        superview?.addSubview(heartButton)
        superview?.bringSubview(toFront: recipeName)
        //superview?.bringSubview(toFront: heartButton)
    }
    

    
    
}
