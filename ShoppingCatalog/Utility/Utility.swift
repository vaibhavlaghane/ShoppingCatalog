//
//  Utility.swift
//  ShoppingCatalog
//
//  Created by vlaghane on 12/9/17.
//  Copyright © 2017 SClub. All rights reserved.
//

import UIKit

class Utility: NSObject {

   /// function to process html string
   ///
   /// - Parameter htmlString: html inpit
   /// - Returns: attributed string
   static func descriptionHTMLConversion(htmlString: String )-> NSAttributedString{
        
        let theString = htmlString
        let attrString = try! NSAttributedString(data: theString.data(using: String.Encoding.utf8,allowLossyConversion: false)!,
                                                 options: [ .documentType: NSAttributedString.DocumentType.html,
                                                            .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes: nil )
        
        return attrString
    }
    
    
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
    
    
    
    class func showAlertMessage(_ message: String, withTitle title: String, onClick completion: @escaping () -> Void) {
        let alert = UIAlertController(title: " \(title)", message: message, preferredStyle: .alert)
        //Add Buttons
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            //Handle button action here
            completion()
        })
        alert.addAction(okButton)
        
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        rootViewController?.present(alert, animated: true, completion: nil)
    }
}
