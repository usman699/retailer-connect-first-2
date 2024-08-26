//
//  viewproducts.swift
//  retailer-connect-first
//
//  Created by Spark on 21/12/2023.
//

import UIKit

class viewproducts: UITableViewCell {
    @IBOutlet weak var images: UIImageView!
    var color: UIColor!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var stackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        images.layer.cornerRadius = images.frame.size.width / 2
               images.clipsToBounds = true
        if let cellColor = color {
            // Set the background color of the entire cell's content view
            contentView.backgroundColor = cellColor
            UIElementsManager.shared.setViewSettingWithBgShade(view: stackView)
            UIElementsManager.shared.setViewSettingWithBgShade(view: view)
            // Set the background color of the specific view (if needed)
            view.backgroundColor = cellColor

            // Optionally, set the background color of the stackView
            // stackView.backgroundColor = cellColor
        }
        // Initialization code
    }

    public func colorset(color1: UIColor) {
        color = color1
        view.backgroundColor = color
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
