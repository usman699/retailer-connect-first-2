//
//  purchaseorderViewController.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 18/04/2024.
//


import UIKit
import SideMenu


class purchaseorderViewController: UIViewController , returndelegate{
    var detailid :Int!
    func returnf() {
        
        model.partialreturn(id: orderId, order_id: detailid!, completion: { [self]result in
            switch result {
            case .success(let res ):
               
                print("message", res.message )
             
                tableview.reloadData()
                 orderdetailfunc()
            case .failure(let errors):
                switch (errors){
                    
                case .decodingError:
                    print("decoding eror ")
                case .notFound:
                    print("not found")
                    orderArray = []
                    tableview.reloadData()
                case .conflict:
                
                        Global.shared.showMsg(msg: "Failiure", title: "Your paid amount is not enough to return\n this product")
                    
                    print("conflict")
                case .unknownError:
                    print("unkown")
                case .unresponseEntity:
                    print("unreponseEntity")
                case .outofstack:
                    print("out of stack")
                }
                print("error")
//                if errors.message == "your paid amount is not enough to return this product"{
//                    Global.shared.showMsg(msg: "Failiure", title: "Your paid amount is not enough to return\n this product")
//                }
             
            }
        })
    }
    
    var menu: SideMenuNavigationController!
    
    
    @IBAction func menubutton(_ sender: Any) {
        present(menu!, animated: true)
    }
    
    @IBOutlet weak var tableview: UITableView!
    var orderArray = [OrderDetail]()
    struct  info {
        let name: String
        let phone: Int
        let address: Int
    }
    
  //  @IBOutlet weak var tableviewhieghtconstant: NSLayoutConstraint!
    @IBOutlet weak var mainname: UILabel!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var tax: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var subtotal: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    var orderId = Int()
    var model =  purchaseviewmodel()
    @IBOutlet weak var ordernumber: UILabel!
    @IBOutlet weak var menubuttn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        UIElementsManager.shared.setViewSettingWithBgShade(view: tableview)
        tableview.register(UINib(nibName: "horderdetail", bundle: nil), forCellReuseIdentifier: "horderdetail")
        tableview.delegate = self
        tableview.dataSource = self
        let secondNib = UINib(nibName: "orderdetail", bundle: nil)
        tableview.backgroundColor = .white
        tableview.register(secondNib, forCellReuseIdentifier: "orderdetailcell")
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menubuttn.setTitle("", for: .normal)
        orderdetailfunc()
  //      Global.shared.updateTableViewHeight(tableview: tableview, hieightconstant: tableviewhieghtconstant, view: view)
    }
  

    func orderdetailfunc(){
        let loadingView = Loading.instanceFromNib()
//        // Assuming you are in a view controller, you can add the loading view as a subview
//        self.view.addSubview(loadingView)
//        loadingView.present(size: self.view.bounds)
//        self.view.addSubview(loadingView)
        menubuttn.setTitle("", for: .normal)
        model.viewpurchaseorder(orderid:orderId, completion: { [self]result in
            switch result {
            case .success(let res ):
   
                print(res.success.description)
                orderArray = res.data.orderDetails
                
                for i in res.data.orderDetails{
               
                   print("discount", i.discount)
                    
                }
                phone.text = res.data.supplierInfo.phone
                
                
                name.text = res.data.supplierInfo.name
                address.text = res.data.supplierInfo.address
                total.text =   " \(res.data.order.grandTotal)/-"
                discount.text =   " \(  res.data.order.discount)/-"
                subtotal.text =    " \(  res.data.order.subtoTal)/-"
                ordernumber.text =  String(orderId)
                tax.text =  " \( res.data.order.tax )/-"
                discount.text = " \( res.data.order.discount )/-"
                for i in res.data.orderDetails{
                    detailid = i.id
                }
                mainname.text = res.data.supplierInfo.name
             
                tableview.reloadData()
       //   loadingView.dismiss()
       
                
            case .failure(let error):
                switch (error ){
                    
                case .decodingError:
                    print("decoding eror ")
                case .notFound:
                    print("not found")
                    orderArray = []
                    tableview.reloadData()
                case .conflict:
                    print("conflict")
                case .unknownError:
                    print("unkown")
                case .unresponseEntity:
                    print("unreponseEntity")
                case .outofstack:
                    print("out of stack")
                }
        //      loadingView.dismiss()
            }
        })
    }
}
extension  purchaseorderViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "horderdetail") as! horderdetail
        
        // Customize the header cell as needed
        
        // Add the header cell to the header view
        headerView.addSubview(headerCell)
        
        // You might need to adjust the frame of the header cell within the header view
        headerCell.frame = CGRect(x: 0, y: -20, width: tableView.bounds.width, height: 48)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderdetailcell", for: indexPath) as! orderdetail
        let currentposition = orderArray[indexPath.row]
    //    cell.name.text = currentposition.name
        cell.index.text = String(indexPath.row+1 )
        cell.price.text =             " \(currentposition.price)/-"
        cell.productcode.text =       String(currentposition.code)
        cell.quantity.text =          " \(currentposition.quantity)/-"
        cell.tax.text =               " \(currentposition.tax)"
        cell.totalbill.text =         " \(currentposition.total)/-"
        cell.delegate = self
           return cell
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return orderArray.count
    }
}

