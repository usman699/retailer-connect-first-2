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
class ManageSuppliers: UIViewController  ,UIDocumentInteractionControllerDelegate, UISearchBarDelegate, UITextFieldDelegate{
  
    
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
    @IBAction func showCountryPicker(_ sender: UIButton) {
        showCountryPicker()
        
    }
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
           || thirdT.text?.isEmpty == true
          
           
           ||
           fourtht.text?.isEmpty == true
        ){
            let vc = LoginsViewController()
            
            vc.showMsg(msg: "", title: "please fill feilds")
        }
        
        else{
            
            customermodel.addingCustomer( Customer:firstT.text
                                          ,phoneNumber: Int(secondTextfeild.text!),
                                          address: thirdT.text!,
                                          Balence: Int(fourtht.text!)!
                                          , whenFinish: { [weak self] result in
               
    
                switch result {
    
                case .success(let user):
                    print("success for adding ")
              
                   
                    self!.firstT.text = ""
                    self!.secondTextfeild.text = ""
                    self!.thirdT.text = ""
                    self!.fourtht.text = ""
                    let vc = LoginsViewController()
                    
                    vc.showMsg(msg: "", title: "Added succesfully")
                    
                case .failure(let errors):
               let vc = LoginsViewController()
                    for i in  errors.data.name{
                        vc.showMsg(msg: "", title: i)
                    }
                }
    
            }
            )
        }

    }
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var pkcountry: UIButton!
    let dropdownData = ["25 ↓", "50 ↓", "100 ↓", "150 ↓","250 ↓" ,"500 ↓" , "All"]

//    @IBOutlet weak var uipickerView: UIPickerView!

   
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var fourtht: UITextField!
    @IBOutlet weak var thirdT: UITextField!
 
    @IBAction func phoneNumber(_ sender: Any) {
        showCountryPicker()
    }
  
    
    
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
            thirdT.resignFirstResponder()
            fourtht.resignFirstResponder()
            firstT.resignFirstResponder()
            secondTextfeild.resignFirstResponder() /*This will dismiss our keyboard on tap*/
        }
        thirdT.delegate  = self
        fourtht.delegate  = self
        firstT.delegate  = self
        secondTextfeild.delegate  = self
        secondTextfeild.keyboardType = .numberPad
        pkcountry.setTitle("", for: .normal)
        menuButton.setTitle("", for: .normal)
                                       
    
     
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
      
    
        countryFlag.image = UIImage(named: "images")
     
    
        UIElementsManager.shared.setViewSettingWithBgShade(view: secondView)
     
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    
    
    
    
    private func showCountryPicker() {
        // Present country picker with `Section Control` enabled
        CountryPickerWithSectionViewController.presentController(on: self, configuration: { countryController in
            countryController.configuration.flagStyle = .circular
     
            countryController.favoriteCountriesLocaleIdentifiers = ["IN", "US"]
            
        }) { [weak self] country in
//            self?.pkcountry.setTitle("\(country.digitCountrycode! ), \(country.countryName)", for: .normal)
            self?.secondTextfeild.text = "+\(country.digitCountrycode!)"
            self?.countryFlag.image = country.flag
            guard let self = self else { return }
     //       self.countryImageView.isHidden = false
    //        self.countryImageView.image = country.flag
     //       self.countryCodeButton.setTitle(country.dialingCode, for: .normal)
        }
    }
   }

extension ManageSuppliers: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dropdownData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dropdownData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Handle the selection
        let selectedOption = dropdownData[row]
        print("Selected option: \(selectedOption)")
    }
    
    // Set the text color based on the selected state
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = dropdownData[row]
        var textColor: UIColor = .gray
        
        // Check if the row is selected
        if row == pickerView.selectedRow(inComponent: component) {
            textColor = .black
        }
        
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: textColor])
        return attributedString
    }
}
