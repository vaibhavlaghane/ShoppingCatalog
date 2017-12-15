//
//  NetworkManager.swift
//  ShoppingCatalog
//
//  Created by vlaghane on 12/9/17.
//  Copyright © 2017 SClub. All rights reserved.
//

import UIKit

struct Constants {
    struct APIDetails {
        static let APIScheme = "https"
        static let APIHost = "walmartlabs-test.appspot.com"
        static let APIPath = "/_ah/api/walmart/v1/walmartproducts/"
        static let APIKey = "56330880-82c2-47eb-9d5d-03db3a49e3bf"
    }
}

class DataDownloader: NSObject {

    /// function call to get JSON data
    /// completion block handles the received JSON
    /// - Returns: none
    internal func getJSONData( pageNumber: Int, pageSize: Int  , completion: @escaping (Dictionary<String, Any >? ) -> Void , failure: @escaping (URLResponse? , Error? ) -> Void  )->Void   {
       
        var pageNumStr = String( pageNumber)
        var pageSizeStr = String(pageSize)
        if   pageNumber < 1  {
            pageNumStr = "1"
        }
        if (pageSize > 30 || pageSize < 1){
            pageSizeStr = "30"
        }
        
        let urlUsr = createURLFromParameters(  pageSizeStr,  pageNumStr) ;
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: urlUsr  )
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
        session.dataTask(with: request as URLRequest){(data: Data?,response: URLResponse?, error: Error?) -> Void in
            if let responseData = data
            {
                do{
                    let json = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments)
                    //print(json)
                    completion(json as? Dictionary<String, Any >)
                }catch{
                    print("Could not serialize")
                    completion(nil)
                }
            }
            }.resume()
    }

    ///  function to create URL using the paramenters
    /// - Parameters:
    ///   - pageSize: page size
    ///   - pageNumber: page number 
    /// - Returns: url
    internal func createURLFromParameters(_ pageSize:  String, _ pageNumber: String ) -> URL {
        
        var components      = URLComponents()
        components.scheme   = Constants.APIDetails.APIScheme
        components.host     = Constants.APIDetails.APIHost
        components.path     = Constants.APIDetails.APIPath + "\(Constants.APIDetails.APIKey)" + "/\(pageNumber)" + "/\(pageSize)/" ;
        
        return components.url!
    }
}
