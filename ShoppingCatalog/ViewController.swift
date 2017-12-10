//
//  ViewController.swift
//  ShoppingCatalog
//
//  Created by Vaibhav N Laghane on 12/9/17.
//  Copyright © 2017 SClub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let netOP = NetworkOperationManager()
        netOP.downloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

