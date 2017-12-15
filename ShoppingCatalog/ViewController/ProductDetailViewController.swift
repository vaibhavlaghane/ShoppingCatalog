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
    
    var selfView : UIView?
    var productsList = [Product]()
    var product :Product? = nil
    var currentProduct: Product? = nil
    var lastProduct : Product? = nil
    var nextProductInLine : Product? = nil
   
    
    @IBAction func swipeLeftCalled(_ sender: Any) {
      
        let vc = ProductChildViewController(nibName: kProductChildViewControllerNibName, bundle: nil )
        if  let currentIndex = productsList.index(of: currentProduct!){
            if currentIndex + 1 < productsList.count{
                nextProductInLine = productsList[ currentIndex + 1]
                vc.product = nextProductInLine//productsList[ currentIndex + 1]\
                currentProduct = nextProductInLine
                
            }
        }
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.layer.add(transition, forKey: nil)
        let  ct:CGRect = vc.view.frame
        print("ct", ct );
        self.view.addSubview(vc.view)
        
    }
    
    @IBAction func swipeRightCalled(_ sender: Any) {
        let view = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view.backgroundColor = UIColor.red
        
        let vc = ProductChildViewController(nibName: kProductChildViewControllerNibName, bundle: nil )
        if  let currentIndex = productsList.index(of: currentProduct!){
            if currentIndex > 0{
                nextProductInLine = productsList[ currentIndex - 1 ]
                vc.product = nextProductInLine
                currentProduct = nextProductInLine
                
            }
        }
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.layer.add(transition, forKey: nil)
        self.view.addSubview(vc.view)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        if let prd = product {
            currentProduct = prd
            
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
