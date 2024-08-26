//
//  manageCustomers.swift
//  retailer-connect-first
//
//  Created by Spark on 26/12/2023.
//

import UIKit
import iOSDropDown
import SideMenu

import SKCountryPicker
class addesignation: UIViewController  ,UIDocumentInteractionControllerDelegate, UISearchBarDelegate, UITextFieldDelegate{
  
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hieghtconstraints.constant = 900
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        hieghtconstraints.constant = 700
    }
   
    var  Id :Int!
    var filterData:[fetchCustumer] = []
    var singleElement = [fetchCustumer]()
    var  fetchCustumerArray = [fetchCustumer]()

    var menu:SideMenuNavigationController!
    @IBOutlet weak var menuButton: UIButton!
  
    @IBOutlet weak var hieghtconstraints: NSLayoutConstraint!
    @IBAction func viewsupplier(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ManageDestination", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "viewsupplier")
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
            
            
        }}
  

   

    
 
    
    
    
    @IBAction func menuButton(_ sender: Any) {
        
        present(menu!, animated: true)
    }
    @IBOutlet weak var secondTextfeild: UITextField!
    @IBOutlet weak var firstT: UITextField!
    @IBOutlet weak var firstView: UIView!

    var customermodel =  suppliersViewmodel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
        func dismissKeyboard(){ /*this is a void function*/
   
            firstT.resignFirstResponder()
            secondTextfeild.resignFirstResponder() /*This will dismiss our keyboard on tap*/
        }
 
        firstT.delegate  = self
        secondTextfeild.delegate  = self
        secondTextfeild.keyboardType = .numberPad

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


