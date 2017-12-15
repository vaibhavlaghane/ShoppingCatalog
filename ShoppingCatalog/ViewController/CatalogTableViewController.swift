//
//  CatalogTableViewController.swift
//  ShoppingCatalog
//
//  Created by vlaghane on 12/10/17.
//  Copyright © 2017 SClub. All rights reserved.
//

import UIKit

class CatalogTableViewController: UITableViewController {

    var catalogList = [Product]()
    @objc var netOp = NetworkOperationManager()
    var pageNumber = 1;
    var pageSize = 30 ;
 
    override func viewDidLoad() {
        super.viewDidLoad()
     
        netOp.downloadData(pageNumber: pageNumber, pageSize: pageSize) { (products) in
            self.catalogList = self.netOp.products
            self.pageNumber = self.pageNumber + self.pageSize ;
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catalogList = netOp.products
        
        
        self.tableView.estimatedRowHeight =   UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 55.0;
        
        tableView.addInfiniteScroll { (tableView) -> Void in
            // update table view
            
            self.netOp.downloadData(pageNumber: self.pageNumber, pageSize: 20) { (products) in
                self.catalogList = self.netOp.products
                self.pageNumber = self.pageNumber + self.pageSize  ;
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    // finish infinite scroll animation
                    tableView.finishInfiniteScroll()
                }
            }
        
        }
        
        tableView.finishInfiniteScroll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catalogList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var  cellP = tableView.dequeueReusableCell(withIdentifier: kCatalogCellIdentifier, for: indexPath) as? ProductCell
        if let cell = cellP {
       
        // Configure the cell...
            if (indexPath.row < catalogList.count){
                let prd = catalogList[indexPath.row] 
                cell.productNameLabel.text = prd.productName
            }
        return cell
            
        }
        cellP = ProductCell()
        return cellP!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: kshowCollectionViewdentifier, sender: indexPath);
    }
    
    /*
     MARK: - Navigation
     In a storyboard-based application, you will often want to do a little preparation before navigation  */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
 
        
        
        if (segue.identifier == kshowCollectionViewdentifier){
            
            let destViewController                  =   segue.destination as! CollectionViewController
            let indexPath = sender as? IndexPath
            destViewController.product           =   catalogList[(indexPath?.row)!]
            destViewController.productsList = catalogList
            
             
            
        }
    }
 
 
    deinit {
        removeObserver(self, forKeyPath: "products")
    }

}
