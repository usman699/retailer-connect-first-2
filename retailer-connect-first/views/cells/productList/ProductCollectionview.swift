//
//  ProductCollectionview.swift
//  retailer-connect-first
//
//  Created by Spark on 04/12/2023.
//

import UIKit

class ProductCollectionview: UICollectionViewCell {

    @IBOutlet weak var tt: UIButton!
    @IBOutlet weak var ss: UIButton!
    @IBOutlet weak var ff: UIButton!
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        ff.setTitle("", for: .normal)
        ss.setTitle("", for: .normal)
        tt.setTitle("", for: .normal)
        
        // Initialization code
    }

}
