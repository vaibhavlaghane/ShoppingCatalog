//
//  ContentCollectionViewCell.swift
//  CustomCollectionLayout
//
//  Created by JOSE MARTINEZ on 09/01/2015.
//  Copyright (c) 2015 brightec. All rights reserved.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var inStock: UILabel!
    @IBOutlet weak var longDescription: UITextView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var shortDescription: UITextView!
    @IBOutlet weak var imageVIew: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
