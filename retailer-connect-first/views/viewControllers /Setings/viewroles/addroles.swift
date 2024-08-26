

import UIKit
import iOSDropDown
import SideMenu

import SKCountryPicker
class AddRoles: UIViewController  ,UIDocumentInteractionControllerDelegate, UISearchBarDelegate, UITextFieldDelegate{
    @IBOutlet weak var viewcategories: UIButton!
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hieghtconstraints.constant = 600
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        hieghtconstraints.constant = 400
    }
    var  Id :Int!
    var menu:SideMenuNavigationController!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var hieghtconstraints: NSLayoutConstraint!
    @IBAction func viewsupplier(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "viewroles")
        present(initialViewController, animated: true)
    }
    @IBAction func submit(_ sender: Any) {

        if(firstT.text?.isEmpty == true
           ||
           secondTextfeild.text?.isEmpty == true
        ){
            let vc = LoginsViewController()
            
            vc.showMsg(msg: "", title: "please fill feilds")
        }
        
        else{
            Global.shared.loading(view: self.view)
            settingsmodel.addroles(
                name: firstT.text!,
                description:secondTextfeild.text!,
                completion: { result in
                switch result {
                case .success(let user):
                    print("success for adding ")
                    self.firstT.text = ""
                    self.secondTextfeild.text = ""
                    let vc = LoginsViewController()
                    vc.showMsg(msg: "", title: "Added succesfully")
                    Global.shared.stop()
                case .failure(let errors):
                   print("error ")
                    Global.shared.showMsg(msg: "", title: errors.localizedDescription)
                    Global.shared.stop()
                }
            })}
        }
    @IBAction func menuButton(_ sender: Any) {
        
        present(menu!, animated: true)
    }
    @IBOutlet weak var secondTextfeild: UITextField!
    @IBOutlet weak var firstT: UITextField!
    var settingsmodel =  settingsviewmodel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
        func dismissKeyboard(){ /*this is a void function*/
           
            firstT.resignFirstResponder()
            secondTextfeild.resignFirstResponder() /*This will dismiss our keyboard on tap*/
        }
        firstT.delegate  = self
        secondTextfeild.delegate  = self
    
        menuButton.setTitle("", for: .normal)
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
   }


