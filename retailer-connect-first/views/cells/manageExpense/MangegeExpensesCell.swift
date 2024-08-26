//
//  MangegeExpensesCell.swift
//  retailer-connect-first
//
//  Created by Spark on 30/11/2023.
//

import UIKit

class MangegeExpensesCell: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var tb: UIButton!
    @IBOutlet weak var sb: UIButton!
    @IBOutlet weak var fb: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        fb.setTitle("", for: .normal)
        sb.setTitle("", for: .normal)
        tb.setTitle("", for: .normal)
        // Initialization code
    }

}
