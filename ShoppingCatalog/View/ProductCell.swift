//
//  ProductCell.swift
//  ShoppingCatalog
//
//  Created by vlaghane on 12/10/17.
//  Copyright © 2017 SClub. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var shortDescriptionTxt: UITextField!
    @IBOutlet weak var shortDecription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func descriptionHTMLConversion(htmlString: String ){

    let theString = htmlString // "<h1>H1 title</h1><b>Logo</b><img src='http://www.aver.com/Images/Shared/logo-color.png'><br>~end~"
    
//    let theAttributedString = try! NSAttributedString(data: theString.dataUsingEncoding(NSUTF8StringEncoding,
//                                                                                        allowLossyConversion: false)!,
//                                                      options: ,
//                                                      documentAttributes: nil)
    
        let attrString = try! NSAttributedString(data: theString.data(using: String.Encoding.utf8,allowLossyConversion: false)!,
                                                 options: [.documentType: NSAttributedString.DocumentType.html,
                                                           .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes: nil )
        
        self.shortDescriptionTxt.attributedText = attrString
     }
}
