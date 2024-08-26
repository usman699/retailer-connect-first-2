//
//  paymenthistory.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 22/03/2024.
//

import UIKit

//
//  orderViewController.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 20/03/2024.
//

import UIKit
import SideMenu

class paymenthistory: UIViewController{

    @IBAction func paybill(_ sender: Any) {
    }
    var menu: SideMenuNavigationController!
    @IBAction func menubutton(_ sender: Any) {
        present(menu!, animated: true)
    }
    @IBOutlet weak var tableview: UITableView!
    var orderArray = [orderdetaildata]()
    struct  info {
        let name: String
        let phone: Int
        let address: Int
    }
    var model = paymenthistoryViewmodel()
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var tax: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var subtotal: UILabel!
    var historyId = Int()
    var orderdetail =  orderViewmodel()
    @IBOutlet weak var menubuttn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("history id ", historyId)
        tableview.register(UINib(nibName: "hpaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "hpayment")
        tableview.delegate = self
        tableview.dataSource = self
        let secondNib = UINib(nibName: "paymentTableViewCell", bundle: nil)
        tableview.backgroundColor = .white
        tableview.register(secondNib, forCellReuseIdentifier: "paymenthistory")
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menubuttn.setTitle("", for: .normal)
        orderdetailfunc()
        
    }
    func orderdetailfunc(){
        
        model.partialOrderReturn(id: historyId ,completion: {result in
            switch result {
            case .success(let success):
                print("fetched")
            case .failure(_):
                print("failure")
            }
            
        })
        
    }}
extension  paymenthistory: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(hex: 0xF5F9FC)
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hpayment") as! hpaymentTableViewCell
        
        // Customize the header cell as needed
        
        // Add the header cell to the header view
        headerView.addSubview(headerCell)
        
        // You might need to adjust the frame of the header cell within the header view
        headerCell.frame = CGRect(x: 0, y: -20, width: tableView.bounds.width, height: 35)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymenthistory", for: indexPath) as! paymentTableViewCell
       
        
           return cell
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return 10
    }
}

