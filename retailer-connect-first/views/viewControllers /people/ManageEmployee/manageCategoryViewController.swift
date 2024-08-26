
import UIKit
import SideMenu

class  manageCategoryViewController: UIViewController {
   
    var menu:SideMenuNavigationController!
   // @IBOutlet weak var uipickerview: UIPickerView!
    @IBOutlet weak var FIRSTT: UITextField!
    
    @IBAction func menubuton(_ sender: Any) {
        present(menu! , animated: true)
    }
    @IBOutlet weak var SECONDt: UITextField!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var searchT: UITextField!
    @IBOutlet weak var secondTableView: UITableView!
    let dropdownData = ["25 ↓", "50 ↓", "100 ↓", "150 ↓","250 ↓" ,"500 ↓" , "All"]
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var searchTexfeild: UITextField!
    @IBOutlet weak var seconView: UIView!
    @IBOutlet weak var Thirdt: UITextField!
    @IBOutlet weak var FirstView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        FIRSTT.delegate = self
        SECONDt.delegate = self
        Thirdt.delegate = self
        UIElementsManager.shared.resetStyleAfterEditing(FIRSTT)
        UIElementsManager.shared.resetStyleAfterEditing(SECONDt)
        UIElementsManager.shared.resetStyleAfterEditing(Thirdt)
        
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
  
        secondTableView.register(UINib(nibName: "hmanageCategoirs", bundle: nil), forCellReuseIdentifier: "hmanageCategories")
     
        secondTableView.delegate = self
        secondTableView.dataSource = self
        
        let secondNib = UINib(nibName: "managecat", bundle: nil)
        secondTableView.backgroundColor = .white
        secondTableView.register(secondNib, forCellReuseIdentifier: "manageCat")
        
        
        menuButton.setTitle("", for: .normal)
        UIElementsManager.shared.setViewSettingWithBgShade(view: FirstView)
     
    
        setTextFieldBorderColor(yourTextField: searchTexfeild)
        
        UIElementsManager.shared.setViewSettingWithBgShade(view: seconView)
        searchTexfeild.layer.cornerRadius = 18
     
        searchTexfeild.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        searchTexfeild.leftView = imageView
        configureTextField(textField: searchTexfeild)
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


func configureTextFields(textField:UITextField) {
        // Set placeholder text color to black
        textField.attributedPlaceholder = NSAttributedString(string: "Placeholder Text", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])

        // Set corner radius for rounded corners
        textField.layer.cornerRadius = textField.bounds.height / 2
        textField.layer.masksToBounds = true
     
    
      
    }
extension  manageCategoryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hmanageCategories") as! hmanageCategoirs
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "manageCat", for: indexPath) as! managecat
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
extension manageCategoryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dropdownData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dropdownData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Handle the selection
        let selectedOption = dropdownData[row]
        print("Selected option: \(selectedOption)")
    }
    
    // Set the text color based on the selected state
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = dropdownData[row]
        var textColor: UIColor = .gray
        
        // Check if the row is selected
        if row == pickerView.selectedRow(inComponent: component) {
            textColor = .black
        }
        
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: textColor])
        return attributedString
    }
    
    
    
    
    
    
    
}
extension manageCategoryViewController: UITextFieldDelegate {
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


}
