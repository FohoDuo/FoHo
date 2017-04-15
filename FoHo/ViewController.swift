//
//  ViewController.swift
//  FoHo
//
//  Created by Scott Williams on 4/8/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import FaveButton
import Alamofire

class ViewControllerTEST: UIViewController {

    @IBOutlet weak var b1: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //By initializing UISearchController without a searchResultsController, you are telling the search controller that you want use the same view that you’re searching to display the results. If you specify a different view controller here, that will be used to display the results instead.
    //let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
     

        
        
        
        
        
        
        
        
        
    //sample fave button usage
        let faveButton = FaveButton(
            frame: CGRect(x:200, y:200, width: 44, height: 44),
            faveIconNormal: UIImage(named: "heart")
        )
        faveButton.delegate = self
        view.addSubview(faveButton)
        
    //sample get JSON
        let url = "http://api.yummly.com/v1/api/recipes?_app_id=42432972&_app_key=ec024a2414433825635ad1d304916ee2&q=buddha+bowl&maxResult=10&start=10"
        Alamofire.request(url).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
    //sample code to populate objects with JSON
            let test = response.result.value
            let recipes = Recipes(dataSource: test)
            
            for i in 0...recipes.numRecipes() - 1 {
                print(recipes.at(i).recipeName())
            }
            

        }
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

