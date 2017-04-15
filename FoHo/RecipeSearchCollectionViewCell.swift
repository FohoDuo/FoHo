//
//  RecipeSearchCollectionViewCell.swift
//  FoHo
//
//  Created by Brittney Ryn on 4/12/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import FaveButton





class RecipeSearchCollectionViewCell: UICollectionViewCell {
    
   

    @IBOutlet var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeName: UILabel!
    
   /* override init(frame: CGRect){
        super.init(frame: frame)
        screenSize = UIScreen.main.bounds
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth / 3, height: screenWidth / 3)

    }*/

    
    override func awakeFromNib() {
        super.awakeFromNib()
       // RecipeSearchCollectionViewCell.minimumInteritemSpacing = 0 //add your spacing
       // RecipeSearchCollectionViewCell.
        // Initialization code
    }
    
    
    func setCell(uri: String, label: String){
        print(label)
        print(uri)
        if let url = URL(string: uri),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data) {
            print(image)
            recipeImage.image = image
        }
        recipeName.text = label
        // self.layer.contents = (id)[UIImage imageNamed:recipeImage].CGImage;
        recipeImage.contentMode = .scaleAspectFit
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
    
    
}
