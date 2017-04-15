//
//  RecipeSearchCollectionViewController.swift
//  FoHo
//
//  Created by Brittney Ryn on 4/12/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RecipeCell"
var screenSize: CGRect!
var screenWidth: CGFloat!


class RecipeSearchCollectionViewController: UICollectionViewController, RecipeSearchLayoutDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        //screenSize = UIScreen.main.bounds
        //screenWidth = screenSize.width
       // let screenHeight = screenSize.height

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.register(RecipeSearchCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.headerReferenceSize = CGSize(width: 0, height: 40)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
       // collectionView?.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RecipeSearchCollectionViewCell
       // cell.setCell(uri: "https://lh3.googleusercontent.com/D36cUXzg0nWMhpP0IrmSd-kAin41Z9Kk1cseZlYCbM3jliYuOqhA-CrBYlqvGxWRxu1OlCFY1gkURB6IbPjXkA=s90-c", label: "Cookie")
    /*  if let theCell = cell as? RecipeSearchCollectionViewCell{
            theCell.setCell(uri: "https://lh3.googleusercontent.com/D36cUXzg0nWMhpP0IrmSd-kAin41Z9Kk1cseZlYCbM3jliYuOqhA-CrBYlqvGxWRxu1OlCFY1gkURB6IbPjXkA=s90-c", label: "Cookie")
          // return theCell
        }
        */
    
        // Configure the cell
        cell.backgroundColor = UIColor.purple
    
        return cell
    }

    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
