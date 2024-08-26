//
//  addProductViewController.swift
//  retailer-connect-first
//
//  Created by Spark on 19/12/2023.
//

import UIKit
import iOSDropDown
import SideMenu
class addProductViewController: UIViewController, UIDocumentPickerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private var stackView: UIStackView!
    var buttonseven: [UIButton] = []
    var imagePicker = UIImagePickerController()
    var menu : SideMenuNavigationController!
    var textfeilds:[UITextField] = []
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var enterPrice: UITextField!
    
    @IBOutlet weak var texUp: UIButton!
    @IBAction func taxdown(_ sender: Any) {
      decreasePercentage()
    }
    @IBAction func taxUp(_ sender: Any) {
        increasepercantage()
    }
    @IBOutlet weak var taxdown: UIButton!
    @IBOutlet weak var taxUp: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var purchasePrice: UITextField!
    @IBAction func downArraw(_ sender: Any) {
        decreaseNumber()
 
    }
    @IBOutlet weak var choosefile: UIButton!
  
    
    @IBAction func upArrow(_ sender: Any) {

        increaseNumber()
    }
    @IBAction func purhcaseUp(_ sender: Any) {
       increasepurchase()
    }
    @IBAction func purchasedown(_ sender: Any) {
       decreasepurchase()
    }
    @IBAction func salesUp(_ sender: Any) {
        increasesales()
    }
    @IBAction func salesDown(_ sender: Any) {
       decreasesales()
    }
    @IBAction func quantityUp(_ sender: Any) {
        increasequantity()
    }

    @IBAction func quanrityDown(_ sender: Any) {
        decreasequantity()
    }
    
    @IBOutlet weak var down: UIButton!
    @IBOutlet weak var up: UIButton!
    @IBOutlet weak var numberTextfeild: UITextField!
    @IBOutlet weak var firstTextfeild: UITextField!
    @IBOutlet weak var dropDown: DropDown!
    @IBOutlet weak var dropDown2: DropDown!
    @IBOutlet weak var addView: UIView!
    @IBAction func MenuButton(_ sender: Any) {
        present(menu!, animated: true)
    }
    @IBAction func calender(_ sender: Any) {
    }
    @IBAction func chooseFileButton(_ sender: Any) {
        chooseFileButtonTapped()
    }
    let dateFormatter = DateFormatter()

    @IBOutlet weak var calender: UIDatePicker!
    var idArray = [Int]()
    var stringArray = [String]()
    func isValid() -> Bool{
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let formattedDate = dateFormatter.string(from: calender.date)
      
        if  
                codeTextFeild.text?.isEmpty == true
                ||
                quantity.text?.isEmpty == true 
                ||
                firstTextfeild.text?.isEmpty == true
                ||
                singlecategoryid == nil  
                ||
                suppliersId == nil
                ||
                formattedDate.isEmpty == true 
                ||
                codeTextFeild.text?.isEmpty == true
                ||
                purchasePrice.text?.isEmpty == true
                ||
                perchantge.text?.isEmpty == true 
                ||
                enterPrice.text?.isEmpty == true
                
                  {
     
            /*|| imageUrls.isEmpty == true*/
            
            Global.shared.showMsg(msg: "Empty Feilds", title: "Please fill all fields")
         
            return false
        }
        
        return true
        
    }
    var salesArray = [purchasedata]()
    @IBAction func submit(_ sender: Any) {
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        guard isValid() else {
            return
        }
        
        let startdate = dateFormatter.string(from: calender.date)
        productmodel.addproducts(name: firstTextfeild.text!,
                                 Image: images.image!,
                                 
                                 supplier_id: String(suppliersId),
                                 category_id:String( singlecategoryid),
                                 code: codeTextFeild.text!,
                                 product_price:purchasePrice.text!,
                                 sale_price: enterPrice.text!,
                                 quantity: quantity.text!,
                                 taxpercentage: perchantge.text!,
                                 Expire_date: startdate,
                                 imageString:  selecteUrl,
                                 completion: {result in
            switch result {
            case .success(let success):
                print("success", success.success)
                print("success", success.message)
            case .failure(let error ):
                switch error {
                    
                case .decodingError:
                    print("decoding")
                case .notFound:
                    print("notfound")
                case .conflict:
                    print("conflick")
                case .unknownError:
                    print("Unkown ")
                case .unresponseEntity:
            print("unresseenetu")
                case .outofstack:
                    print("out of stack")
                }
      
            }
        })
    }
    var images = UIImageView()
    var selecteUrl  = String()
    var singlecategoryid = Int()
    var categorystring = [String]()
    var idcategory = [Int]()
    var categoryarray = [designationdata]()
    var suppliersName:String!
    var suppliersId:Int!
    var reportviewmodels = reportviewmodel()
    var productmodel = productviewmodel()
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var codeTextFeild: UITextField!
    @IBOutlet weak var menuButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        perchantge.delegate = self
        purchasePrice.delegate = self
        enterPrice.delegate = self
        quantity.delegate = self
        firstTextfeild.delegate = self
        codeTextFeild.delegate = self
        numberTextfeild.delegate = self
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        // Set the tint color for the submit button using UIColor(named:)
                if let hrxColor = UIColor(named: "F18318") {
                    submit.tintColor = hrxColor
                } else {
                    // Fallback color (e.g., orange) if the named color is not found
                    submit.tintColor = UIColor.orange
                }
        buttonseven = [ up,three ,  five,  seven, menuButton, down, three ,  six, four,   eight, taxdown, taxUp]

               // Now you can loop over the array and perform operations on each button
               for button in buttonseven {
                
                   button.tintColor = .black
                   // Do something with the button
                   button.setTitle(" ", for: .normal)
               }
        UIElementsManager.shared.resetStyleAfterEditing(firstTextfeild)
        UIElementsManager.shared.resetStyleAfterEditing(enterPrice)
        UIElementsManager.shared.resetStyleAfterEditing(purchasePrice)
        UIElementsManager.shared.resetStyleAfterEditing(quantity)
        UIElementsManager.shared.resetStyleAfterEditing(perchantge)
        UIElementsManager.shared.resetStyleAfterEditing(dropDown)
        UIElementsManager.shared.resetStyleAfterEditing(dropDown2)
        UIElementsManager.shared.resetStyleAfterEditing(numberTextfeild)
        choosefile.tintColor = .white
        fetchcategory()
        fetchsuppliers()
    }
    func fetchcategory(){
        reportviewmodels.fetchproduct(completion: { [self]result in
            switch result {
            case .success(let data ):
                for dat in data.data!{
                    DispatchQueue.main.async {

                        self.categoryarray.append(dat)
                        self.categorystring.append(dat.name!)
                        self.idcategory.append(dat.id)
                        Global.shared.configuredDropDownwithid(dropDown: dropDown2, array: categorystring, ids: idcategory ) { selectedText, id  in
                            
                        //    self.productname = selectedText
                            self.singlecategoryid  = id
                            self.selectCatLable.isHidden = true
                            // Handle the selected text from the 'paid' dropdown
                            
                        }
                    }
                }
            case .failure(let error):
                print("errror",error)
            }
        }
        )
    }
    var suppliers = purchaseviewmodel()
    func fetchsuppliers(){
        suppliers.fetchsuppliers(completion: { [self]result in
                    switch result {
                    case .success(let data ):
                        for dat in data.data{
                            DispatchQueue.main.async {
                                // Code that needs to run on the main thread
                                // Update UI elements, perform animations, etc.
                                
                                self.salesArray.append(dat)
                                self.stringArray.append(dat.name)
                                self.idArray.append(dat.id)
                                Global.shared.configuredDropDownwithid(dropDown: dropDown, array: stringArray, ids: idArray ) { selectedText, id  in
                                    
                                    self.suppliersName = selectedText
                                    self.suppliersId = id
                                    self.selectSupplierLable.isHidden = true
                                    // Handle the selected text from the 'paid' dropdown
                                    
                                }
                            }
                        }
                    case .failure(let error):
                        print("errror",error)
                    }
                }
                )
            
    }
    
    @IBAction func viewproducts(_ sender: Any) {
        let storyboard = UIStoryboard(name: "viewProduct", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "viewproduct")
        present(initialViewController, animated: false)
    }
    @IBOutlet weak var selectCatLable: UILabel!
    @IBOutlet weak var selectSupplierLable: UILabel!
   
    @objc func chooseFileButtonTapped() {
         // Create a document picker view controller
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self // new
        present(imagePickerVC, animated: true)
        
     }
   

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print("did finish after picking up")
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            
            
            print(image.size)
            images.image = image
            
            
        }
        
        if let imageUrl = info[.imageURL] as? URL {
            selecteUrl =  imageUrl.lastPathComponent
        
            // Do something with the URL, such as saving it or using it as needed.
        }
    }
   
    @IBOutlet weak var perchantge: UITextField!
    @objc func increasepercantage() {
        if perchantge.text == " "{
            if let currentText = perchantge.text, var number = Int(currentText) {
                number += 1
             perchantge.text = "\(number)"
            }
        }
        if let currentText = perchantge.text, var number = Int(currentText) {
            number += 1
         perchantge.text = "\(number)"
        }
    }
    
    @objc func decreasePercentage() {
        if perchantge.text == " "{
            if let currentText = perchantge.text, var number = Int(currentText), number > 0 {
                number -= 1
             perchantge.text = "\(number)"
            }
        }
        if let currentText = perchantge.text, var number = Int(currentText), number > 0 {
            number -= 1
         perchantge.text = "\(number)"
        }
    }
    
    
    
    @objc func increasequantity() {
        if quantity.text == " "{
            if let currentText = quantity.text, var number = Int(currentText) {
                number += 1
                quantity.text = "\(number)"
            }
        }
        if let currentText = quantity.text, var number = Int(currentText) {
            number += 1
            quantity.text = "\(number)"
        }
    }
    
    @objc func decreasequantity() {
        if quantity.text == " "{
            if let currentText = quantity.text, var number = Int(currentText), number > 0 {
                number -= 1
                quantity.text = "\(number)"
            }
        }
        if let currentText = quantity.text, var number = Int(currentText), number > 0 {
            number -= 1
            quantity.text = "\(number)"
        }
    }
    
    @objc func increasesales() {
        if enterPrice.text == " "{
            if let currentText = enterPrice.text, var number = Int(currentText) {
                number += 1
                enterPrice.text = "\(number)"
            }
        }
        if let currentText = enterPrice.text, var number = Int(currentText) {
            number += 1
            enterPrice.text = "\(number)"
        }
    }
    
    @objc func decreasesales() {
        if enterPrice.text == " "{
            if let currentText = enterPrice.text, var number = Int(currentText), number > 0 {
                number -= 1
                enterPrice.text = "\(number)"
            }
        }
        if let currentText = enterPrice.text, var number = Int(currentText), number > 0 {
            number -= 1
            enterPrice.text = "\(number)"
        }
    }
    
    
       @objc func increasepurchase() {
           if purchasePrice.text == " "{
               if let currentText = purchasePrice.text, var number = Int(currentText) {
                   number += 1
                   purchasePrice.text = "\(number)"
               }
           }
           if let currentText = purchasePrice.text, var number = Int(currentText) {
               number += 1
               purchasePrice.text = "\(number)"
           }
       }
       
       @objc func decreasepurchase() {
           if purchasePrice.text == " "{
               if let currentText = purchasePrice.text, var number = Int(currentText), number > 0 {
                   number -= 1
                   purchasePrice.text = "\(number)"
               }
           }
           if let currentText = purchasePrice.text, var number = Int(currentText), number > 0 {
               number -= 1
               purchasePrice.text = "\(number)"
           }
       }
    
 
    @objc func increaseNumber() {
        if numberTextfeild.text == " "{
            if let currentText = numberTextfeild.text, var number = Int(currentText) {
                number += 1
                numberTextfeild.text = "\(number)"
            }
        }
        if let currentText = numberTextfeild.text, var number = Int(currentText) {
            number += 1
            numberTextfeild.text = "\(number)"
        }
    }
    
    @objc func decreaseNumber() {
        if numberTextfeild.text == " "{
            if let currentText = numberTextfeild.text, var number = Int(currentText), number > 0 {
                number -= 1
                numberTextfeild.text = "\(number)"
            }
        }
        if let currentText = numberTextfeild.text, var number = Int(currentText), number > 0 {
            number -= 1
            numberTextfeild.text = "\(number)"
        }
    }

}

extension addProductViewController: UITextFieldDelegate {
    // UITextFieldDelegate method called when the text field becomes the first responder
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIElementsManager.shared.applyStyleForEditing(textField)
       // setRoundedCorner(for: textField, cornerRadius: textField.frame.size.height / 2)
    }

    // UITextFieldDelegate method called when the text field resigns its first responder status
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Reset the border color, shadow, and corner radius when the editing ends
        UIElementsManager.shared.resetStyleAfterEditing(textField)
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

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == firstTextfeild {
            // Allow alphanumeric input for other text fields
            let allowedCharacterSet = CharacterSet.alphanumerics
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: characterSet)
        } else {
            // Allow only numeric input for †extfeild
            let allowedCharacterSet = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: characterSet)
        }
    }
    
}

