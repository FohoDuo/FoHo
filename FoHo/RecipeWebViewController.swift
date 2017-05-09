//
//  RecipeWebViewController.swift
//  FoHo
//
//  Created by Scott Williams on 4/14/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit

class RecipeWebViewController: UIViewController {
    
    var webUrl: String?

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: webUrl!)
        webView.loadRequest(URLRequest(url: url!))
    }

    
    //set the web url from the previous view
    func setUrl(url: String) {
        webUrl = url
    }
}
