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
class Addcompany: UIViewController  ,UIDocumentInteractionControllerDelegate, UISearchBarDelegate, UITextFieldDelegate{
  
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
 //       hieghtconstraints.constant = 900
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
   //     hieghtconstraints.constant = 700
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
    @IBOutlet weak var adress: CustomTextField!
    @IBAction func address(_ sender: Any) {
    }
   
    @IBOutlet weak var phonenumber: CustomTextField!
    
    @IBOutlet weak var descriptions: CustomTextField!
  
    @IBOutlet weak var hieghtconstraints: NSLayoutConstraint!
    @IBAction func viewsupplier(_ sender: Any) {
        let storyboard = UIStoryboard(name: "manageCompanies", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "viewcompanies")
        present(initialViewController, animated: true)
    }
    @IBAction func submit(_ sender: Any) {
        
        
        if(name.text?.isEmpty == true
           ||
           phonenumber.text?.isEmpty == true
           || adress.text?.isEmpty == true
          
           
           ||
           descriptions.text?.isEmpty == true
        ){
            let vc = LoginsViewController()
            
            vc.showMsg(msg: "", title: "please fill feilds")
        }
        
        else{
            Global.shared.loading(view: self.view)
            customermodel.addcompnaies( name:name.text!
                                        ,phone: String(phonenumber.text!),
                                        address: adress.text!,
                                        description:descriptions.text!
                                        , completion: { [weak self] result in
               
            
                switch result {

                case .success(let user):
                    print("success for adding ")

                    Global.shared.stop()
                    self!.name.text = ""
                    self!.phonenumber.text = ""
                    self!.adress.text = ""
                    self!.descriptions.text = ""
                    let vc = LoginsViewController()
                    
                    vc.showMsg(msg: "", title: "Added succesfully")
                    
                case .failure(let errors):
                
                    switch (errors){
                        
                    case .decodingError:
                        print("erorr ")
                    case .notFound:
                        print("erorr ")
                    case .conflict:
                        print("erorr ")
                    case .unknownError:
                        Global.shared.showMsg(msg: "", title: "please remove spaces")
                        Global.shared.stop()
                    case .unresponseEntity:
                        print("erorr ")
                    case .outofstack:
                        print("erorr ")
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
  
   
 
    @IBAction func phoneNumber(_ sender: Any) {
        showCountryPicker()
    }
  
    
    
    @IBAction func menuButton(_ sender: Any) {
        
        present(menu!, animated: true)
    }
  
    @IBOutlet weak var name: UITextField!
   

    var customermodel =  peoplesviewmodel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
        func dismissKeyboard(){ /*this is a void function*/
            adress.resignFirstResponder()
            descriptions.resignFirstResponder()
            name.resignFirstResponder()
            phonenumber.resignFirstResponder() /*This will dismiss our keyboard on tap*/
        }
        adress.delegate  = self
        descriptions.delegate  = self
        name.delegate  = self
        phonenumber.delegate  = self
        phonenumber.keyboardType = .numberPad
        pkcountry.setTitle("", for: .normal)
        menuButton.setTitle("", for: .normal)
        phonenumber.text = "+92"
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        countryFlag.image = UIImage(named: "Flag_of_Pakistan")
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
            self?.phonenumber.text = "+\(country.digitCountrycode!)"
            self?.countryFlag.image = country.flag
            
            guard let self = self else { return }
     //       self.countryImageView.isHidden = false
    //        self.countryImageView.image = country.flag
     //       self.countryCodeButton.setTitle(country.dialingCode, for: .normal)
        }
    }
   }

extension Addcompany: UIPickerViewDelegate, UIPickerViewDataSource {
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
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if textField == phonenumber{
            if ( range.location >= 12){
                Global.shared.showMsg(msg: "", title: "phone number is not valid")
            }
        }
        return range.location < 90
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

