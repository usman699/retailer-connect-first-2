//
//  EmployeeList.swift
//  retailer-connect-first
//
//  Created by Spark on 07/12/2023.
//

import UIKit
import SideMenu
class EmployeeList: UIViewController {
    @IBAction func viewemployee(_ sender: Any) {
        print("clicked")
        let storyboard = UIStoryboard(name: "AddEmployee", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "AddEmployee")
    present(initialViewController, animated: false)
        
     
    }
    var menu: SideMenuNavigationController!
   
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
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.statusBarFrame)
            statusBar.backgroundColor = UIColor(hex: 0xF18318) // Replace with your color
            view.addSubview(statusBar)
        } else {
            UIApplication.shared.statusBarStyle = .lightContent
        }
        UIElementsManager.shared.setViewSettingWithBgShade(view: mainview)
        search.delegate = self

        secondtableview.register(UINib(nibName: "hemployeeList", bundle: nil), forCellReuseIdentifier: "hemployeeList")
        secondtableview.delegate = self
        secondtableview.dataSource = self
        
        let secondNib = UINib(nibName: "employeeList", bundle: nil)
        secondtableview.backgroundColor = .white
        secondtableview.register(secondNib, forCellReuseIdentifier: "EmployeeList")
        UIElementsManager.shared.resetStyleAfterEditing(search)
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
       
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menuButton.setTitle("", for: .normal)
        // Do any additional setup after loading the view.
    }
    // Change status bar color
    
 
}

// Helper extension to create UIColor from hexadecimal value

extension  EmployeeList: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hemployeeList") as!  hemployeeList
        
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
  
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeList", for: indexPath) as! employeeList
        if indexPath.row % 2  == 0  {
              cell.colorset(color1: UIColor(hex: 0xF5F9FC))
          }
          else{
              cell.colorset(color1: .white)
          }
          
      
        return cell
   
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
extension EmployeeList: UITextFieldDelegate {
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   

