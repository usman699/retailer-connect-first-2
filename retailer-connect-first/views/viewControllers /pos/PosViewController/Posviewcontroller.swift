//
//  cardViewController.swift
//  retailer-connect-first
//
//  Created by Spark on 22/12/2023.
//

import UIKit
import iOSDropDown
import SideMenu
class POS: UIViewController, discountdelegate, deletedelegate, UIDocumentInteractionControllerDelegate, plusdelegate,minusdelegate{
   
    
    func plus() {
    fetchcartlist()
    }
    
    func minus() {
        fetchcartlist()
    }
    
    func delete(id: Int) {
        print("id is ",id)
        model.deleteCart(Product_id:  id, completion: { [self]Result in
            switch Result
            {
            case .success(let success):
                print("deletted success")
                fetchcartlist()
            case .failure(let error):
                switch error {
                    
                case .decodingError:
                    print("decoding eror ")
                case .notFound:
                    print("not found")
                case .conflict:
                    print("conflict")
                case .unknownError:
                    print("unkown")
                case .unresponseEntity:
                    print("unresponde entity")
                case .outofstack:
                    print("out of stack")
                }
            }
            
        })
    }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
       return self
    }
    @IBOutlet weak var recviedAmount: UILabel!
    
    @IBAction func pdf(_ sender: Any) {
        let pdf_file = UIDocumentInteractionController(url: URL(fileURLWithPath: Global.shared.pdfDataWithTableView(tableView: self.tableview, view: self.view)))
        pdf_file.delegate = self
        
        pdf_file.presentPreview(animated: true)
    }
    @IBOutlet weak var selectlable: UILabel!
    @IBAction func genrateBill(_ sender: Any) {
  
        if selectedid == nil  || recieved.text?.isEmpty == true{
            customerlable.isHidden = false
            recviedAmount.isHidden = false
            return
        }
        else{
            recviedAmount.isHidden = true
            customerlable.isHidden = true
        }
        model.generateBill(Customer: selectedid, received:   Int(recieved.text ?? "0")!  ,  completion: { [self]Result in
            switch Result
            {
            case .success(let success):
                print("generate bill success")
                fetchlist = []
                recieved.text = ""
                selectCustomer.isSelected = false
                totalbill.text = "Rs:\(0)"
                discountlable.text = "Rs:\(0)"
                totalamount.text = "Rs:\(0)"
                grandtotaltextfeild.text = "Rs:\(0)"
                tableview.reloadData()
            case .failure(let error):
                switch error {
                    
                case .decodingError:
                    print("decoding eror ")
                case .notFound:
                    print("not found")
                case .conflict:
                    print("conflict")
                case .unknownError:
                    print("unkown")
                    Global.shared.showMsg(msg: "", title: "Cart is Empty")
                case .unresponseEntity:
                    print("unresponde entity")
                case .outofstack:
                    print("out of stack")
                }
            }
            
        })
    }
    @IBOutlet weak var mainview: UIView!
    var discount = String()
    func discount(text: String) {
          // Access the discount text entered in the cell here
  fetchcartlist()
      }

   
    @IBOutlet weak var customerlable: UILabel!
    
    @IBAction func holdbill(_ sender: Any) {
    
        let customAlertVC = retailer_connect_first.holdbill()
           
           // Customize the presentation style if needed
           customAlertVC.modalPresentationStyle = .overFullScreen
           
           // Present the custom alert view controller
           present(customAlertVC, animated: true, completion: nil)
        
     
    }
    var counter = Int()
    @IBOutlet weak var productbarcodetextfeild: CustomTextField!
    var menu:SideMenuNavigationController!
 
    @IBOutlet weak var pdf: UIButton!
  
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var up: UIButton!
    
    @IBOutlet weak var down: UIButton!
   
    @IBOutlet weak var stackview: UIStackView!
    var discountss:Int = 0
    @IBOutlet weak var totalbill: UILabel!
    @IBOutlet weak var totalamount: UILabel!
    @IBOutlet weak var discountlable: UILabel!
    @IBAction func m(_ sender: Any) {
        present(menu! , animated: true)
    }
    @IBAction func emptyCart(_ sender: Any) {
        
        model.emptyCart(  completion: { [self]Result in
            switch Result
            {
            case .success(let success):
                print("deletted success")
                
            case .failure(let error):
                switch error {
                    
                case .decodingError:
                    print("decoding eror ")
                case .notFound:
                    print("not found")
                case .conflict:
                    print("conflict")
                case .unknownError:
                    print("unkown")
                case .unresponseEntity:
                    print("unresponde entity")
                case .outofstack:
                    print("out of stack")
                }
            }
            
        })
        self.fetchlist = []
        
        totalbill.text = "Rs:\(0)"
        discountlable.text = "Rs:\(0)"
        totalamount.text = "Rs:\(0)"
        grandtotaltextfeild.text = "Rs:\(0)"
        tableview.reloadData()
        
    }
    @IBOutlet weak var tableview: UITableView!
    @IBAction func holdlist(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "PosStoryboard", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "holdlist")
        present(initialViewController, animated: false)
        
        
        
    }
    @IBAction func addtocart(_ sender: Any) {
        
    }
    @IBOutlet weak var addingtextfeild: UITextField!
    var productcode = String()
    var customermodel =  suppliersViewmodel()
    @IBOutlet weak var add: UIButton!
    @IBAction func add(_ sender: Any) {
        print("data ,",productcode)
        
        productcode =  addingtextfeild.text!
        model.addtocart(Product_code:  Int(productcode ) ?? 0, completion: {Result in
            switch Result
                {
            case .success(let success):
                self.fetchcartlist()
                print("success " , success.message)
                if success.message == "Product Out of Stock!"{
                    Global.shared.showMsg(msg: "", title: "Product Out of Stock")
                }
            case .failure(let error):
                switch error {
                    
                case .decodingError:
                    print("decoding eror ")
                case .notFound:
                    Global.shared.showMsg(msg: "", title: "not found ")
                    print("not found")
                case .conflict:
                    
                    print("conflict")
                case .unknownError:
                    print("unkown")
                case .outofstack:
                    Global.shared.showMsg(msg: "", title: "product out of stock")
                    
                case .unresponseEntity:
                    Global.shared.showMsg(msg: "", title: "The selected product code is invalid.")
                }
            }

            })
    }
   
    @IBOutlet weak var recieved: CustomTextField!
    @IBAction func textfeild(_ sender: Any) {
    }
    @IBOutlet weak var carcodetextfeild: UITextField!
    @IBOutlet weak var holdButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
   
    @IBOutlet weak var secondtableview: UITableView!
    
    @IBOutlet weak var emptyCard: UIButton!
    @IBOutlet weak var generatebill: UIButton!
    var  selectedid  = Int()
    var  fetchCustumerArray = [String]()
    @IBOutlet weak var grandTotal: UITextField!
    var receve = Int()
    var fetchlist = [Cartdata]()
    var model = posviewmodel()
    @IBOutlet weak var selectCustomer: DropDown!
    var optionalsIds = [Int]()
    @IBOutlet weak var select: DropDown!
    var buttons:[UIButton]!
    @IBOutlet weak var selectustomerLable: UILabel!
    @IBOutlet weak var holdBill: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        settingui()
        fetchingCustomer()
        fetchcartlist()
        addingtextfeild.keyboardType = .numberPad
        recieved.keyboardType = .numberPad
    
    }
    @IBOutlet weak var whiteview: SetShadow!
    @IBOutlet weak var grandtotaltextfeild: CustomTextField!
    func fetchcartlist(){
        print("fetch cart list ")
        model.fetchlist( completion: { [self] result in
       switch result
           {
           
       case .success(let success):
           
        
           print("success form pos",success.data.itemDetails)
           self.fetchlist = success.data.itemDetails
           self.discountlable.text = String( success.data.totalDiscount)
           self.totalbill.text =  String( fetchlist.count)
           self.totalamount.text = "\(success.data.totalBill  )"
           self.grandtotaltextfeild.text = String(success.data.totalBill)
           self.tableview.reloadData()
       case .failure(let error):
           switch error {
           case .decodingError:
               print("decoding eror ")
           case .notFound:
               self.fetchlist = []
               totalbill.text = "Rs:\(0)"
               discountlable.text = "Rs:\(0)"
               totalamount.text = "Rs:\(0)"
               grandtotaltextfeild.text = "Rs:\(0)"
               self.tableview.reloadData()
           case .conflict:
               print("conflict")
           case .unknownError:
               print("unkown")
           case .unresponseEntity:
               print("unresponse Entity")
           case .outofstack:
               print("out of stack")
           }
       }

       })
    }
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func settingui(){
        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false
             tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        recviedAmount.isHidden = true
        UIElementsManager.shared.setViewSettingWithBgShade(view:selectCustomer )
        customerlable.isHidden = true
        buttons = [generatebill, holdBill, emptyCard, holdButton]
        for i in buttons {
            UIElementsManager.shared.setViewSettingWithBgShade(view: i)
        }
        productcode =  addingtextfeild.text!
        carcodetextfeild.delegate = self
        carcodetextfeild.isUserInteractionEnabled = true
        grandtotaltextfeild.isUserInteractionEnabled = false
        grandtotaltextfeild.backgroundColor = .lightGray
        
        recieved.delegate = self
     
      //  grandTotal.delegate = self
    
       
        menuButton.setTitle("", for: .normal)
        // Do any additi   onal setup after loading the view.
        
        
     
     
     
           menu = SideMenuNavigationController(rootViewController: MenuSlider())
           menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        secondtableview.register(UINib(nibName: "HPOSTableViewCell", bundle: nil), forCellReuseIdentifier: "hpos")
        secondtableview.delegate = self
        secondtableview.dataSource = self
        
        let secondNib = UINib(nibName: "POSTableViewCell", bundle: nil)
        secondtableview.backgroundColor = .white
        secondtableview.register(secondNib, forCellReuseIdentifier: "pos")
        pdf.setTitle("", for: .normal)
       
        add.setTitle("", for: .normal)
 
    }
    func fetchingCustomer(){
        customermodel.FetchingSupplier{ result in
            switch result {
            case .success(let user):
                print("Success: \(user.data.count) items fetched")
           
                for i in user.data  {
                    self.optionalsIds.append(i.id)
                }
                for i in user.data {
                    self.fetchCustumerArray.append(i.name)
                }
                Global.shared.configuredDropDownwithid(dropDown: self.selectCustomer, array: self.fetchCustumerArray , ids: self.optionalsIds, didSelect: {selectedtext,id in
                    print("data of cutomer", selectedtext,id)
                    self.selectlable.isHidden = true
                    self.selectedid = id
                })
                self.tableview.reloadData()
              
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
}

extension POS: UITextFieldDelegate {
   
    // UITextFieldDelegate method called when the text field becomes the first responder
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIElementsManager.shared.applyStyleForEditing(textField)
        print("data fom textfeild", textField.text)
       // setRoundedCorner(for: textField, cornerRadius: textField.frame.size.height / 2)
    }

    // UITextFieldDelegate method called when the text field resigns its first responder status
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("data fom textfeild", textField.text)
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
extension POS: UITableViewDelegate, UITableViewDataSource{
    
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
        let currentpostion = fetchlist[indexPath.row]
        cell.code.text = String( currentpostion.code)

        cell.price.text =  String( currentpostion.price)
        cell.product.text = currentpostion.productName
        cell.quantitylable.text = String( currentpostion.qty)
    
        cell.tax.text = String( currentpostion.tax)
        cell.total.text = String( currentpostion.total)
        cell.indexumber.text = String( indexPath.row + 1 )
        cell.minusdelegate = self
        cell.plusdelegate = self
        cell.deletedelegate = self
        cell.discountdelete = self
        cell.configure( position:  currentpostion)
        return cell

    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return  fetchlist.count // Or whatever number you need for the second table
  
    }
}


