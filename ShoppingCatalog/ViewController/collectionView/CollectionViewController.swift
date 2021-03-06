// Copyright 2017 Brightec
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit

let contentCellIdentifier = "ContentCellIdentifier"

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var productsList = [Product]()
    var product :Product? = nil
    var currentProduct: Product? = nil
 
    var currentIndex =  0
    var selfViewWidth: CGFloat = 0
    var initialIndex = false

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: contentCellIdentifier)

        selfViewWidth = self.view.frame.size.width
        let pIndex = productsList.index(of: product!)
        currentIndex = pIndex!
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
            newTargetOffset = Int(ceilf( Float(CGFloat( currentOffset) / (pageWidth  ) )) * Float(pageWidth));
        }else{
            newTargetOffset = Int(floorf(Float(currentOffset / (pageWidth   ) )) * Float(pageWidth));
        }
        
        if (newTargetOffset < 0){
            newTargetOffset = 0;
        }else if ( CGFloat( newTargetOffset)  > scrollView.contentSize.width){
            newTargetOffset = Int(scrollView.contentSize.width);
        }

        toffset.x = currentOffset;
        scrollView.setContentOffset( CGPoint.init(x: CGFloat( newTargetOffset) , y: 0)   , animated: true)
        
    }

}

// MARK: - UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsList.count 
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIdentifier,
                                                      for: indexPath) as! ContentCollectionViewCell
        let prod = productsList[indexPath.row]
        cell.labelProductName.text = prod.productName
        cell.imageVIew.image = prod.imageData
        cell.longDescription.attributedText = Utility.descriptionHTMLConversion(htmlString:   prod.longDescription! )
        cell.shortDescription.attributedText = Utility.descriptionHTMLConversion(htmlString: prod.shortDescription!)
 
        cell.rating.text = String(prod.reviewRating!)
        cell.price.text = prod.price
        if( prod.inStock == true  ){
        cell.inStock.text = "Yes"
        }else{ cell.inStock.text = "No"}
        return cell
    }

}

// MARK: - UICollectionViewDelegate
extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if( !initialIndex){
            let indextoScrollTo = IndexPath(item: currentIndex, section: 0)
            self.collectionView.scrollToItem(at: indextoScrollTo, at: .left, animated: false)
            initialIndex = true
        }
    }
}

