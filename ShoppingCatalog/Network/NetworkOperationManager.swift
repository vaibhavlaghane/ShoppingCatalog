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
    
    //    lazy var filtrationsInProgress = [NSIndexPath:Operation]()
    //    lazy var filtrationQueue:OperationQueue = {
    //        var queue = OperationQueue()
    //            queue.name = "Image Filtration queue"
    //            queue.maxConcurrentOperationCount = 1
    //            return queue
    //        }()

}
class NetworkOperationManager: NSObject {

    let downloader = DataDownloader()
    var products = [Product]()
    let pendingOperations = PendingOperations()
   
    func downloadData()->Void{
        downloader.getJSONData(pageNumber: 1, pageSize: 30, completion: { (dict) in
            self.products = Utility.parseJSON(dict: dict)
            
            for (index, element) in self.products.enumerated(){
                self.startDownloadProductImage(product: element, index: index )
            }
        }) { (response, error) in   //
            NSLog(error as! String)
        }
    }
 
    
    func downloadData( pageNumber: Int,pageSize: Int,  completion: @escaping ([Product]? ) -> Void )->Void{
        downloader.getJSONData(pageNumber: pageNumber, pageSize: pageSize, completion: { (dict) in
            
            let productList = Utility.parseJSON(dict: dict)
            self.products.append(contentsOf:productList  )// = Utility.parseJSON(dict: dict)
            
            completion(productList)
            
            for (index, element) in self.products.enumerated(){
                self.startDownloadProductImage(product: element, index: index )
            }
        }) { (response, error) in   //
            NSLog(error as! String)
        }
    }
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
               // self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        }

        pendingOperations.downloadsInProgress[index ] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
}
