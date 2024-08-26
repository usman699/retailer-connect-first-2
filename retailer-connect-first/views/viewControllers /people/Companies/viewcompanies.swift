//
//  viewcompanies.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 27/04/2024.
//



import UIKit


import UIKit
import iOSDropDown
import SideMenu

import SKCountryPicker
class viewCompanies: UIViewController ,updatecompany , submitdelegate, deletcompany,UIDocumentInteractionControllerDelegate{
    func updatecompnay(selected: Datacompanies) {
        print("id " , selected.id)
        let storyboard = UIStoryboard(name: "UPDATE", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "update") as! UPDATE
        initialViewController.CustomerName = "Customer Name"
        initialViewController.BalenceName = "Description"
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
    
    func deletecompany(selected: Datacompanies) {
         Id = selected.id
        showMsg(msg: "", title: "are you sure want to delete")
    }
    
  
    
    func showMsg(msg: String, title: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let topViewController = UIApplication.shared.keyWindow?.rootViewController?.topMostViewController() {
                let vc = surealert()
                vc.msg = msg
                vc.ttiles = title
                vc.confirmationHandler = { [self] in
                    
                    
                    self.companiesviewmodel.changestatus(id: Id, completion: {
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
 

    
    func submit(name: String, phone: String, address: String, id : Int) {
        
        Global.shared.loading(view: self.view)
        companiesviewmodel.update(id: id, name: name, phone: phone, address: address,description: "", completion: {
         
             [weak self] result in
            switch result{
            case .success(let user):
                Global.shared.stop()
                self!.fetchingCustomer()
                
                
                self?.dismiss(animated: true)
            case .failure(let error):
                switch error {
                    
                case .decodingError:
                    print("decoding")
                case .notFound:
                    print("not found ")
                case .conflict:
                    print("conflict ")
                case .unknownError:
                    print("unkown")
                case .unresponseEntity:
                    print("unrespnseentity")
                case .outofstack:
                    print("out of stock ")
                }
                print("Error fetching data: \(error.localizedDescription)")
            }
            
        })
        
        
        
        
    }
    var  Id :Int!
    var filterData:[Datacompanies] = []
    @IBAction func excelAction(_ sender: Any) {
        let file_name = "my_contacts.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(file_name)
        
        // Header row
        var csvText = "#sr, Name, phone,address , description , status\n"
        
        for (index, contact) in fetchCustumerArray.enumerated() {
            // Rows
            let row = "#\( contact.id), \(contact.name), \(contact.phone), \(contact.address) ,nill, \(contact.status),  \n"
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
    @IBOutlet weak var backword: UIButton!
    @IBAction func backword(_ sender: Any) {
    }
    @IBOutlet weak var forword: UIButton!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBAction func pdfaction(_ sender: Any) {
        let pdfFileName = "customers.pdf"
            let pdfPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(pdfFileName)
            
            UIGraphicsBeginPDFContextToFile(pdfPath!.path, CGRect.zero, nil)
            UIGraphicsBeginPDFPage()
            
            let pdfContext = UIGraphicsGetCurrentContext()
            
            // Set up font and text attributes
            let font = UIFont.systemFont(ofSize: 12)
            let textColor = UIColor.black
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            // Define starting point for drawing
            var textYPosition: CGFloat = 50
            
            // Iterate through your data and draw it on PDF
            for (index, customer) in fetchCustumerArray.enumerated() {
                let text = "\(index + 1). Name: \(customer.name), Phone: \(customer.phone), Address: \(customer.address)"
                let attributedString = NSAttributedString(string: text, attributes: [
                    .font: font,
                    .foregroundColor: textColor,
                    .paragraphStyle: paragraphStyle
                ])
                
                let textRect = CGRect(x: 50, y: textYPosition, width: 400, height: 20)
                attributedString.draw(in: textRect)
                
                // Adjust Y position for next entry
                textYPosition += 20
            }
            
            UIGraphicsEndPDFContext()
            
            // Display or share the PDF file
            let pdfFile = NSURL(fileURLWithPath: pdfPath!.path)
            let activityViewController = UIActivityViewController(activityItems: [pdfFile], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
//        secondTableView.reloadData()
//        let pdf_file = UIDocumentInteractionController(url: URL(fileURLWithPath: Global.shared.pdfDataWithTableView(tableView: self.secondTableView, view: self.view)))
//        pdf_file.delegate = self
//
//        pdf_file.presentPreview(animated: true)
    }
    @IBOutlet weak var excel: UIButton!
    
    
    @IBOutlet weak var pdf: UIButton!
    
    
   
    
   
    
   
    var  fetchCustumerArray = [Datacompanies]()

    var menu:SideMenuNavigationController!
    @IBOutlet weak var menuButton: UIButton!
    
   
    

    
//    @IBOutlet weak var uipickerView: UIPickerView!
   @IBOutlet weak var secondTableView: UITableView!
   
    @IBOutlet weak var secondView: UIView!
    
 
   
    
    @IBAction func menuButton(_ sender: Any) {
        
        present(menu!, animated: true)
    }

  
    

    var companiesviewmodel =  peoplesviewmodel()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        excel.setTitle("", for: .normal)
        pdf.setTitle("", for: .normal)
      
        forword.setTitle("", for: .normal)
        backword.setTitle("", for: .normal)
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
      
    
        secondTableView.register(UINib(nibName: "hmanageSuppliers", bundle: nil), forCellReuseIdentifier: "hmanageSupplers")
        secondTableView.delegate = self
        secondTableView.dataSource = self
       
        let secondNib = UINib(nibName: "viewCompaniesTableViewCell", bundle: nil)
        secondTableView.backgroundColor = UIColor(hex: 0xF5F9FC)
        secondTableView.register(secondNib, forCellReuseIdentifier: "viewcompanies")
        menuButton.setTitle("", for: .normal)
        UIElementsManager.shared.setViewSettingWithBgShade(view: secondView)
     
        
        fetchingCustomer()
        searchbar.delegate = self
        searchbar.autocorrectionType = .no
        searchbar.autocapitalizationType = .none
        searchbar.tintColor = UIColor.black
        searchbar.barTintColor = UIColor.black
        
        
        
        
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func fetchingCustomer(){
        companiesviewmodel.fetchcompanies{ [weak self] result in
            switch result {
            case .success(let user):
          
                self?.fetchCustumerArray = user.data.data
                self?.filterData = self!.fetchCustumerArray
                self?.secondTableView.reloadData()
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
 
   }


extension viewCompanies: UISearchBarDelegate{
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
extension  viewCompanies: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hmanageSupplers") as!  hmanageSuppliers
        
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewcompanies", for: indexPath) as! viewCompaniesTableViewCell
        var currentpostion = filterData[indexPath.row]
        cell.address.text = currentpostion.address
        cell.id.text = "\(indexPath.row)"
      
        cell.name.text = String(currentpostion.name)
        cell.address.text = currentpostion.address
        cell.phone.text = currentpostion.phone
        cell.backgroundColor = UIColor(hex: 0xF5F9FC)
        cell.delegatedelete = self
        cell.descriptions.text =   currentpostion.description ?? ""
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

