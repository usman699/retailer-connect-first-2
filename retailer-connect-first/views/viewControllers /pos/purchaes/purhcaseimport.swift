//
//  purchaseimportViewController.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 16/04/2024.
//



import UIKit
import iOSDropDown
import SideMenu
import Alamofire
class purchaseimportViewController: UIViewController, minusdelegate, deletedelegate, discountdelegate, plusdelegate, unheight,hieghtdelegate,refreshtableview,  UIDocumentInteractionControllerDelegate, UIDocumentPickerDelegate {
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
 
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
       return self
    }
    @IBOutlet weak var heightdeledate: NSLayoutConstraint!
    func discount(text: String) {
        
purchasefetchcart()
    }
    var filepath = URL(string: "")
    @IBAction func Uploadfile(_ sender: Any) {
        
     
        
        
        
        
                let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
                documentPicker.delegate = self
                documentPicker.allowsMultipleSelection = false
                documentPicker.modalPresentationStyle = .formSheet
                present(documentPicker, animated: true, completion: nil)
        
        
        
        
        
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
           guard let selectedFileURL = urls.first else {
               return
           }
        
        filepath = selectedFileURL
           // Do something with the selected file URL
           print("Selected file URL: \(selectedFileURL)")
       }

       func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
           // Handle cancellation
           print("Document picker was cancelled")
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
  
    
 
    @IBOutlet weak var totaldiscount: UILabel!
  
    @IBAction func generatebill(_ sender: Any) {
        let headers: HTTPHeaders = [.authorization(bearerToken:  Global.shared.Globaltoken)]
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dates = dateFormatter.string(from: date.date)
        print(suppliersId, recevied, paid.text, trasaction, dates)
        if (suppliersId == nil || paymentid == nil || paid.text?.isEmpty == true || trasactionType.isEmpty == true || dates.isEmpty == true ) {
            Global.shared.showMsg(msg: "", title: "please fill all entries")
            return
        }
       
        
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(self.filepath!, withName: "file", fileName: "example.xlsx", mimeType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
                  
    
        }, to: "https://api.retailer-connect.com/api/purchases/import-purchase?supplier_id=\(String(describing: suppliersId!))&payment_id=\(paymentid!)&received=\(paid.text!)&transaction_type=\(trasactionType!)&date=\(dates!)", headers: headers)
            .response { response in
                if (response.response?.statusCode == 200 ){
                    Global.shared.showMsg(msg: "", title: "successfully added ")
                }
                debugPrint(response)
            }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        model.generateBill(supplierid: suppliersId, paymentid: paymentid,received: Int( paid.text!)!, trassactionType: trasactionType, completion:  { [self]result in
//              switch result {
//              case .success(let success):
//
//                  totalamout.text = "0"
//                  totalitems.text = "0"
//                  totaldiscount.text = String(0)
//                  fetchCart = []
//      
//                //  purchasefetchcart()
//              case .failure(let error ):
//                  switch error {
//                      
//                  case .decodingError:
//                      print("decoding eror ")
//                  case .notFound:
//                      Global.shared.showMsg(msg: "", title: "cart is empty")
//                      fetchCart = []
//                   
//                      print("not found")
//                  case .conflict:
//                      print("conflick error ")
//                 
//                  case .unknownError:
//                      print("unkown")
//                  case .unresponseEntity:
//                      print("unreponseEntity")
//                  case .outofstack:
//                      print("out of stack")
//                  }
//              }
//          })
    }
  
    @IBOutlet weak var lablesupplier: UILabel!
   
    

    @IBOutlet weak var  menuButton: UIButton!
    @IBOutlet weak var holdlist: UIButton!

    @IBOutlet weak var generateBill: UIButton!
    @IBOutlet weak var holdbill: UIButton!
    @IBOutlet weak var selectSuppliers: DropDown!

   
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
                 
                 
                 
      
             case .failure(let error ):
             switch error {
                    
                case .decodingError:
                    print("FROM PURCHASE FETCHING decoding eror")
                case .notFound:
                 fetchCart = []
          
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
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "purchaselholdlist")
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
  
        totalitems.text =  String(fetchCart.count)
        //Looks for single or multiple taps.
   //    totalitems = fetchlist

        buttons = [generateBill, holdlist]
        for i in buttons {
            i.titleLabel?.font = UIFont.systemFont(ofSize: 14)
          
        }
        menuButton.setTitle("", for: .normal)
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
       
      

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


extension purchaseimportViewController: UITextFieldDelegate {
   
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

