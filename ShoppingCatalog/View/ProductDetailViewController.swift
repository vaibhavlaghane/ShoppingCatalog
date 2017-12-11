//
//  ProductDetailViewController.swift
//  ShoppingCatalog
//
//  Created by vlaghane on 12/10/17.
//  Copyright © 2017 SClub. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet var leftGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var rightSwipeGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet weak var longDescriptionTxtView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shortDescriptionTxtView: UITextView!
    
    @IBOutlet weak var productLabel: UILabel!
    
    var productsList = [Product]()
    var product :Product? = nil
    var lastProduct : Product? = nil
    var nextProductInLine : Product? = nil
    
    
    
    
    @IBAction func swipeLeftCalled(_ sender: Any) {
        print("swipeLeftCalled")
    }
    
    @IBAction func swipeRightCalled(_ sender: Any) {
        print("swipeRightCalled")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let prd = product {
        self.shortDescriptionTxtView.attributedText =  Utility.descriptionHTMLConversion(htmlString:  (prd.shortDescription)! )
        self.longDescriptionTxtView.attributedText = Utility.descriptionHTMLConversion(htmlString: (prd.longDescription)! )
            
            productLabel.text = prd.productName
            
            if(prd.imageData != nil ){
            self.imageView.image = prd.imageData
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
