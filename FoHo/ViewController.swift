//
//  ViewController.swift
//  FoHo
//
//  Created by Scott Williams on 4/8/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit
import FaveButton

class ViewController: UIViewController {

    @IBOutlet weak var b1: UIButton!
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        let faveButton = FaveButton(
            frame: CGRect(x:200, y:200, width: 44, height: 44),
            faveIconNormal: UIImage(named: "heart")
        )
        faveButton.delegate = self
        view.addSubview(faveButton)
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

