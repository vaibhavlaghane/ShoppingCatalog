//
//  ProductDetailCollectionViewController.swift
//  ShoppingCatalog
//
//  Created by vlaghane on 12/12/17.
//  Copyright © 2017 SClub. All rights reserved.
//

import UIKit

private let productDetailCellIdentifier = "CellCollection"

class ProductDetailCollectionViewController:  UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
 

    
    var productsList = [Product]()
    var product :Product? = nil
    var currentProduct: Product? = nil
    var lastProduct : Product? = nil
    var nextProductInLine : Product? = nil
    var baseIndex = 0
    var  isfirstTimeTransform = true 
    var currentIndex =  0, lastTargetOffsetx = 0
    var selfViewWidth: CGFloat = 0
    var cellWidth: CGFloat = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        baseIndex = productsList.index(of: product!)!
        // Do any additional setup after loading the view.
        
        selfViewWidth = self.view.frame.size.width
       // cellWidth = self.collectionCell.frame.size.width
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return productsList.count 
    }

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productDetailCellIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        if   ( (baseIndex + indexPath.row)  < productsList.count  ) {
            let currentProduct = productsList[baseIndex + indexPath.row] //as! Product
            cell.cellLabel.text = currentProduct.productName
            cell.imageCell.image = currentProduct.imageData
            cell.longDescription.attributedText = Utility.descriptionHTMLConversion(htmlString:currentProduct.longDescription!)
            cell.shortDescription.attributedText = Utility.descriptionHTMLConversion(htmlString:currentProduct.shortDescription!)
            
            cell.price.text = currentProduct.price
            cell.reviewRating.text = String( currentProduct.reviewRating!)
            if currentProduct.inStock!{
               cell.InStock.text = "Yes"
            }else {
               cell.InStock.text = "No"
            }
            
            
        }
 
        cell.layer.borderColor = UIColor.red.cgColor
        
        // Configure the cell
    
        return cell
    }
 
    
 
    /// method to swipe view and load new view based on the scroll
    ///
    /// - Parameters:
    ///   - scrollView: UIScrollView
    ///   - velocity: velocity
    ///   - targetContentOffset: targetContentOffset
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let   pageWidth: CGFloat =    selfViewWidth
        let  currentOffset = scrollView.contentOffset.x;
        var  toffset = targetContentOffset.pointee
        let  targetOffset =  toffset.x;
        var  newTargetOffset = 0;
        
        if (targetOffset > currentOffset){
            print("  currentOffset)   \(currentOffset)  pageWidth === \(pageWidth )" )
            newTargetOffset = Int(ceilf( Float(CGFloat( currentOffset) / (pageWidth  ) )) * Float(pageWidth));
        }else{
            print("( currentOffset)  \( currentOffset)   pageWidth === \( pageWidth )" )
            newTargetOffset = Int(floorf(Float(currentOffset / (pageWidth   ) )) * Float(pageWidth));
        }
    
        if (newTargetOffset < 0){
            newTargetOffset = 0;
        }else if ( CGFloat( newTargetOffset)  > scrollView.contentSize.width){
            newTargetOffset = Int(scrollView.contentSize.width);
        }
    
        print("newTargetOffset -\(newTargetOffset) toffset.x \(toffset.x)  currentIndex \(currentIndex)")
        
        if (newTargetOffset == 0    && toffset.x == 0) {
            self.navigationController?.popToRootViewController(animated: true)
        }
        toffset.x = currentOffset;
        scrollView.setContentOffset( CGPoint.init(x: CGFloat( newTargetOffset) , y: 0)   , animated: true)
        scrollView.setContentOffset( CGPoint.init(x: CGFloat( newTargetOffset) , y: 0)   , animated: true)
        scrollView.setContentOffset( CGPoint.init(x: CGFloat( newTargetOffset) , y: 0)   , animated: true)
    }
    

 

}
