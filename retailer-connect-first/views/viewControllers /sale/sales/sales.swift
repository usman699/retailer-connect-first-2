///Users/spark/Library/Developer
//  sales.swift
//  retailer-connect-first
//
//  Created by Spark on 06/02/2024.
//

import UIKit
import iOSDropDown
import PDFKit
import SideMenu

class salesviewcontrolller: UIViewController , orderDelegate,UIDocumentInteractionControllerDelegate, Vieworders, vieworderdata{


    @IBAction func lll(_ sender: Any) {
 
    }
    
    
    @IBOutlet weak var emptylabel: UILabel!
    var orderId = Int()

    func orderid(orderid: Int) {
       print("e" , orderid)
       orderId = orderid
    }
    
    func vieworder() {
        dismiss(animated: true)
            let storyboard = UIStoryboard(name:  "order", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "vieworder") as? orderViewController
        
        initialViewController?.orderId = orderId
        
        initialViewController!.modalPresentationStyle = .fullScreen
            
            
        
        navigationController?.present(initialViewController!, animated: false)
    }
    
   


    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    @IBOutlet weak var menubutton: UIButton!
    @IBOutlet weak var navigationbar: NavigationBar!
    @IBOutlet weak var excelnewthing: UIButton!
    @IBAction func excelbutton(_ sender: Any) {
 
    
            let file_name = "my_contacts.csv"
            let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(file_name)
            
            // Header row
            var csvText = "#sr, Name, quantity, tax , total bill , payment_status, total-status, stats \n"
            
            for (index, contact) in saleList.enumerated() {
                // Rows
                let row = "#\( contact.id), \(contact.customer_name), \(contact.quantity), \(contact.tax), \(contact.total_bill), \(contact.payment_status) ,\(contact.total_bill),\(contact.status) \n"
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
    @IBOutlet weak var fifith: UIButton!
    @IBOutlet weak var dots: UIImageView!
    @IBOutlet weak var fourth: UIButton!
    @IBOutlet weak var thirdbutton: UIButton!
    @IBOutlet weak var secondbutton: UIButton!
    var buttons:[UIButton] = []
    @IBAction func pdfaction(_ sender: Any) {
        let pdf_file = UIDocumentInteractionController(url: URL(fileURLWithPath: Global.shared.pdfDataWithTableView(tableView: self.tableview, view: self.view)))
        pdf_file.delegate = self
     
        pdf_file.presentPreview(animated: true)

        }
  
    @IBOutlet weak var stackview: UIStackView!
    
    @IBOutlet weak var menusmallbutton: UIButton!
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
       return self
    }
    @IBAction func menuButtonss(_ sender: Any) {
   
        present(menus!, animated: true)
    }
    func orderAlerts() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let topViewController = UIApplication.shared.keyWindow?.rootViewController?.topMostViewController() {
                let vc = orderAlertViewController()
                vc.delegate = self
                topViewController.present(vc, animated: true, completion: nil)
            }
        }
    }
    let dateFormatter = DateFormatter()
   
    @IBAction func button(_ sender: Any) {
        present(menus!, animated: true)
    }
    //  @IBOutlet weak var hieghttableview: NSLayoutConstraint!
    @IBAction func searchbutton(_ sender: Any) {
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let formattedDate = dateFormatter.string(from: calender.date)
        salesViewModel.searchEmployee(start_date:formattedDate,
                                      customer:custumerId,
                                      payment_status:payment_status!,
                                      whenFinish:  
                                        {
            [self]
            result in
            switch result {
            case .success(let res ):
              
                saleList = []
                print(saleList.count)
                saleList = res.data.data
                for ar in  saleList
                {
                    if customerName == ar.customer_name {
                       
                       
                    }
                }
            
                tableview.reloadData()
            case .failure(let error):
            print(error)
            }
        }
        )
    }
    
   
    var custumerId = Int()
    @IBOutlet weak var calender: UIDatePicker!
    var customerName:String!
    var date:String!
    var payment_status:String!
    @IBOutlet weak var searchButton: UIButton!
    //   @IBOutlet weak var selectcustomerLable: UILabel!
    @IBOutlet weak var paid: DropDown!
    @IBOutlet weak var customers: DropDown!
    @IBOutlet weak var selectCustomer: UILabel!
    @IBOutlet weak var bottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var pdf: UIButton!
    var salesViewModel = salesViewmodel()
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var tableview: UITableView!
    var checked =  false
    var salesArray = [Datum]()
//
    @IBAction func reset(_ sender: Any) {
        
        fetchsalesList()
        
    }
    var stringArray = [String]()
    var idArray = [Int]()
    var saleList = [SaleRecord]()
    @IBOutlet weak var filter: UIButton!
    @IBAction func filter(_ sender: Any) {
        checked.toggle()
        if checked {
            filter.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
            searchview.isHidden = true
            search.isHidden = true
            reset.isHidden = true
            bottomConstrains.constant = -320
        } else {
            bottomConstrains.constant = 10
            searchview.isHidden = false
            search.isHidden = false
            reset.isHidden = false
            filter.setImage (UIImage(systemName: "xmark.circle.fill"), for: .normal)
           
        }
    }
    
    @IBAction func paid(_ sender: Any) {
       
    }

 
    var menus: SideMenuNavigationController!

    @IBOutlet weak var buttonstack: UIStackView!
    @IBOutlet weak var mainview: SetShadow!
    @IBOutlet weak var scroollview: UIScrollView!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var search: UIButton!
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var searchview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        filter.setImage(  UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        
        menus = SideMenuNavigationController(rootViewController: MenuSlider())
        
        menus.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menus
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    
      
        dots.isHidden = true
        buttons = [secondbutton, thirdbutton, fourth, fifith]
        for button in buttons {
            button.isHidden = true
        }
        emptylabel.isHidden = true
        tableview.register(UINib(nibName: "hsalescellsTableViewCell", bundle: nil), forCellReuseIdentifier: "hsalesCell")
        let secondNib = UINib(nibName: "salesCells", bundle: nil)
        tableview.backgroundColor = UIColor(hex: "F5F9FC")
        tableview.register(secondNib, forCellReuseIdentifier: "salesCells")
        tableview.delegate = self
        tableview.dataSource = self
        bottomConstrains.constant = -320
        searchview.isHidden = true
        reset.isHidden = true
        search.isHidden = true
        menu.setTitle("", for: .normal)
        filter.setTitle("", for: .normal)
        pdf.setTitle("", for: .normal)
        customers.backgroundColor = UIColor(hex: "F5F9FC")
        paid.backgroundColor = UIColor(hex: "F5F9FC")
        Global.shared.configuredDropDown(dropDown: paid, array: ["Paid", "UnPaid", "Partial"]) { selectedText in
            // Handle the selected text from the 'paid' dropdown
            self.payment_status = selectedText
            
            
            
        }
        
        fetchCusomters()
        fetchsalesList()
    }
    
    func fetchCusomters(){
        salesViewModel.employeFetching(whenFinish: { [self]result in
            switch result {
            case .success(let data ):
         
                for dat in data.data!{
                    
                    self.salesArray.append(dat)
                    self.stringArray.append(dat.name)
                    self.idArray.append(dat.id)
                    Global.shared.configuredDropDownwithid(dropDown: customers, array: stringArray, ids: idArray ) { selectedText, id  in
                
                        self.customerName = selectedText
                        self.custumerId = id
                        for ar in  stringArray
                        {
                            if customerName == ar{
                                
                              
                            }
                        }
                        // Handle the selected text from the 'paid' dropdown
                        
                    }
                }
            case .failure(let error):
                print("errror",error)
            }
        }
        )
    }
    
    
    
  

func fetchsalesList(){
    salesViewModel.fetchlist(whenFinish: { [self]result in
        
        switch result {
        case .success(let res ):
         
            saleList = res.data.data
            //    print("count",saleList.count)
            tableview.reloadData()
           
        case .failure(let error):
            print(error)
        }
    })
}

}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want t do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
extension  salesviewcontrolller: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hsalesCell") as!  hsalescellsTableViewCell
        
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
        let cell: salesCells
        if saleList.isEmpty {
            mainview.isHidden = true
            emptylabel.isHidden = false
            emptylabel.text = "no data"
            emptylabel.textColor = .black
            buttonstack.isHidden = true
            cell = tableView.dequeueReusableCell(withIdentifier: "salesCells", for: indexPath) as! salesCells
        } else {
            buttonstack.isHidden = false
            mainview.isHidden = false
            emptylabel.isHidden = true
     
            
            cell = tableView.dequeueReusableCell(withIdentifier: "salesCells", for: indexPath) as! salesCells
            
            if indexPath.row % 2  == 0  {
                cell.colorset(color1: UIColor(hex: 0xF5F9FC))
            } else {
                cell.colorset(color1: .white)
            }
            
            let currentCustomer = saleList[indexPath.row]
            cell.orderiddelegate = self
            cell.delegate = self
            cell.date.text = currentCustomer.date
            cell.discount.text = String(currentCustomer.discount)
            cell.name.text = currentCustomer.customer_name
            cell.serialNumber.text = String(indexPath.row + 1)
            cell.totalBill.text  = String(currentCustomer.total_bill)
            cell.tax.text = String(currentCustomer.tax)
            cell.pad.text = currentCustomer.payment_status
            cell.configure(position:currentCustomer)
            
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if saleList.isEmpty {
            return 0 // Return 1 to show the empty message cell
        } else {
            return saleList.count
        }
    }
  
}





        

    
