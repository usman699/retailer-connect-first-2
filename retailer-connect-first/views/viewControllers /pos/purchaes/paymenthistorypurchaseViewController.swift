//
//  paymenthistorypurchaseViewController.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 18/04/2024.
//


import UIKit



import UIKit
import SideMenu

class paymenthistorypurchaseViewController: UIViewController , paydelegates{
    func paynow() {
        orderdetailfunc()
    }
    
    func paynow(id: Int, recevie: String) {
          
//        print("id and recvieed ",id, recevie)
//        model.paynow(id: id, recevied:recevie , completion: { [self] result in
//            switch result {
//                
//            case .success(let success):
//                
//                print("success", success.message)
//                
//                if success.message == "success"{
//                    tableview.reloadData()
//                    dismiss(animated: true)
//                    orderdetailfunc()
//                }
//                if success.message ==    "invalid received payment !"{
//                    Global.shared.showMsg(msg: "", title: "invalid received payment !")
//                }
//                
//            case .failure(let er):
//                switch er{
//                case .conflict :
//                    print("conflit")
//                    Global.shared.showMsg(msg: "", title: "invalid received payment !")
//                case .decodingError:
//                    print("erros decoding  ")
//                case .notFound:
//                    print("erros not found  ")
//                case .unknownError:
//                    print("erros unkown eror r ")
//                case .unresponseEntity:
//                    print("unreponseEntity")
//                case .outofstack:
//                    print("out of stack")
//                }
//            
//                    
//            print("faliture ")
//            }
//        })
    }
    
    
    
    var receviedss  : Int!
    var totall  : Int!
    @IBAction func paybill(_ sender: Any) {
        DispatchQueue.main.async { [self] in
            let storyboard = UIStoryboard(name: "purchase", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "payhistoryalertss") as!
            historybillViewController
            initialViewController.totall = self.totall
//            initialViewController.totall = self.totall
            initialViewController.pendings =  pending
            initialViewController.id = historyId
            initialViewController.Delegate = self

           present(initialViewController, animated: false)
            
            
        }
    
        
    }
    var pending:Int!
    var totalbillS:Int = 0
    var paids = Int()
    @IBOutlet weak var paybill: UIButton!
    @IBOutlet weak var hiehgt: NSLayoutConstraint!
    var menu: SideMenuNavigationController!
    @IBAction func menubutton(_ sender: Any) {
        present(menu!, animated: true)
    }
    @IBOutlet weak var tableview: UITableView!
    var grandtotal = Int()
    struct  info {
        let name: String
        let phone: Int
        let address: Int
    }
    var arrayhistory = [PaymentDatails]()
    var model = purchaseviewmodel()
 //   @IBOutlet weak var total: UILabel!

    @IBOutlet weak var totalreceived: UILabel!
    @IBOutlet weak var totalbill: UILabel!
    var historyId = Int()
    @IBOutlet weak var paymentStatus: UILabel!
    var orderdetail =  orderViewmodel()
    @IBOutlet weak var menubuttn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("history id ", historyId)
        tableview.register(UINib(nibName: "HpurchasehistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "hpurchasehistory")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor =  .white
        let secondNib = UINib(nibName: "purchasehistoryTableViewCell", bundle: nil)
        tableview.backgroundColor = .white
        tableview.register(secondNib, forCellReuseIdentifier: "purchasehistory")
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menubuttn.setTitle("", for: .normal)
        orderdetailfunc()
        UIElementsManager.shared.setViewSettingWithBgShade(view: tableview)
    //    updateTableViewHeight()

    }
//    func updateTableViewHeight() {
//        tableview.reloadData()
//        tableview.layoutIfNeeded()
//
//        let contentHeight = tableview.contentSize.height
//        let maximumAllowedHeight = view.bounds.height * 0.6 // 60% of available height
//        let fixedHeight = CGFloat(200) // Set your desired fixed height here
//
//        if contentHeight <= maximumAllowedHeight {
//            // If content height is within 60% of available height, allow dynamic height
//            tableview.isScrollEnabled = true
//            hiehgt.constant = contentHeight + 55
//        } else {
//            // If content height exceeds 60% of available height, set fixed height with scrolling
//            tableview.isScrollEnabled = true
//            hiehgt.constant = fixedHeight + 55
//        }
//
//    }
    

    func orderdetailfunc(){
        
        model.paymentHistory(orderid: historyId ,completion: {result in
            switch result {
            case .success(let success):
                print("fetched")
                print(success.success)
                self.arrayhistory = success.data.paymentDatails
                for i in success.data.paymentDatails{
                    self.pending = i.due
                    print(i.received)
                }
                self.totalbillS = success.data.orderDetails.totalBill
           
                self.totalbill.text =       "Rs \(  String( success.data.orderDetails.totalBill))/-"
                self.totalreceived.text =       "Rs \( String( success.data.orderDetails.received))/-"
                self.paymentStatus.text = String( success.data.orderDetails.paymentStatus)
                self.paids = Int( success.data.orderDetails.received )
                self.totall = success.data.orderDetails.totalBill
                self.receviedss  = success.data.orderDetails.received
                if self.totall - self.receviedss  == 0 {
                    self.paybill.isHidden = true
                }
                else{
                    self.paybill.isHidden = false
                }
                self.tableview.reloadData()
                print("count", self.arrayhistory.count)
            case .failure(_):
                print("failure")
            }
            
        })
        
    }}
extension  paymenthistorypurchaseViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(hex: 0xF5F9FC)
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hpurchasehistory") as! HpurchasehistoryTableViewCell
        
        // Customize the header cell as needed
        
        // Add the header cell to the header view
        headerView.addSubview(headerCell)
        
        // You might need to adjust the frame of the header cell within the header view
        headerCell.frame = CGRect(x: 0, y: -20, width: tableView.bounds.width, height: 55)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchasehistory", for: indexPath) as! purchasehistoryTableViewCell
        let currentpostion = arrayhistory[indexPath.row]
        cell.index.text  =  String(indexPath.row + 1)
       
        cell.trasactiontype.text = "\(  currentpostion.transactionType )"
        cell.paymenttype.text = "\(  currentpostion.paymentType )"
        cell.pending.text  =  "\( currentpostion.due ) /-"
        cell.date.text  =  "\( currentpostion.date )"
        cell.total.text =  "\( totalbillS ) /-"
        cell.paid.text = String (paids)
         
           return cell
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return  arrayhistory.count
    }
}

