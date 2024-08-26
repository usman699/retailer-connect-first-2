//
//  viewcustomerViewController.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 24/04/2024.
//


import UIKit
import iOSDropDown
import SideMenu
import ExcelExport
import SKCountryPicker
class viewcustomerViewController: UIViewController ,manageSuppliersdelegate , submitdelegate, deletCustomer,UIDocumentInteractionControllerDelegate{
    func showMsg(msg: String, title: String) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let topViewController = UIApplication.shared.keyWindow?.rootViewController?.topMostViewController() {
                let vc = surealert()
                vc.msg = msg
                vc.ttiles = title
                vc.confirmationHandler = { [self] in
                    
                    
                    self.customermodel.deleteCustomer(id: Id, whenFinish: {
                        [weak self] result in
                        switch result{
                        case .success(let user):
                            
                            print("success in delete")
                            
                            self!.fetchingCustomer()
                            
                        case .failure(let error):
                            print("Error fetching data: \(error.localizedDescription)")
                        }
                        
                    })
                    
                }
                
                
                topViewController.present(vc, animated: true, completion: nil)
                
            }
        }
    }
    @IBOutlet weak var backword: UIButton!
    
    
    @IBOutlet weak var forword: UIButton!
    
    func selectAllButtonTapped2(selected: fetchCustumer) {
        Id = selected.id
        showMsg(msg: "", title: "are you sure want to delete")
        
        
        
    }
    
    func submit(name: String, phone: String, address: String, id : Int) {
        
        
        customermodel.updateCustumer(id: id, phone: phone, address: address, name: name, whenFinish: {
            
            [weak self] result in
            switch result{
            case .success(let user):
                
                self!.fetchingCustomer()
                
                
                self?.dismiss(animated: true)
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
            
        })
        
        
        
        
    }
        var currentPage = 1
        let pageSize = 15 // Number of items to fetch per page
        var totalItems = 0 // Total number of items available
        
    var  Id :Int!
    var filterData:[fetchCustumer] = []
//    func fetchData(page: Int) {
//            customermodel.FetchingCusomter(page: page, pageSize: pageSize) { [weak self] result in
//                switch result {
//                case .success(let user):
//                    print("Success: \(user.data.count) items fetched")
//                    self?.totalItems = user.totalItems // Update totalItems
//                    self?.fetchCustumerArray += user.data // Append fetched data to existing array
//                    self?.filterData = self!.fetchCustumerArray
//                    self?.secondTableView.reloadData()
//                case .failure(let error):
//                    print("Error fetching data: \(error.localizedDescription)")
//                }
//            }
//        }
    @IBAction func excelAction(_ sender: Any) {
        let file_name = "my_contacts.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(file_name)
        
        // Header row
        var csvText = "#sr, Name, phone,address , Balence , status\n"
        
        for (index, contact) in fetchCustumerArray.enumerated() {
            // Rows
            let row = "#\(contact.id), \(contact.name), \(contact.phone), \(contact.address) ,\(contact.balance), \(contact.status),  \n"
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
        secondTableView.reloadData()
        print("cleick on pdf")
        let pdf_file = UIDocumentInteractionController(url: URL(fileURLWithPath: Global.shared.pdfDataWithTableView(tableView: self.secondTableView, view: self.view)))
        pdf_file.delegate = self
        pdf_file.presentPreview(animated: true)
    }
    @IBOutlet weak var excel: UIButton!
    
    
    @IBOutlet weak var pdf: UIButton!
    
    
    func selectAllButtonTapped(selected: fetchCustumer) {
        print("id " , selected.id)
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
  

   
    
    //    @IBOutlet weak var uipickerView: UIPickerView!
    @IBOutlet weak var secondTableView: UITableView!
    
    @IBOutlet weak var secondView: UIView!
   
    
 
    
    @IBAction func menuButton(_ sender: Any) {
        
        present(menu!, animated: true)
    }
  
  
    
    var customermodel =  addcustomerviewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        forword.setTitle("", for: .normal)
        backword.setTitle("", for: .normal)
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
//        func dismissKeyboard(){ /*this is a void function*/
//            thirdT.resignFirstResponder()
//            fourtht.resignFirstResponder()
//            firstT.resignFirstResponder()
//            secondTextfeild.resignFirstResponder() /*This will dismiss our keyboard on tap*/
//        }
        excel.setTitle("", for: .normal)
        pdf.setTitle("", for: .normal)
     
        
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        
        secondTableView.register(UINib(nibName: "HviewcustomerTableViewCell", bundle: nil), forCellReuseIdentifier: "hviewcustomer")
        secondTableView.delegate = self
        secondTableView.dataSource = self
        
        let secondNib = UINib(nibName: "manageSuppliers", bundle: nil)
        secondTableView.backgroundColor = UIColor(hex: 0xF5F9FC)
        secondTableView.register(secondNib, forCellReuseIdentifier: "manageSuppliers")
        menuButton.setTitle("", for: .normal)
        UIElementsManager.shared.setViewSettingWithBgShade(view: secondView)
        
        
        fetchingCustomer()
        searchbar.delegate = self
        searchbar.autocorrectionType = .no
        searchbar.autocapitalizationType = .none
        searchbar.tintColor = UIColor.black
        searchbar.barTintColor = UIColor.black
        searchbar.barTintColor = .black
        searchbar.tintColor = .black
        
        
        
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func fetchingCustomer(){
        customermodel.FetchingCusomter { [weak self] result in
            switch result {
            case .success(let user):
                print("Success: \(user.data.count) items fetched")
                self?.fetchCustumerArray = user.data
                self?.filterData = self!.fetchCustumerArray
                self?.secondTableView.reloadData()
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
}



extension viewcustomerViewController: UISearchBarDelegate{
    
   
    
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
            filterData = fetchCustumerArray
        }
        for word in fetchCustumerArray{
            if word.name.uppercased().contains(searchText.uppercased()){
                filterData.append(word)
            }
            
        }
        self.secondTableView.reloadData()
    }
}
extension viewcustomerViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hviewcustomer") as!  HviewcustomerTableViewCell
        
        // Customize the header cell as needed
        
        // Add the header cell to the header view
        headerView.addSubview(headerCell)
        
        // You might need to adjust the frame of the header cell within the header view
        headerCell.frame = CGRect(x: 0, y: -20, width: tableView.bounds.width, height: 60)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manageSuppliers", for: indexPath) as! manageSuppliers
        var currentpostion = filterData[indexPath.row]
        cell.address.text = currentpostion.address
        cell.id.text = String(indexPath.row)
        cell.name.text = String(currentpostion.name)
        cell.address.text = currentpostion.address
        cell.phone.text = currentpostion.phone
        cell.descriptions.text =  "\(currentpostion.balance ?? 0)/-"
        cell.backgroundColor = UIColor(hex: 0xF5F9FC)
        
     
        cell.delegatedelete = self
        print("current postion",currentpostion.address)
        cell.configure(with: currentpostion)
        cell.delegate = self
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

        return  filterData.count   // Or whatever number you need for the second table
  
    }
    
}
extension viewcustomerViewController{
    func makenavigationbar() -> UIView{
        lazy var logoImageView: UIImageView = {
            let imageview = UIImageView()
            let image = UIImage(systemName: "images")
            imageview.image = image
            imageview.contentMode = .scaleAspectFit
            imageview.heightAnchor.constraint(equalToConstant: 100).isActive = true
            imageview.widthAnchor.constraint(equalToConstant: 100).isActive = true
            return imageview
        }()
        lazy var spacer:UIView = {
            let spacer = UIView()
            let constraint = spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude)
            constraint.isActive = true
            constraint.priority = .defaultLow
            return spacer
        }()
        let stackView = UIStackView()
        stackView.backgroundColor = .lightGray
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(spacer)
        return stackView
    }
    
    func addnavigaitonbar() -> Self{
        let navigationBar = makenavigationbar()
        navigationItem.titleView = navigationBar
        return self
    }
   
    
}
extension viewcustomerViewController {
    static func intantiate(storyName:String) -> Self{
        let storyboard = UIStoryboard(name: storyName, bundle: nil)
        return storyboard.instantiateInitialViewController() as! Self
    }
}
