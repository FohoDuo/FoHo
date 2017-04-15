//
//  RecipeWebViewController.swift
//  FoHo
//
//  Created by Scott Williams on 4/14/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit

//View controller class for displaying a recipe's instructions since
//the yummily API only provides the url to the instructions
class RecipeWebViewController: UIViewController {
    
    var webUrl: String?

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //cast the specific url string
        let url = URL(string: webUrl!)
        
        //load the web page
        webView.loadRequest(URLRequest(url: url!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //set the web url from the previous view
    func setUrl(url: String) {
        webUrl = url
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
