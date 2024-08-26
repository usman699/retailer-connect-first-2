import UIKit
import iOSDropDown
import SideMenu
import Kingfisher
import SKCountryPicker
class addEmplyeeViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var startdesignation: DropDown!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print("did finish after picking up")
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            
            
            print(image.size)
            images.image = image
            
            
        }
        
        if let imageUrl = info[.imageURL] as? URL {
            imageUrls =  imageUrl.lastPathComponent
            print(imageUrls)
            // Do something with the URL, such as saving it or using it as needed.
        }
    }
        @IBOutlet weak var imagebutton: UIButton!
    @IBAction func imagebutton(_ sender: Any) {
        showCountryPicker()
    }
    var designation_id:Int!
    var array2:[String] = []
    var optionalids =  [Int]()
    var   desinationarray: [(String, Int)] = []
    @IBOutlet weak var countryFlag: UIImageView!
    var viewModelUser = addemployeeviewmodel()
    var menu: SideMenuNavigationController!
    @IBAction func menubutton(_ sender: Any) {
        present(menu!, animated: true)
    }
    var countryimage:UIImageView!
    var imageUrls:String!
    @IBOutlet weak var selectGender: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var calender: UIDatePicker!
    @IBOutlet weak var phone: UITextField!
    @IBAction func viewemployee(_ sender: Any) {
        print("click")
        
            let storyboard = UIStoryboard(name:"EmployeeProfile", bundle: nil)
            guard let initialViewController = storyboard.instantiateViewController(withIdentifier: "employee") as? Employee else {
                return
            }
            
            let navigationController = UINavigationController(rootViewController: initialViewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: false, completion: nil)

    }
    var nameL:String!
    var dateL:String!
    var phoneL:String!
    var emailL:String!
    var imageL:String!
    var genderL:String!
    var joiningDateL:String!
    var designationL:String!
    var salarayL:String!
    var imageName:String!
    var idcardL:String!
    var addressL:String!
    var countrycodeL: Int!
    @IBOutlet weak var views: UIView!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var card: UITextField!
    @IBOutlet weak var enterEmail: UITextField!
    var arraydropdownmodelarray:[dropdownmodel] = []
    @IBOutlet weak var entername: UITextField!
    
    @IBAction func SubmitButton(_ sender: Any) {
        Submit()
    }
    @IBOutlet weak var seleclableStartDesignation: UILabel!
    var isItemSelected = false
    let dateFormatter = DateFormatter()
    var imagePicker = UIImagePickerController()
  //  @IBOutlet weak var bottomConstaint: NSLayoutConstraint!
    var gender :String!
    @IBOutlet weak var menubutton: UIButton!
    @IBOutlet weak var salarys: UITextField!
    @IBOutlet weak var images: UIImageView!
    
    
    @IBOutlet weak var dropdown: DropDown!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      updateemployee( )
        imagebutton.setTitle("", for: .normal)
        print("calender",calender.description)
     
        countryFlag.image = UIImage(named: "images")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        countryFlag.addGestureRecognizer(tapGestureRecognizer)
        
        
       
      
        
        navigationController?.navigationBar.isHidden = true
        
        scrollview.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarAppears), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        updateUi()
        setupgesture()
        Global.shared.configuredDropDown(dropDown: dropdown, array:["male", "female"] , didSelect: { selectedtext in
            
            self.gender = selectedtext
            self.isItemSelected = true
            self.startdesignation.isSelected = true
            self.selectGender.isHidden = true
            
        })
      
        
        // Do any additional setup after loading the view.
    }
    func fetchingcustomer(){
        viewModelUser.fetchdesignation(completion: { [self]response in
            switch response {
            case .success(let data ):
                for datas   in data.data! {
                    arraydropdownmodelarray.append(dropdownmodel(name: datas.name!, id: datas.id!))
                    array2.append(datas.name!)
                    optionalids.append(datas.id!)
                    //                    desinationarray.append((datas.name , datas.id))
                    //                    array2.append(datas.name)
               
                }
                
                if !array2.isEmpty {
                    print("empty array")
                    startdesignation.optionArray = array2
                } else {
                    print("not empty")
                    // Handle the case where array2 is empty, for example, you could assign a default array
                    startdesignation.optionArray = ["No Options Available"]
                }
                if !optionalids.isEmpty {
                    print("empty array ")
                    startdesignation.optionIds = optionalids
                } else {
                    print("non empty ")
                    // Handle the case where optionalids is nil, for example, you could assign an empty array
                    startdesignation.optionIds = []
                }
                    if let firstItem = startdesignation.optionArray.first {
                    startdesignation.text = firstItem
                    }
                startdesignation.isSearchEnable = false
                startdesignation.arrowColor = .black
                startdesignation.itemsColor = .black
                startdesignation.borderColor = .black
                startdesignation.tintColor = .black
                startdesignation.arrowSize = 10
                    
                startdesignation.selectedRowColor = .gray
                    
                    // Set the selectedRow to 0 to display the first item initially
                    
                    
                    // Manually set the text to the first item
                    //  dropDown.text = dropDown.optionArray.first
                startdesignation.textColor = .black
                    // The list of array to display. Can be changed dynamically
                
            
                // Check if array2 is not empty before assigning it to optionArray
             
                    // Image Array its optional
                    //   dropDown.optionImageArray = ["email","email","email"]
                startdesignation.backgroundColor = .white
                    
                    // The the Closure returns Selected Index and String
                startdesignation.didSelect{ [self](selectedText , index ,id) in
                   
                      
                        
                            self.seleclableStartDesignation.isHidden = true
                            
                      
                                if arraydropdownmodelarray.indices.contains(index){
                                    designation_id = arraydropdownmodelarray.first?.id
                        
                            
                        }
                        //
                        
                        
                        
                    }
                    
                
                    // Do any additional setup after loading the view.
                    
                    // Do any additional setup after loading the view.
                
        
                
                
//                Global.shared.configurewithids(dropDown: startdesignation, array: array2, ids: optionalids, didSelect: {selectedtext , id,index  in
//                    self.seleclableStartDesignation.isHidden = true
//                    })
                
            case .failure(let errors ):
                print(errors)
            }
            
        })
    }
    func  updateemployee(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        if genderL == nil 
            && joiningDateL == nil
            && nameL == nil
            && imageL == nil
            && salarayL == nil
            && phoneL == nil
            && emailL == nil
            && idcardL == nil
            && addressL == nil 
            && imageName == nil
        {
            
        }
        else{
            let date = dateFormatter.date(from: joiningDateL)
            print("gender",gender)
            dropdown.text = genderL
            calender.date = date!
            print("update",nameL, salarayL,phoneL, idcardL, addressL)
            entername.text = nameL
            
            let url = URL(string: imageL)
            images.kf.setImage(with: url)
            imageUrls = imageL
            salarys.text = salarayL
            phone.text = phoneL
            enterEmail.text = emailL
            card.text = idcardL
            address.text = addressL
        }
    }
    @objc func handleLongPress(tapGestureRecognizer: UITapGestureRecognizer)
    
    
    {
        print("asfd")
        
    }
    @IBOutlet weak var constrainbottomview: NSLayoutConstraint!
    
    
    @IBOutlet weak var addemployeeview: UIView!
    var isExpanded:Bool = false
    @objc func keyboarAppears(){
        print("kyboard apperas")
        height.constant = 1700
        height.isActive = true
        
        
    }
    @objc func keyboardDisappear(){
        print("kyboard disaperat")
        height.constant = 1360
        height.isActive = true
        
        
    }
    func  setupgesture(){
        
        
        let tapGestureRecognizers = UITapGestureRecognizer(target: self, action:#selector(self.dismissKeyboards))
        tapGestureRecognizers.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGestureRecognizers)
        
        
    }
    @objc func imageViewTapped(_ sender:AnyObject){

   showCountryPicker()

    }
    @objc func dismissKeyboards(_ sender: UITapGestureRecognizer){ /*this is a void function*/
        let location = sender.location(in: self.view)
        
        if !startdesignation.frame.contains(location) {
            phone.resignFirstResponder()
            entername.resignFirstResponder()
            enterEmail.resignFirstResponder()
            card.resignFirstResponder()
            salarys.resignFirstResponder()
            address.resignFirstResponder()
        }
        if !dropdown.frame.contains(location) {
            phone.resignFirstResponder()
            entername.resignFirstResponder()
            enterEmail.resignFirstResponder()
            card.resignFirstResponder()
            salarys.resignFirstResponder()
            address.resignFirstResponder()
        }
    }
    
    
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBOutlet weak var height: NSLayoutConstraint!
    func  updateUi(){
        
        
        enterEmail.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped))
        stackView.addGestureRecognizer(tapGesture)
        
        
        calender.backgroundColor = .clear
        calender.datePickerMode = .date
        phone.keyboardType = .numberPad
        salarys.keyboardType = .numberPad
        
        card.keyboardType = .numberPad
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menubutton.setTitle("", for: .normal)
        images.layer.cornerRadius = images.frame.size.width / 2
        images.clipsToBounds = true
    }
    func getImage() -> (UIImage?, String?) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
        
        
        
        
        
        var retrievedImage: UIImage? = nil
        var imagePath: String? = nil
        
        // Get image
        do {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let imagePathURL = URL(fileURLWithPath: "\(documentsPath)/myImage")
            
            let readData = try Data(contentsOf: imagePathURL)
            retrievedImage = UIImage(data: readData)
            
            // Set the image to some UIImageView (assuming you have 'image' defined somewhere)
            // image.image = retrievedImage
            
            imagePath = imagePathURL.path
            
            return (retrievedImage, imagePath)
        } catch {
            print("Error while opening image: \(error.localizedDescription)")
            return (nil, nil)
        }
    }
    func Submit(){
        
        
        
        
        guard isValid() else {
            return
        }
        
        
        
        guard isChecking() else {
            return
        }
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let formattedDate = dateFormatter.string(from: calender.date)
        Global.shared.loading(view: self.view)
        viewModelUser.addemployee(
            image: images.image!,
            imageName: imageUrls.isEmpty ? imageL :  imageUrls ,
            name: entername.text!,
            designation_id:String(designation_id!),
          
            gender: gender!,
            phone: phone.text! ,
            email:  enterEmail.text!,
            id_card: card.text!,
            joining_date: String( formattedDate),
            address: address.text!,
            salary: salarys.text!) { [weak self] result in
                print("this is result", result)
                
                switch result {
                    
                case .success(let user):
                    print(user.success)
                    Global.shared.stop()
                    Global.shared.showMsg(msg: "", title: "Successfully inserted")
                case .failure(let error):
                    Global.shared.stop()
                    Global.shared.showMsg(msg: "Try Again", title: "something Wrong try again")
                    
                    print("eror posting :", error.localizedDescription)
                }
            }
        
    }
    func isChecking() -> Bool{
        if let text = enterEmail.text, !text.contains("@gmail.com"){
            Global.shared.showMsg(msg: "", title: "Please enter valid Email")
            return false
        }
        
        return true
        
    }
    func isValid() -> Bool{
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let formattedDate = dateFormatter.string(from: calender.date)
        if imageUrls.isEmpty == true {
            Global.shared.showMsg(msg: " ", title: "please pick a image")
        }
        if  salarys.text?.isEmpty == true ||
                
                phone.text?.isEmpty == true  || entername.text?.isEmpty == true  || enterEmail.text?.isEmpty == true  || card.text?.isEmpty == true || designation_id == nil ||
                images.image == nil ||
                formattedDate.isEmpty == true || images.image == nil || calender.date == nil  || imageUrls.isEmpty == true   {
            print(phone.text, entername.text, enterEmail.text, card.text, designation_id )
            /*|| imageUrls.isEmpty == true*/
            
            Global.shared.showMsg(msg: "Empty Feilds", title: "Please fill all fields")
         
            return false
        }
        
        return true
        
    }
    func presents(storybd:String, identifire:String ){
        
        let storyboard = UIStoryboard(name: storybd, bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifire)
        self.navigationController?.present(initialViewController, animated: false)
    }
    @objc func stackViewTapped() {
        
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self // new
        present(imagePickerVC, animated: true)
        
        
    }
    
    
    public func  configuredDropDown(dropDown:DropDown , array:Array<String>){
        for  arr in array {
            print("array",arr)
        }
        
        if let firstItem = dropDown.optionArray.first {
            dropDown.text = firstItem
        }
        dropDown.isSearchEnable = false
        dropDown.arrowColor = .black
        dropDown.itemsColor = .black
        dropDown.borderColor = .black
        dropDown.tintColor = .black
        dropDown.arrowSize = 10
        
        dropDown.selectedRowColor = .gray
        
        // Set the selectedRow to 0 to display the first item initially
        
        
        // Manually set the text to the first item
        //  dropDown.text = dropDown.optionArray.first
        dropDown.textColor = .black
        // The list of array to display. Can be changed dynamically
        dropDown.optionArray = array
        //Its Id Values and its optional
        dropDown.optionIds = optionalids
        
        // Image Array its optional
        //   dropDown.optionImageArray = ["email","email","email"]
        dropDown.backgroundColor = .white
        
        // The the Closure returns Selected Index and String
        dropDown.didSelect{ [self](selectedText , index ,id) in
       
            if dropDown == self.startdesignation{
            
                self.seleclableStartDesignation.isHidden = true
                isItemSelected = true
          
                    if arraydropdownmodelarray.indices.contains(index){
                        designation_id = arraydropdownmodelarray.first?.id
                
                    
            
                    
                }
            }else  if dropDown == self.dropdown{
              
             
                gender = selectedText
                isItemSelected = true
                startdesignation.isSelected = true
                self.selectGender.isHidden = true
            }
            //
            
            
            
        }
        
    
        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBOutlet weak var viewemployee: UIView!
    
  
    private func showCountryPicker() {
        // Present country picker with `Section Control` enabled
        CountryPickerWithSectionViewController.presentController(on: self, configuration: { countryController in
            countryController.configuration.flagStyle = .circular
            
            countryController.favoriteCountriesLocaleIdentifiers = ["IN", "US"]
            
        }) { [weak self] country in
   //         self!.countrycode = Int( country.countryCode)
    //        self?.pkcountry.setTitle("\(country.digitCountrycode!), \(country.countryName)", for: .normal)
          
//                self?.countryimage.image = country.flag
            self!.countryFlag.image = country.flag
            self!.phone.text = country.dialingCode
            guard let self = self else { return }
            
        }
    }
    @IBOutlet weak var scrollview: UIScrollView!
}


extension addEmplyeeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == address || textField == card {
            keyboarAppears()
        }
      
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == address || textField == card {
            keyboardDisappear()
        }
        if textField == enterEmail {
            if let text = enterEmail.text, !text.contains("@gmail.com") {
                enterEmail.layer.borderColor = UIColor.orange.cgColor
            }
            else{
                enterEmail.layer.borderColor = UIColor.red.cgColor
                
            }
        }
        
        // setRoundedCorner(for: textField, cornerRadius: textField.frame.size.height / 2)
    }
    
    
}

 struct dropdownmodel{
    var name :String
     var id :Int
}
