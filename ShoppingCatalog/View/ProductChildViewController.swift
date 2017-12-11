//
//  ProductChildViewController.swift
//  ShoppingCatalog
//
//  Created by vlaghane on 12/10/17.
//  Copyright © 2017 SClub. All rights reserved.
//

import UIKit

class ProductChildViewController: UIViewController {
    
    public var product:Product?
    
    @IBOutlet public weak var imageView: UIImageView!
    @IBOutlet public weak var shortDescriptionTxtView: UITextView!
    @IBOutlet public weak var longDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let prd = product {
            self.shortDescriptionTxtView.attributedText =  Utility.descriptionHTMLConversion(htmlString:  (prd.shortDescription)! )
            self.longDescription.attributedText = Utility.descriptionHTMLConversion(htmlString: (prd.longDescription)! )
            
            //productLabel.text = prd.productName
            
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
