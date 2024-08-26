//
//  SalesCart.swift
//  retailer-connect-first
//
//  Created by Spark on 22/02/2024.
//

import UIKit
import SideMenu

class SalesCart: UIViewController {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var searchBar: UITextField!
    var menu: SideMenuNavigationController!
    @IBAction func pdf(_ sender: Any) {
      
    }
  
    @IBOutlet weak var menubutton: UIButton!
    
    @IBAction func menubutton(_ sender: Any) {
        present(menu!, animated: true)
    }
    
    @IBOutlet weak var pdf: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func holdList(_ sender: Any) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

       

        var swipeButtonDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(buttonpressed))
        self.menubutton.addGestureRecognizer(swipeButtonDown)
        menubutton.setTitle("", for: .normal)
        pdf.setTitle("", for: .normal)
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        tableview.delegate = self
        tableview.dataSource = self
        let secondNib = UINib(nibName: "salescart", bundle: nil)
        tableview.backgroundColor = .white
        tableview.register(secondNib, forCellReuseIdentifier: "saleCart")
        let secondNib2 = UINib(nibName: "hsalescart", bundle: nil)
        tableview.backgroundColor = .white
        tableview.register(secondNib2, forCellReuseIdentifier: "hsalescart")
        // Do any additional setup after loading the view.
    }
    @objc func buttonpressed(){
        print("cliecked")
    }
}
extension  SalesCart: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hsalescart") as!  hsalescart
        // Customize the header cell as needed
        // Add the header cell to the header view
        headerView.addSubview(headerCell)
        // You might need to adjust the frame of the header cell within the header view
        headerCell.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "saleCart", for: indexPath) as! salescart
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // Or whatever number you need for the second table
    }
}
extension SalesCart: UITextFieldDelegate {
    // UITextFieldDelegate method called when the text field becomes the first responder
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIElementsManager.shared.applyStyleForEditing(textField)
       // setRoundedCorner(for: textField, cornerRadius: textField.frame.size.height / 2)
    }
    // UITextFieldDelegate method called when the text field resigns its first responder status
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Reset the border color, shadow, and corner radius when the editing ends
        UIElementsManager.shared.resetStyleAfterEditing(textField)
    }   // Helper method to set border color and shadow
    // Helper method to set corner radius
    private func setRoundedCorner(for textField: UITextField, cornerRadius: CGFloat) {
        textField.layer.cornerRadius = cornerRadius
    }
    private func setPlaceholderColor(for textField: UITextField, color: UIColor) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
        ]
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: attributes)
    }
}

