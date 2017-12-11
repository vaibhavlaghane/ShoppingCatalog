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
    var netOp = NetworkOperationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        netOp.downloadData(pageNumber: 1, pageSize: 20) { (products) in
            self.catalogList = self.netOp.products
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catalogList = netOp.products
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.estimatedRowHeight =   UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 55.0;
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
               // cell.priceLabel.text = prd.price
                cell.productNameLabel.text = prd.productName
                //cell.shortDescriptionTxt.text  = prd.shortDescription
                //cell.descriptionHTMLConversion(htmlString: prd.shortDescription ?? "")
            }
        return cell
            
        }
        cellP = ProductCell()
        return cellP!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //selectedSprint = tableSprintNames[indexPath.row].sprintName
            self.performSegue(withIdentifier: kshowProductDetailsdentifier, sender: indexPath);
    }
    
    /*
     MARK: - Navigation
     In a storyboard-based application, you will often want to do a little preparation before navigation  */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == kshowProductDetailsdentifier{
            let destViewController                  =   segue.destination as! ProductDetailViewController
            let indexPath = sender as? IndexPath
            destViewController.product           =   catalogList[(indexPath?.row)!]
            destViewController.productsList = catalogList
//            destViewController.projectName          =   projectName //  "Mobile
        }
    }
 
 

}
