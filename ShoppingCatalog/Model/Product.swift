//
//  Product.swift
//  ShoppingCatalog
//
//  Created by vlaghane on 12/9/17.
//  Copyright © 2017 SClub. All rights reserved.
//

import UIKit

enum ImageDownLoadState:String  {
    case New
    case Downloaded
    case InProgress
    case Failed
}

class Product: NSObject {

    var productId: String?
    var productName: String?
    var shortDescription: String?
    var longDescription: String?
    var price: String?
 
    var reviewRating: Int?
    var reviewCount: Int?
    var inStock: Bool?
    var imageData: UIImage?
    var isImageDownloaded: ImageDownLoadState = .New 
    
    var imageURL: URL? = nil 
    var imagelink: String?{
        didSet{
            if( imagelink != nil ){
                imageURL = URL.init(string: imagelink!)
            }
        }
    }
    
     init(productId: String?,
          productName: String?,
          shortDescription: String?,
          longDescription: String?,
          price: String?,
          imagelink: String?,
          reviewRating: Int?,
          reviewCount: Int?,
          inStock: Bool?)
     {
        self.productId = productId ?? ""
        self.productName = productName ?? ""
        self.imagelink = imagelink ?? ""
        self.reviewRating = reviewRating ?? 0
        self.reviewCount = reviewCount ?? 0
        self.inStock = inStock ?? false
        self.price = price ?? "$0"
        self.longDescription = longDescription ?? ""
        self.shortDescription = shortDescription ?? ""
        
        if( self.imagelink != nil ){
            imageURL = URL.init(string: self.imagelink!)
        }
        
    }
    
    
}
