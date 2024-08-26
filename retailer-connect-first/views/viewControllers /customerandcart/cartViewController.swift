//
//  cardViewController.swift
//  retailer-connect-first
//
//  Created by Spark on 22/12/2023.
//

import UIKit
import iOSDropDown
import SideMenu
class cardViewController: UIViewController {
    var menu:SideMenuNavigationController!
    @IBOutlet weak var pdf: UIButton!
  
    @IBAction func menuButton(_ sender: Any) {
        present(menu! , animated: true)
    }
    @IBOutlet weak var mainview: UIView!
    @IBAction func holdlist(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "product", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "addproduct")
        present(initialViewController, animated: false)
        
        
        
    }
    @IBOutlet weak var productbarcode: UITextField!
    @IBOutlet weak var holdButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
   
    @IBOutlet weak var secondtableview: UITableView!
    
    @IBOutlet weak var emptyCard: UIButton!
    @IBOutlet weak var generatebill: UIButton!
    @IBOutlet weak var received: UITextField!
    @IBOutlet weak var `return`: UITextField!
    @IBOutlet weak var grandTotal: UITextField!
    @IBOutlet weak var discounts: UITextField!
    @IBOutlet weak var orenageview: UIView!
    @IBOutlet weak var whiteview: UIView!
    @IBOutlet weak var selectCustomer: DropDown!
    @IBOutlet weak var barcode: UIView!
    @IBOutlet weak var select: DropDown!
    var buttons:[UIButton]!
    @IBOutlet weak var selectustomerLable: UILabel!
    @IBOutlet weak var holdBill: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
           UIElementsManager.shared.setViewSettingWithBgShade(view: mainview)
           menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        secondtableview.register(UINib(nibName: "hcartcell", bundle: nil), forCellReuseIdentifier: "hcartcell")
        secondtableview.delegate = self
        secondtableview.dataSource = self
        
        let secondNib = UINib(nibName: "cartcell", bundle: nil)
        secondtableview.backgroundColor = .white
        secondtableview.register(secondNib, forCellReuseIdentifier: "cartcell")
        pdf.setTitle("", for: .normal)
        buttons = [holdBill, generatebill, emptyCard]
        UIElementsManager.shared.setViewSettingWithBgShade(view: whiteview)
        UIElementsManager.shared.setViewSettingWithBgShade(view: mainview)
        UIElementsManager.shared.setViewSettingWithBgShade(view: orenageview)
        UIElementsManager.shared.resetStyleAfterEditing(grandTotal)
        UIElementsManager.shared.resetStyleAfterEditing(discounts)
        UIElementsManager.shared.resetStyleAfterEditing(received)
        UIElementsManager.shared.resetStyleAfterEditing(`return`)
        UIElementsManager.shared.resetStyleAfterEditing(productbarcode)
        productbarcode.delegate = self
        productbarcode.backgroundColor = .white
        for button in buttons{
            button.tintColor = .black
            
        }
        received.delegate = self
        `return`.delegate = self
        received.delegate = self
        discounts.delegate = self
        grandTotal.delegate = self
        UIElementsManager.shared.setViewSettingWithBgShade(view: select)
       
        UIElementsManager.shared.setViewSettingWithBgShade(view: holdButton)
        UIElementsManager.shared.setViewSettingWithBgShade(view: emptyCard)
        UIElementsManager.shared.setViewSettingWithBgShade(view: generatebill)
       
        menuButton.setTitle("", for: .normal)
        // Do any additi   onal setup after loading the view.
        
        
        
        if let firstItem = select.optionArray.first {
            select.text = firstItem
        }
        select.isSearchEnable = false
        select.arrowColor = .black
        select.itemsColor = .black
        select.borderColor = .black
        select.tintColor = .black
        select.arrowSize = 10
        
        select.selectedRowColor = .gray

        select.textColor = .black
        // The list of array to display. Can be changed dynamically
        select.optionArray = ["Demouser"]
        //Its Id Values and its optional
        select.optionIds = [1,23,54,22]

        select.backgroundColor = .white
        
        // The the Closure returns Selected Index and String
        select.didSelect{(selectedText , index ,id) in
            self.selectustomerLable.isHidden = true
            //      self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
        }
    }


}

extension cardViewController: UITextFieldDelegate {
    // UITextFieldDelegate method called when the text field becomes the first responder
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIElementsManager.shared.applyStyleForEditing(textField)
       // setRoundedCorner(for: textField, cornerRadius: textField.frame.size.height / 2)
    }

    // UITextFieldDelegate method called when the text field resigns its first responder status
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Reset the border color, shadow, and corner radius when the editing ends
        UIElementsManager.shared.resetStyleAfterEditing(textField)
    }

    // Helper method to set border color and shadow
  

    // Helper method to set corner radius
    private func setRoundedCorner(for textField: UITextField, cornerRadius: CGFloat) {
        textField.layer.cornerRadius = cornerRadius
    }

    private func setPlaceholderColor(for textField: UITextField, color: UIColor) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
        ]
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: attributes)
    }

   
}
extension cardViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hcartcell") as!  hcartcell
        
        // Customize the header cell as needed
        
        // Add the header cell to the header view
        headerView.addSubview(headerCell)
        
        // You might need to adjust the frame of the header cell within the header view
        headerCell.frame = CGRect(x: 0, y: -10, width: tableView.bounds.width, height: 55)
        
        return headerView
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartcell", for: indexPath) as! cartcell
        if indexPath.row % 2  == 0  {
              cell.colorset(color1: UIColor(hex: 0xF5F9FC))
          }
          else{
              cell.colorset(color1: .white)
          }
         
        return cell

    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return 20 // Or whatever number you need for the second table
  
    }
}

