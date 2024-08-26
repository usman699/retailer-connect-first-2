//
//  viewbranches.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 27/04/2024.
//


import UIKit
import iOSDropDown
import SideMenu

import SKCountryPicker
class viewbranches: UIViewController , submitdelegate,  UIDocumentInteractionControllerDelegate, updateBranch,deleteBranch{
    func updatebranch(selected: Branch) {
        print("update")
    }
    
    func deletebranch(selected: Branch) {
        print("delete")
    }
    
    @IBOutlet weak var forword: UIButton!
    
    @IBOutlet weak var backword: UIButton!
   
    func showMsg(msg: String, title: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let topViewController = UIApplication.shared.keyWindow?.rootViewController?.topMostViewController() {
                let vc = surealert()
                vc.msg = msg
                vc.ttiles = title
                vc.confirmationHandler = { [self] in
                    
//
//                    self.customermodel.deleteCustomer(id: Id, whenFinish: {
//                                    [weak self] result in
//                                    switch result{
//                                    case .success(let user):
//                                        print("success in delete")
//                                  self!.fetchingCustomer()
//                                    case .failure(let error):
//                                        print("Error fetching data: \(error.localizedDescription)")
//                                    }
//
//                                })
                    
                }
                
                
                topViewController.present(vc, animated: true, completion: nil)
                
            }
        }
    }

    struct structure{
        var tittle:String
        var id:Int
    }
    

    
    
    
    var arrayBranches:[Branch] = []
    func selectAllButtonTapped2(selected: fetchCustumer) {
        Id = selected.id
        showMsg(msg: "", title: "are you sure want to delete")
    }

    
    
    
    
    func submit(name: String, phone: String, address: String, id : Int) {
        
 
//        customermodel.updateCustumer(id: id, phone: phone, address: address, name: name, whenFinish: {
//
//             [weak self] result in
//            switch result{
//            case .success(let user):
//
//              self!.fetchingCustomer()
//
//
//                self?.dismiss(animated: true)
//            case .failure(let error):
//                print("Error fetching data: \(error.localizedDescription)")
//            }
//
//        })
    }
    var company :         Int = 0
    var  Id :Int!
    var filterData:[Branch] = []
    @IBAction func excelAction(_ sender: Any) {
        let file_name = "my_contacts.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(file_name)
        
        // Header row
        var csvText = "#sr, Name, phone,address , description "
        
        for (index, contact) in fetchCustumerArray.enumerated() {
            // Rows
            let row = "#\( contact.id), \(contact.name), \(contact.phone), \(contact.address) ,\(contact.description),  \n"
            csvText.append(row)
        }
        
        do {
            try csvText.write(to: path!, atomically: true, encoding: .utf8)
            
            let exportSheet = UIActivityViewController(activityItems: [path as Any], applicationActivities: nil)
            present(exportSheet, animated: true, completion: nil)
            
            print("Export successful")
        } catch {
            print("Error exporting CSV: \(error.localizedDescription)")
        }
    }
    @IBOutlet weak var searchbar: UISearchBar!
    @IBAction func pdfaction(_ sender: Any) {
        print("cleick on pdf")
      
        let pdf_file = UIDocumentInteractionController(url: URL(fileURLWithPath: Global.shared.pdfDataWithTableView(tableView: self.secondTableView, view: self.view)))
        pdf_file.delegate = self
        
        pdf_file.presentPreview(animated: true)
    }
    @IBOutlet weak var excel: UIButton!
    
    
    @IBOutlet weak var dropdown: DropDown!
    @IBOutlet weak var pdf: UIButton!
    
    
    func selectAllButtonTapped(selected: fetchCustumer) {
 
        let storyboard = UIStoryboard(name: "UPDATE", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "update") as! UPDATE
        initialViewController.CustomerName = "Customer Name"
        initialViewController.BalenceName = "Balence"
        initialViewController.TESTName  =   "address"
        initialViewController.phoneNumberName = "Phone Number"
        initialViewController.delegate  = self
        initialViewController.id = selected.id
        initialViewController.phoneNumbers = selected.phone
        initialViewController.customerNames = selected.name
        initialViewController.addresss = selected.address
        print(fetchCustumerArray.count)
       present(initialViewController, animated: false)
    }
    var singleElement = [fetchCustumer]()
    var  fetchCustumerArray = [fetchCustumer]()

    var menu:SideMenuNavigationController!
    @IBOutlet weak var menuButton: UIButton!
    @IBAction func showCountryPicker(_ sender: UIButton) {
        showCountryPicker()
        
    }
    @IBAction func submit(_ sender: Any) {
    
        if(firstT.text?.isEmpty == true
        
           || thirdT.text?.isEmpty == true

           ||
           fourtht.text?.isEmpty == true
        ){
            let vc = LoginsViewController()
            
            vc.showMsg(msg: "", title: "please fill feilds")
        }
        
        else{
            
            customermodel.AddBranch(name: firstT.text!, company: company, phone: thirdT.text!, address: fourtht.text!, description:fifth.text!,
                                    whenFinish: { [self]result in
                switch result {
    
                case .success(let user):
                    print("success for adding ")
                    let vc = LoginsViewController()
                    vc.showMsg(msg: "", title: "Added succesfully")
                    
                   
                    
                case .failure(let errors):
                    print("clicked")
//               let vc = LoginsViewController()
//                    for i in  errors.data.name{
//                        vc.showMsg(msg: "", title: i)
//                    }
                }
    
            
                
            })
           
        }

    }
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var pkcountry: UIButton!
    let dropdownData = ["25 ↓", "50 ↓", "100 ↓", "150 ↓","250 ↓" ,"500 ↓" , "All"]

//    @IBOutlet weak var uipickerView: UIPickerView!
   @IBOutlet weak var secondTableView: UITableView!
   
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var fourtht: UITextField!
    @IBOutlet weak var thirdT: UITextField!
    var usermodel = addUserViewmodel()
    @IBOutlet weak var fifth: CustomTextField!
    var Companies : [structure] = []
    @IBAction func phoneNumber(_ sender: Any) {
        showCountryPicker()
    }
    
    @IBAction func menuButton(_ sender: Any) {
        
        present(menu!, animated: true)
    }
    @IBOutlet weak var secondTextfeild: UITextField!
    @IBOutlet weak var firstT: UITextField!
   
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    var customermodel =  brachViewmodel()
    override func viewDidLoad() {
        super.viewDidLoad()
        forword.setTitle("", for: .normal)
        backword.setTitle("", for: .normal)
        excel.setTitle("", for: .normal)
        pdf.setTitle("", for: .normal)
      //  countryFlag.image = UIImage(named: "images")
      
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        secondTableView.register(UINib(nibName: "hbranchescell", bundle: nil), forCellReuseIdentifier: "hbranchcell")
        secondTableView.delegate = self
        secondTableView.dataSource = self
        let secondNib = UINib(nibName: "branchescell", bundle: nil)
        secondTableView.backgroundColor = UIColor(hex: 0xF5F9FC)
        secondTableView.register(secondNib, forCellReuseIdentifier: "branchcell")
        menuButton.setTitle("", for: .normal)
        UIElementsManager.shared.setViewSettingWithBgShade(view: secondView)
        searchbar.delegate = self
        searchbar.autocorrectionType = .no
        searchbar.autocapitalizationType = .none
        searchbar.tintColor = UIColor.black
        searchbar.barTintColor = UIColor.black
      //  fetchCompanies()
        fetchBranches()
    }
    
    func fetchBranches(){
        usermodel.fetchingBranch(whenFinish: { [self] result in
            switch result {
            case .success(let user):
                print("fetching  branches success ", user.success)
                for i in user.data {
                    print(i)
                }
                arrayBranches = user.data
                secondTableView.reloadData()
        case .failure(let error):
                print("fetching  error:", error)
                print("fetching  error:", error.localizedDescription)
                
            }
        })
    }
    func fetchCompanies(){
        usermodel.fetchingUser(whenFinish: { [self] result in
            switch result {
            case .success(let user):
                
                
                
                for i in user.data.data {
                    let item = structure(tittle: i.name, id: i.id)
                    Companies.append(item)
                    
                }
                configuredDropDown2(dropDown:dropdown, array:Companies)
                
            case .failure(let error):
                print("fetching  error:", error)
                print("fetching  error:", error.localizedDescription)
                
            }
        })
    }
    public func  configuredDropDown2(dropDown:DropDown, array:Array<structure>) {
        
        if let firstItem = dropDown.optionArray.first {
            dropDown.text = firstItem
        }
        var optionArray: [String] = []
        var optionIds: [Int] = []
        dropDown.isSearchEnable = false
        dropDown.arrowColor = .black
        dropDown.itemsColor = .black
        dropDown.borderColor = .black
        dropDown.tintColor = .black
        dropDown.arrowSize = 10
        dropDown.selectedRowColor = .gray
        // Set the selectedRow to 0 to display the first item initially
        // Manually set the text to the first item
        //  dropDown.text = dropDown.optionArray.first
        dropDown.textColor = .black
        // The list of array to display. Can be changed dynamically
        for i in array {
            optionArray.append(i.tittle)
            optionIds.append(i.id)
            
        }
        dropDown.optionArray = optionArray
        dropDown.optionIds = optionIds
        //Its Id Values and its optional
        // Image Array its optional
        //   dropDown.optionImageArray = ["email","email","email"]
        dropDown.backgroundColor = .white
        // The the Closure returns Selected Index and String
        
        
        dropDown.didSelect { [self] (selectedText, index, id) in
            if dropDown == self.dropdown {
                // Handle selection for the first drop-down (assuming it's named dropDown)
                self.companyLabel.isHidden = true
                print("company", id)
                company = id
    
            }
            
        }
        
       
        
    }
  
    
    @IBOutlet weak var companyLabel: UILabel!
    

    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    private func showCountryPicker() {
        // Present country picker with `Section Control` enabled
        CountryPickerWithSectionViewController.presentController(on: self, configuration: { countryController in
            countryController.configuration.flagStyle = .circular
     
            countryController.favoriteCountriesLocaleIdentifiers = ["IN", "US"]
            
        }) { [weak self] country in
//            self?.pkcountry.setTitle("\(country.digitCountrycode! ), \(country.countryName)", for: .normal)
            self?.thirdT.text = "+\(country.digitCountrycode!)"
            self?.countryFlag.image = country.flag
            guard let self = self else { return }
     //       self.countryImageView.isHidden = false
    //        self.countryImageView.image = country.flag
     //       self.countryCodeButton.setTitle(country.dialingCode, for: .normal)
        }
    }
   }

extension viewbranches: UIPickerViewDelegate, UIPickerViewDataSource {
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

extension viewbranches: UISearchBarDelegate{
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
       filterData = []
        if searchText == ""
        {
            searchbar.perform(#selector(self.resignFirstResponder), with: nil, afterDelay: 0.1)
            filterData = arrayBranches
        }
        for word in arrayBranches{
            if word.name.uppercased().contains(searchText.uppercased()){
                filterData.append(word)
            }
        }
        self.secondTableView.reloadData()
    }
}
extension  viewbranches: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hbranchcell") as!  hbranchescell
        
        // Customize the header cell as needed
        
        // Add the header cell to the header view
        headerView.addSubview(headerCell)
        
        // You might need to adjust the frame of the header cell within the header view
        headerCell.frame = CGRect(x: 0, y: -10, width: tableView.bounds.width, height: 49)
        
        return headerView
    }
    
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "branchcell", for: indexPath) as! branchescell
        var currentpostion = arrayBranches[indexPath.row]
        cell.address.text = currentpostion.address
        cell.id.text = String( indexPath.row + 1 )
        cell.name.text = String(currentpostion.name)
        cell.address.text = currentpostion.address
        cell.descriptions.text = currentpostion.description
        cell.phone.text = currentpostion.phone
        cell.backgroundColor = UIColor(hex: 0xF5F9FC)
        cell.updatebranch = self
        print("current postion",currentpostion.address)
        cell.configure(with: currentpostion)
        cell.deletebranch = self
      //  cell.switch.value(forKey: currentpostion.status.rawValue)
     if indexPath.row % 2  == 0  {
           cell.colorset(color1: UIColor(hex: 0xF5F9FC))
       }
       else{
           cell.colorset(color1: .white)
       }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  arrayBranches.count   // Or whatever number you need for the second table
    }
}

