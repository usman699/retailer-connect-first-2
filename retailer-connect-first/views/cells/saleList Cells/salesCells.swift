//
//  sales.swift
//  retailer-connect-first
//
//  Created by Spark on 07/02/2024.
//

import UIKit
protocol orderDelegate{
    func orderAlerts()
}
class salesCells: UITableViewCell {
    @IBOutlet weak var stackview: UIStackView!
    var color: UIColor!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var discount: UILabel!
    var delegate: orderDelegate?
    @IBOutlet weak var pad: UILabel!
    @IBOutlet weak var totalBill: UILabel!
    @IBOutlet weak var tax: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var serialNumber: UILabel!
    @IBAction func menuButton(_ sender: Any) {
       
        delegate?.orderAlerts()
    }
    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        if let cellColor = color {
            // Set the background color of the entire cell's content view
            contentView.backgroundColor = cellColor
            UIElementsManager.shared.setViewSettingWithBgShade(view: stackview)
            UIElementsManager.shared.setViewSettingWithBgShade(view: view)
            // Set the background color of the specific view (if needed)
            view.backgroundColor = cellColor

            // Optionally, set the background color of the stackView
            // stackView.backgroundColor = cellColor
        }
        
        
        
        button.setTitle("", for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func colorset(color1: UIColor) {
        color = color1
        view.backgroundColor = color
    }
}
