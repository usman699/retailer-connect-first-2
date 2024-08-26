//
//  EmployeeList.swift
//  retailer-connect-first
//
//  Created by Spark on 07/12/2023.
//

import UIKit
import SideMenu
class viewProduct: UIViewController {
    var menu: SideMenuNavigationController!
    @IBOutlet weak var viewEmployee: UIView!
  
    @IBOutlet weak var secondtableview: UITableView!
    // @IBOutlet weak var secondCollectionview: UICollectionView!
    @IBOutlet weak var menuButton: UIButton!
   
    @IBOutlet weak var search: UITextField!
    let actionClosure = { (action: UIAction) in
         print(action.title)
    }
    @IBAction func menuButton(_ sender: Any) {
        present(menu! , animated: true)
    }
   
   
    @IBOutlet weak var mainview: UIView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        UIElementsManager.shared.resetStyleAfterEditing(search)
        secondtableview.register(UINib(nibName: "hviewsProduct", bundle: nil), forCellReuseIdentifier: "hviewproduct")
        secondtableview.delegate = self
        secondtableview.dataSource = self
        
        let secondNib = UINib(nibName: "viewproducts", bundle: nil)
        secondtableview.backgroundColor = .white
        secondtableview.register(secondNib, forCellReuseIdentifier: "viewsProducts")
        
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        UIElementsManager.shared.setViewSettingWithBgShade(view: viewEmployee)
        UIElementsManager.shared.setViewSettingWithBgShade(view: mainview)
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menuButton.setTitle("", for: .normal)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension viewProduct: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hviewproduct") as!  hviewsProduct
        
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
        //        if tableView == firstTableView {
        //            let cell = tableView.dequeueReusableCell(withIdentifier: constraints.shared.hdesignationCellIdentifire, for: indexPath) as! hdesignationCell
        //            return cell
        //        } else if tableView == secondTableView {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewsProducts", for: indexPath) as! viewproducts
        if indexPath.row % 2  == 0  {
              cell.colorset(color1: UIColor(hex: 0xF5F9FC))
          }
          else{
              cell.colorset(color1: .white)
          }
          
        return cell
        //
        //
        //        }
        //        return UITableViewCell()
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if tableView == firstTableView {
        //            return 1
        //        } else if tableView == secondTableView {
        return 10 // Or whatever number you need for the second table
        //        }
        //        return 0
    }
}

extension  viewProduct: UITextFieldDelegate {
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
