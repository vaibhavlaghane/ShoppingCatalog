//
//  ImageDownloader.swift
//  ShoppingCatalog
//
//  Created by vlaghane on 12/9/17.
//  Copyright © 2017 SClub. All rights reserved.
//

import UIKit

class ImageDownloader: Operation {
    
    var  product: Product
    var  imageData: Data? = nil
    
    init(product: Product) {
        self.product = product
        print("imageURL " , self.product.imagelink ?? "")
        print("imageURL " , self.product.imageURL?.absoluteString ?? "")
    }
    
    override func main() {
        
        if self.isCancelled   {
            return
        }
        
        if let imgURL = self.product.imageURL{
            imageData =   try? Data(contentsOf: imgURL)
        }else{
           
            product.isImageDownloaded = .Failed
            return
                //log - imageURL is nil, cannot download the image
        }
      
        
        if imageData != nil {
            self.product.imageData = UIImage(data:imageData!)
            self.product.isImageDownloaded = .Downloaded
        }
        else
        {
            self.product.isImageDownloaded = .Failed
            self.product.imageData = UIImage(named: "Failed")
        }
    }
    
}
