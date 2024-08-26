
//
//  manageCustomers.swift
//  retailer-connect-first
//
//  Created by Spark on 26/12/2023.
//

import UIKit
import iOSDropDown
import SideMenu

import SKCountryPicker


class ManageMenu: UIViewController {
    
   
    @IBOutlet weak var pdf: UIButton!
    var menu:SideMenuNavigationController!
    @IBOutlet weak var menuButton: UIButton!
 
    @IBOutlet weak var searchTexfeild: UITextField!
//    @IBOutlet weak var uipickerView: UIPickerView!
   @IBOutlet weak var secondTableView: UITableView!
   
    @IBOutlet weak var secondView: UIView!
 
    @IBAction func menuButton(_ sender: Any) {
        
        present(menu!, animated: true)
    }
    @IBOutlet weak var secondTextfeild: UITextField!
    @IBOutlet weak var firstT: UITextField!
    @IBOutlet weak var firstView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        pdf.setTitle("", for: .normal)
     
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        firstT.delegate = self
      
        secondTextfeild.delegate = self
    
        secondTableView.register(UINib(nibName: "hsettings", bundle: nil), forCellReuseIdentifier: "hsettings")
        secondTableView.delegate = self
        secondTableView.dataSource = self
        
        let secondNib = UINib(nibName: "settings", bundle: nil)
        secondTableView.backgroundColor = .white
        secondTableView.register(secondNib, forCellReuseIdentifier: "settings")
        
        
        menuButton.setTitle("", for: .normal)
        UIElementsManager.shared.setViewSettingWithBgShade(view: firstView)
        UIElementsManager.shared.resetStyleAfterEditing( firstT)

        UIElementsManager.shared.resetStyleAfterEditing(secondTextfeild)
    
        UIElementsManager.shared.setViewSettingWithBgShade(view: secondView)
        
        
        
        
        
        
        
        searchTexfeild.layer.cornerRadius = 18
        searchTexfeild.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        searchTexfeild.leftView = imageView
        configureTextField(textField: searchTexfeild)
        
        
        
    }
   
   }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   




extension  ManageMenu: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hsettings") as!  hsettings
        
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
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath) as! settings
     if indexPath.row % 2  == 0  {
           cell.colorset(color1: UIColor(hex: 0xF5F9FC))
       }
       else{
           cell.colorset(color1: .white)
       }
       
        return cell
  
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return 10 // Or whatever number you need for the second table
 
    }
    
}
extension ManageMenu: UITextFieldDelegate {
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
            .foregroundColor: UIColor.black,
        ]
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: attributes)
    }


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == secondTextfeild {
            // Allow only numeric input for †extfeild
            let allowedCharacterSet = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: characterSet)
           
        } else {
            // Allow alphanumeric input for other text fields
            let allowedCharacterSet = CharacterSet.alphanumerics
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: characterSet)
        }
    }
}



