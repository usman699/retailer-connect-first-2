//
//  HManageExpensesCell.swift
//  retailer-connect-first
//
//  Created by Spark on 30/11/2023.
//

import UIKit

class HManageExpensesCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setViewSettingWithBgShade(view:view)
        // Initialization code
    }

    @IBOutlet weak var view: UIView!
}
