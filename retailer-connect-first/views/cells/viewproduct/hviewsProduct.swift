//
//  hviewsProduct.swift
//  retailer-connect-first
//
//  Created by Spark on 21/12/2023.
//

import UIKit

class hviewsProduct: UITableViewCell {
    @IBOutlet weak var view: UIView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        UIElementsManager.shared.setViewSettingWithBgShade(view: view)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
