//
//  Utility.swift
//  ShoppingCatalog
//
//  Created by vlaghane on 12/9/17.
//  Copyright © 2017 SClub. All rights reserved.
//

import UIKit

class Utility: NSObject {

   /// parse the json
   ///
   /// - Parameter dict: dictonary JSON
   /// - Returns: array of Product
   static func parseJSON(dict: Dictionary<String, Any>?)-> [Product] {
       // self.setupLoadingIndicator(start: false)
        guard let jsonDict   = dict  else{return [] }
        //guard let idArr = jsonDict["id"]  else {return}
        guard let prodArr = jsonDict["products"] as? Array<Any?> else {return  [] }
        
//        let totalProducts     = jsonDict["totalProducts"]
//        let pageNumber     = jsonDict["pageNumber"]
//        let pageSize     = jsonDict["pageSize"]
//        let status     = jsonDict["status"]
//        let kind     = jsonDict["kind"]
//        let etag     = jsonDict["etag"]
//
        var products = [Product]()
        
        for (_,element) in prodArr.enumerated(){
            
            if  let prd = element as? Dictionary< String, Any>{

                let productID = prd["productId"] ?? ""
                let productName = prd["productName"] ?? ""
                let shortDescription = prd["shortDescription"] ?? ""
                let longDescription = prd["longDescription"] ?? ""
                let price = prd["price"] ?? ""
                let productImage = prd["productImage"] ?? ""
                let reviewRating = prd["reviewRating"] ?? 0
                let reviewCount = prd["reviewCount"] ?? 0
                let inStock = prd["inStock"] ?? false
                
                let product = Product(productId:productID as? String  ,
                                      productName: productName  as? String ,
                                      shortDescription: shortDescription as? String ,
                                      longDescription: longDescription as? String ,
                                      price: price as? String ,
                                      imagelink: productImage as? String ,
                                      reviewRating: reviewRating  as? Int,
                                      reviewCount: reviewCount as? Int,
                                      inStock: inStock  as? Bool)
                
                products.append(product)
          
            }
        }
        
        return products
    }
}
