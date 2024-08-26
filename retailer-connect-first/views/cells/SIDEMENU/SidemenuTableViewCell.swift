//
//  SidemenuTableViewCell.swift
//  retailer-connect-first
//
//  Created by Spark on 29/11/2023.
//

import UIKit

class SidemenuTableViewCell: UITableViewCell {
    @IBOutlet weak var arrow: UIImageView!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
        // Configure the view for the selected state
    }
    
}
