
//
//  viewusercell.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 13/05/2024.
//

import UIKit
import UIKit
protocol updateexpence: AnyObject {
    func updateExpense( selected:orignaldataviewcustomer)
}

protocol deleteexpence: AnyObject {
    func deleteCusomer( selected:orignaldataviewcustomer)
}
//protocol SwitchCellDelegate: AnyObject {
//    func switchStateChanged(atIndex index: Int, newState: Bool)
//}

class viewexpensecell: UITableViewCell {
    var switchTapAction: ((Bool) -> Void)?
    var switchingstates: [Bool] = []

    @IBOutlet weak var view: SetShadow!
    var color: UIColor!
    weak  var deleted:updateexpence!
    weak  var editt:updateexpence!
    public func colorset(color1: UIColor) {
        color = color1
        view.backgroundColor = color
    }
   
    var id = Int()
    var model = peoplesviewmodel()
    var currentElements: orignaldataviewcustomer?
    @IBOutlet weak var switchbutton: CustomSwitch!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var branch: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var customername: UILabel!
    @IBOutlet weak var index: UILabel!
    weak var disapear: Disapear?
    weak var delegate: SwitchCellDelegate?
        var cellIndex: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        edit.setTitle("", for: .normal)
        delete.setTitle("", for: .normal)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            edit.isUserInteractionEnabled = true
            edit.addGestureRecognizer(tapGestureRecognizer)
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer:)))
            delete.isUserInteractionEnabled = true
            delete.addGestureRecognizer(tapGestureRecognizer2)
        // Check if color is not nil before using it
        if let cellColor = color {
            // Set the background color of the entire cell's content view
            contentView.backgroundColor = cellColor
            // Set the background color of the specific view (if needed)
            view.backgroundColor = cellColor
            // Optionally, set the background color of the stackView
            // stackView.backgroundColor = cellColor
        }

        // Initialization code
        switchbutton.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        }
        
        @objc func switchChanged(_ sender: UISwitch) {
            if let index = cellIndex {
                        delegate?.switchStateChanged(atIndex: index, newState: sender.isOn)
                    }
        }
    func configure(with element:orignaldataviewcustomer) {
        currentElements  = element
        id  = currentElements!.id
        switchbutton.isOn = element.status == "active"
    }
    @objc func imageTapped2(tapGestureRecognizer: UITapGestureRecognizer)
    {
        deleted.updateExpense(selected: currentElements!)

        // Your action
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("eidt")
    
        editt?.updateExpense(selected: currentElements!)

        // Your action
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
     print("cell is off screen")
        
        disapear?.vanish()
    }
}
        // Initialization code
    
   
   


