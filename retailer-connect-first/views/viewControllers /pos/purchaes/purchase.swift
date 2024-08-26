//
//  importpurchase.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 05/04/2024.
//

import UIKit
import iOSDropDown
import SideMenu

class importpurchase: UIViewController, minusdelegate, deletedelegate, discountdelegate, plusdelegate, unheight,hieghtdelegate,refreshtableview,  UIDocumentInteractionControllerDelegate {
    func refersh() {
        totalamout.text = ""
        
        purchasefetchcart()
    }
    
    func unsetheight() {
        heightdeledate.constant = heightdeledate.constant - 320
    }
    
    func setheight() {
        heightdeledate.constant = heightdeledate.constant + 320
    }
    
    func plus() {
        purchasefetchcart()
    }
    @IBAction func pdf(_ sender: Any) {
        let pdf_file = UIDocumentInteractionController(url: URL(fileURLWithPath: Global.shared.pdfDataWithTableView(tableView: self.tableview, view: self.view)))
        pdf_file.delegate = self
        
        pdf_file.presentPreview(animated: true)
    }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
       return self
    }
    @IBOutlet weak var heightdeledate: NSLayoutConstraint!
    func discount(text: String) {
        
purchasefetchcart()
    }
    
    func delete(id: Int) {
        
        
        model.deletCart( id : id , completion: { [self]result in
            print(id)
              switch result {
              case .success(let success):
                
                 print("successfully deleted")
                purchasefetchcart()
              case .failure(let error ):
                  switch error {
                      
                  case .decodingError:
                      print("decoding eror ")
                  case .notFound:
               
                   fetchCart = []
                      tableview.reloadData()
                      print("not found")
                  case .conflict:
                      print("conflick error ")
                 
                  case .unknownError:
                      print("unkown")
                  case .unresponseEntity:
                      print("unreponseEntity")
                  case .outofstack:
                      print("out of stack")
                  }
              }
          })
    }
    
    func minus() {
        purchasefetchcart()
    }
    @IBOutlet weak var productcodetextfeild: CustomTextField!
    @IBAction func productcodetextfeild(_ sender: Any) {
    }
    @IBAction func addtocart(_ sender: Any) {
        
        
        if productcodetextfeild.text?.isEmpty == true {
            Global.shared.showMsg(msg: "", title: "please enter valid product code ")
            return
        }
        model.addtocart(productid: Int(productcodetextfeild.text!)! , completion:  { [self]result in
              switch result {
              case .success(let success):
                  print("succcess")
                  purchasefetchcart()
              case .failure(let error ):
                  switch error {
                  case .decodingError:
                      print("decoding eror")
                  case .notFound:
                      Global.shared.showMsg(msg: "", title: "cart is empty")
                      print("not found")
                  case .conflict:
                      Global.shared.showMsg(msg: "fail", title:"")
                      print("conflick error ")
                  case .unknownError:
                      print("unkown")
                  case .unresponseEntity:
                      Global.shared.showMsg(msg: "", title: "The selected product code is invalid")
                      print("unreponseEntity")
                  case .outofstack:
                      print("out of stack")
                  }
              }
          })

    }
    @IBOutlet weak var totaldiscount: UILabel!
    @IBOutlet weak var add: UIButton!
    @IBAction func generatebill(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "-MM-dd-yyyy"
            dates = dateFormatter.string(from: date.date)
        print(suppliersId, recevied, paid.text, trasaction, dates)
        if (suppliersId == nil || paymentid == nil || paid.text?.isEmpty == true || trasactionType.isEmpty == true || dates.isEmpty == true ) {
            Global.shared.showMsg(msg: "", title: "please fill all entries")
            return
        }

        model.generateBill(supplierid: suppliersId, paymentid: paymentid,received: Int( paid.text!)!, trassactionType: trasactionType, completion:  { [self]result in
              switch result {
              case .success(let success):

                  totalamout.text = "0"
                  totalitems.text = "0"
                  totaldiscount.text = String(0)
                  fetchCart = []
                  tableview.reloadData()
                //  purchasefetchcart()
              case .failure(let error ):
                  switch error {
                      
                  case .decodingError:
                      print("decoding eror ")
                  case .notFound:
                      Global.shared.showMsg(msg: "", title: "cart is empty")
                      fetchCart = []
                      tableview.reloadData()
                      print("not found")
                  case .conflict:
                      print("conflick error ")
                 
                  case .unknownError:
                      print("unkown")
                  case .unresponseEntity:
                      print("unreponseEntity")
                  case .outofstack:
                      print("out of stack")
                  }
              }
          })
    }
    @IBAction func holdbill(_ sender: Any) {
            let customAlertVC = retailer_connect_first.holdbill()
        customAlertVC.delegate = self
               // Customize the presentation style if needed
               customAlertVC.modalPresentationStyle = .overFullScreen
               // Present the custom alert view controller
               present(customAlertVC, animated: true, completion: nil)
    }
    
    @IBOutlet weak var lablesupplier: UILabel!
    @IBOutlet weak var emptyCart: UIButton!
    
    @IBAction func emptycart(_ sender: Any) {
        model.emptycart( completion: { [self]result in
              switch result {
              case .success(let success):
                  totalamout.text = "0"
                  totalitems.text = "0"
                  totalDiscount = 0
                
                  fetchCart = []
                  tableview.reloadData()
              case .failure(let error ):
                  switch error {
                      
                  case .decodingError:
                      print("decoding eror ")
                  case .notFound:
                      Global.shared.showMsg(msg: "", title: "cart is empty")
                      fetchCart = []
                      tableview.reloadData()
                      print("not found")
                  case .conflict:
                      print("conflick error ")
                 
                  case .unknownError:
                      print("unkown")
                  case .unresponseEntity:
                      print("unreponseEntity")
                  case .outofstack:
                      print("out of stack")
                  }
              }
          })
            }
    @IBOutlet weak var  menuButton: UIButton!
    @IBOutlet weak var holdlist: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var generateBill: UIButton!
    @IBOutlet weak var holdbill: UIButton!
    @IBOutlet weak var selectSuppliers: DropDown!

    @IBOutlet weak var pdf: UIButton!
    @IBOutlet weak var totalitems: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var productbarcodetextfeild: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var paid: CustomTextField!
    @IBOutlet weak var selectTrasaction: DropDown!
    @IBOutlet weak var selectPayment: DropDown!
    @IBOutlet weak var total: CustomTextField!
    var buttons = [UIButton]()
    var suppliers = [String]()
    var supplierids = [Int]()
    var payment = [String]()
    var paymentids = [Int]()
    var trasaction = [String]()
    var trasactionids = [Int]()
    var suppliersId: Int!
    var trasactionType:String!
    var paymentid:Int!
    var recevied:Int!
    var dates:String!
    var totalDiscount = 0
    @IBOutlet weak var totalamout: UILabel!
    var fetchCart = [puchasecartdata]()
    var model = purchaseviewmodel()
    var menu:SideMenuNavigationController!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingui()
        productcodetextfeild.delegate = self
        fetchsuplliers()
        fetchpayment()
        fetchtrasaction()
        purchasefetchcart()
        
    }
  func   purchasefetchcart(){
            model.fetchputchasecart( completion: {
             [self]result in
             switch result {
             case .success(let success):
             print("success from purcahse cart")
             fetchCart = success.data.data
              
             total.text = String(success.data.totalBill)
             totalamout.text = String( success.data.totalBill)
                 
                 
                 
              
                 totaldiscount.text =  String(success.data.total_discount)
                 
                 
                 
             self.tableview.reloadData()
             case .failure(let error ):
             switch error {
                    
                case .decodingError:
                    print("FROM PURCHASE FETCHING decoding eror")
                case .notFound:
                 fetchCart = []
                 tableview.reloadData()
                    print("FROM PURCHASE FETCHING not found")
                case .conflict:
                    print("FROM PURCHASE FETCHING conflick error")
               
                case .unknownError:
                    print("FROM PURCHASE FETCHING unkown")
                case .unresponseEntity:
                    print("unreponseEntity")
                case .outofstack:
                    print("FROM PURCHASE FETCHING out of stack")
                }
            }
        })
    }
    func fetchsuplliers(){
        model.fetchsuppliers( completion: { [self]result in
              switch result {
              case .success(let success):
                  for i in success.data{
                      suppliers.append(i.name)
                      supplierids.append(i.id)
                  }
              
                  Global.shared.configuredDropDownwithid(dropDown: selectSuppliers, array: self.suppliers, ids: self.supplierids, didSelect: {selectedtext,id in
                      print("data of cutomer", selectedtext,id)
                      lablesupplier.isHidden = true
                      suppliersId = id
                  })
                  self.tableview.reloadData()
              case .failure(let error ):
                  switch error {
                      
                  case .decodingError:
                      print("decoding eror ")
                  case .notFound:
                      print("not found")
                  case .conflict:
                      print("conflick error ")
                 
                  case .unknownError:
                      print("unkown")
                  case .unresponseEntity:
                      print("unreponseEntity")
                  case .outofstack:
                      print("out of stack")
                  }
              }
          })
    }
    func fetchpayment(){
        model.fetchpayment( completion: { [self]result in
              switch result {
              case .success(let success):
                  for i in success.data{
                      payment.append(i.name)
                      paymentids.append(i.id)
                  }
              
                  Global.shared.configuredDropDownwithid(dropDown: selectPayment, array: self.payment, ids: self.paymentids, didSelect: {selectedtext,id in
                      print("data of cutomer", selectedtext,id)
                      labelpayment.isHidden = true
                      paymentid = id
                  })
                  self.tableview.reloadData()
              case .failure(let error ):
                  switch error {
                      
                  case .decodingError:
                      print("decoding eror ")
                  case .notFound:
                      print("not found")
                  case .conflict:
                      print("conflick error ")
                 
                  case .unknownError:
                      print("unkown")
                  case .unresponseEntity:
                      print("unreponseEntity")
                  case .outofstack:
                      print("out of stack")
                  }
              }
          })
    }
    @IBOutlet weak var labletrasaction: UILabel!
    @IBOutlet weak var labelpayment: UILabel!
    func fetchtrasaction(){
        model.fetchTrasaction( completion: { [self]result in
              switch result {
              case .success(let success):
                  
                  trasaction = success.data
                  print(success.data)

                  Global.shared.configuredDropDown(dropDown: selectTrasaction, array: self.trasaction, didSelect: { selectedText in
                     trasactionType = selectedText
                      self.labletrasaction.isHidden = true
                      
                  })
                  self.tableview.reloadData()
              case .failure(let error ):
                  switch error {
                      
                  case .decodingError:
                      print("decoding eror ")
                  case .notFound:
                      print("not found")
                  case .conflict:
                      print("conflick error ")
                 
                  case .unknownError:
                      print("unkown")
                  case .unresponseEntity:
                      print("unreponseEntity")
                  case .outofstack:
                      print("out of stack")
                  }
              }
          })
    }
    @IBAction func holdlist(_ sender: Any) {
        let storyboard = UIStoryboard(name: "purchase", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "holdpurchasebill")
        present(initialViewController, animated: false)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func settingui(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
       //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
       //tap.cancelsTouchesInView = false
        tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
        recevied = Int(paid.text!)
        add.setTitle("", for: .normal)
        totalitems.text =  String(fetchCart.count)
        //Looks for single or multiple taps.
   //    totalitems = fetchlist

        buttons = [generateBill, holdbill, emptyCart, holdlist]
        for i in buttons {
            i.titleLabel?.font = UIFont.systemFont(ofSize: 14)
          
        }
        menuButton.setTitle("", for: .normal)
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        tableview.register(UINib(nibName: "HPOSTableViewCell", bundle: nil), forCellReuseIdentifier: "hpos")
        tableview.delegate = self
        tableview.dataSource = self
        let secondNib = UINib(nibName: "POSTableViewCell", bundle: nil)
        tableview.backgroundColor = .white
        tableview.register(secondNib, forCellReuseIdentifier: "pos")
        pdf.setTitle("", for: .normal)
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
extension importpurchase: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hpos") as!  HPOSTableViewCell
        
        // Customize the header cell as needed
        
        // Add the header cell to the header view
        headerView.addSubview(headerCell)
        
        // You might need to adjust the frame of the header cell within the header view
        headerCell.frame = CGRect(x: 0, y: -20, width: tableView.bounds.width, height: 49)
        
        return headerView
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  67
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell = tableView.dequeueReusableCell(withIdentifier: "pos", for: indexPath) as! POSTableViewCell
        let currentpostion = fetchCart[indexPath.row]
        cell.code.text = String( currentpostion.code)
        cell.price.text =  String( currentpostion.purchasePrice)
        cell.product.text = currentpostion.productName
        cell.quantitylable.text = String( currentpostion.qty)
        cell.tax.text = String( currentpostion.tax)
        cell.total.text = String( currentpostion.total)
        cell.indexumber.text = String( indexPath.row + 1 )
        totalitems.text = String( fetchCart.count)
        
        cell.minusdelegate = self
        cell.plusdelegate = self
        cell.deletedelegate = self
        cell.discountdelete = self
 
        cell.configure2( position:  currentpostion)
        return cell

    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return  fetchCart.count // Or whatever number you need for the second table
  
    }
}


extension importpurchase: UITextFieldDelegate {
   
    // UITextFieldDelegate method called when the text field becomes the first responder
    func textFieldDidBeginEditing(_ textField: UITextField) {
        heightdeledate.constant = heightdeledate.constant + 320
       // setRoundedCorner(for: textField, cornerRadius: textField.frame.size.height / 2)
    }

    // UITextFieldDelegate method called when the text field resigns its first responder status
    func textFieldDidEndEditing(_ textField: UITextField) {
        heightdeledate.constant = heightdeledate.constant - 320
        // Reset the border color, shadow, and corner radius when the editing ends
      //  UIElementsManager.shared.resetStyleAfterEditing(textField)
    }

    // Helper method to set border color and shadow
  

    // Helper method to set corner radius
    private func setRoundedCorner(for textField: UITextField, cornerRadius: CGFloat) {
        textField.layer.cornerRadius = cornerRadius
    }

    private func setPlaceholderColor(for textField: UITextField, color: UIColor) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
        ]
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: attributes)
    }

    
        
    
}
