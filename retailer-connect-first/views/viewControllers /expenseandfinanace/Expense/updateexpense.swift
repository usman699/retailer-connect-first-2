
import UIKit
import iOSDropDown
import SideMenu
class Updateexpence: UIViewController {
    // outlets
    @IBOutlet weak var amount: CustomTextField!
    @IBOutlet weak var checkno: CustomTextField!
    @IBOutlet weak var desciptions: CustomTextField!
    @IBOutlet weak var paymenttypedropdown: DropDown!
    @IBOutlet weak var banckdropdown: DropDown!
    @IBOutlet weak var trasactiondropdown: DropDown!
    @IBOutlet weak var categoriesdropdown: DropDown!
    @IBOutlet weak var category: DropDown!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var name: CustomTextField!
    @IBAction func menubuttonaction(_ sender: Any) {
    }
    
    
    var nameL = String()
    var amountL = String()
    var dateL = String()
    var categoryL = Int()
    var trasactionL = String()
    var paymenttypeL = Int()
    var checknoL = String()
    var descriptionL = String()
    var bankL = Int()
    
    var categorystring = [String]()
    var categoryid = [Int]()
    var bankstring = [String]()
    var bankid = [Int]()
    var singlecategoryid = Int()
    var singlebankid = Int()
    var singlepaymentid = Int()
    var singletrasaction = String()
    var paymenttypeString    = [String]()
    var paymenttypeid     = [Int]()
    var categoryarray = [categoryoryexpense]()
    var trasactiontype = [String]()
    var paymenttype = [orignalpayement]()
    var bankarray = [fetchbank]()
    var model = expenseviewmodel()
    var menu : SideMenuNavigationController!
    var id = Int()
    let dateFormatter = DateFormatter()
    @IBAction func submit(_ sender: Any) {
        
        guard isvalid() else {
            return
        }
       checklogin()
    }
    func checklogin(){
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date.date)
        if formattedDate.isEmpty == true{
            Global.shared.showMsg(msg: "", title: "fill the entites")
        }
        model.editexpence(
            id: id, categoryId: singlecategoryid,
                          payment_type_id: singlepaymentid,
                          transaction_type: singletrasaction,
                          amount: amount.text!,
                          name: name.text!,
                          date: formattedDate,
                          check_number: checkno.text!,
                          description: desciptions.text!,
                          bank_id: singlebankid,
                          completion: { [self]result in
                switch result {
                case .success(let data ):
                    
                   print("success")
                    Global.shared.showMsg(msg: "", title: "success added")
                    
                case .failure(let error):
                    print("errror",error)
                }
            }
            
            )
    }
    func   isvalid() -> Bool{
    
      if
                      amount.text?.isEmpty == true
                        ||
                      checkno.text?.isEmpty == true
                        ||
                      desciptions.text?.isEmpty == true
                        ||
                      singlecategoryid == nil
                        ||
                      singlepaymentid == nil
                        ||
                      singletrasaction == nil
                        ||
                      singlebankid == nil
                        ||
                        name.text?.isEmpty == nil
                        {
                  Global.shared.showMsg(msg: "Empty Feilds", title: "Please fill all fields")
                  return false
              }
      return true
      
    }
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var menubutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         var formattedDate = dateFormatter.string(from: date.date)
         name.text = nameL
         amount.text = amountL
         formattedDate = dateL
         checkno.text = String( checknoL)
         desciptions.text = descriptionL
         setupui()
         fetchcategory()
         fetchbanks()
         fetchtrasaction()
         fetchpayment()
         
    }
    @objc func keyboarAppears(){
        print("kyboard apperas")
        height.constant = 1400
        height.isActive = true
        
        
    }
    @objc func keyboardDisappear(){
        print("kyboard disaperat")
        height.constant = 1000
        height.isActive = true
        
        
    }
    func   fetchcategory(){
    model.fetchcategory(completion: { [self]result in
            switch result {
            case .success(let data ):
                
                categoryarray = data.data
                for i in categoryarray{
                    categorystring.append(i.name)
                    categoryid.append(i.id)
                }
                    
                Global.shared.configuredDropDownwithid(dropDown: categoriesdropdown, array: categorystring, ids: categoryid ) { selectedText, id  in
                        
                    singlecategoryid = id
                        
                    }
                    
                
            case .failure(let error):
                print("errror",error)
            }
        }
        
        )
}
    func   fetchbanks(){
        model.fetchbanks(completion: { [self]result in
                switch result {
                case .success(let data ):
                   
                    bankarray = data.data
                    for i in bankarray{
                        bankstring.append(i.name)
                        bankid.append(i.id)
                    }
                    Global.shared.configuredDropDownwithid(dropDown: banckdropdown, array: bankstring, ids: bankid ) { selectedText, id  in
                        singlebankid = id
                        }
                case .failure(let error):
                    print("errror",error)
                }
            }
            
            )
      }
    func   fetchpayment(){
        model.fetchpayment(completion: { [self]result in
                switch result {
                case .success(let data ):
                    paymenttype = data.data.data
                    for i in paymenttype{
                        paymenttypeString.append(i.name)
                        paymenttypeid.append(i.id)
                    }
                    Global.shared.configuredDropDownwithid(dropDown: paymenttypedropdown, array: paymenttypeString, ids: paymenttypeid ) { selectedText, id  in
                            
                        singlepaymentid = id
                        }
                case .failure(let error):
                    print("errror",error)
                }
            }
            
            )
      }
    func   fetchtrasaction(){
        model.fetchtrasactiontype(completion: { [self]result in
                switch result {
                case .success(let data ):
                   
                    trasactiontype = data
                   
       
                    Global.shared.configuredDropDown(dropDown: trasactiondropdown, array: trasactiontype  ){ selectedtext in
                            
                            singletrasaction = selectedtext
                            
                        }
                        
                    
                case .failure(let error):
                    print("errror",error)
                }
            }
            
            )
      }
    
    @objc func dismissKeyboards(_ sender: UITapGestureRecognizer){ /*this is a void function*/
        let location = sender.location(in: self.view)
       
        name.resignFirstResponder()
        amount.resignFirstResponder()
        checkno.resignFirstResponder()
        desciptions.resignFirstResponder()
    }
    func setupui (){
     
        amount.keyboardType = .decimalPad
        checkno.keyboardType = .decimalPad
        let tapGestureRecognizers = UITapGestureRecognizer(target: self, action:#selector(self.dismissKeyboards))
        tapGestureRecognizers.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGestureRecognizers)
        menubutton.setTitle("", for: .normal)
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }}





