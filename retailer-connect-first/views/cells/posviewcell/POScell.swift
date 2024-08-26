//
//  POSTableViewCell.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 27/03/2024.
//

import UIKit

class POSTableViewCell: UITableViewCell {
    @IBOutlet weak var tax: UILabel!
    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var quantitylable: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var product: UILabel!
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var indexumber: UILabel!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var discount: UITextField!
    var buttons = [UIButton]()
    @IBOutlet weak var plus: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        buttons = [minus , plus, delete]
        for i in buttons{
            i.setTitle("", for: .normal)
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
