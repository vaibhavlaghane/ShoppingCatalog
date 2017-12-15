//
//  NetworkOperationManager.swift
//  ShoppingCatalog
//
//  Created by vlaghane on 12/9/17.
//  Copyright © 2017 SClub. All rights reserved.
//

import UIKit

class PendingOperations {
    lazy var downloadsInProgress = [Int:Operation]()
    lazy var downloadQueue:OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}

/// network operations manager class
class NetworkOperationManager: NSObject {

    @objc dynamic var animals = [String]()
    @objc dynamic var cars = [String]()
    
    let downloader = DataDownloader()
    @objc  public dynamic var products = [Product]()
    let pendingOperations = PendingOperations()
    
 
    /// download JSON data for given page and size
    ///
    /// - Parameters:
    ///   - pageNumber: page number
    ///   - pageSize: size of page
    ///   - completion: completion block 
    func downloadData( pageNumber: Int,pageSize: Int,  completion: @escaping ([Product]? ) -> Void )->Void{
        downloader.getJSONData(pageNumber: pageNumber, pageSize: pageSize, completion: { (dict) in
            
            let productList = Utility.parseJSON(dict: dict)
            self.products.append(contentsOf:productList  )
            
            completion(productList)
            
            for (index, element) in self.products.enumerated(){
                self.startDownloadProductImage(product: element, index: index )
            }
        }) { (response, error) in   //
            
            Utility.showAlertMessage("Failed to Download the Content", withTitle: "Download Update", onClick: {
                
                NSLog(error as! String)
            })
                
            NSLog(error as! String)
        }
    }
    
    
    /// starte image download operation
    ///
    /// - Parameters:
    ///   - product: product
    ///   - index: index of product 
    func startOperationsProduct(product: Product, index: Int){
        switch (product.isImageDownloaded) {
        case .New:
            startDownloadProductImage(product: product, index: index)
        default:
            NSLog("do nothing")
        }
    }
    
    /// method starts the image download operation on the OperationQueue
    ///
    /// - Parameters:
    ///   - product: product to download the image for
    ///   - indexPath: index of the product in the array
    func startDownloadProductImage(product: Product, index: Int){
        
        if let _ = pendingOperations.downloadsInProgress[index ] {
            return
        }
        let downloader = ImageDownloader(product: product)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: index )
            }
        }

        pendingOperations.downloadsInProgress[index ] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
}
