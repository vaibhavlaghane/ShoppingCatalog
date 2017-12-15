//
//  ProductCollectionViewCell.swift
//  ShoppingCatalog
//
//  Created by vlaghane on 12/12/17.
//  Copyright © 2017 SClub. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shortDescription: UITextView!
    @IBOutlet weak var longDescription: UITextView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var reviewRating: UILabel!
    @IBOutlet weak var InStock: UILabel!
    
}
