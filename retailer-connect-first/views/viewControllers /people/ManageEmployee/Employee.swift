import UIKit
import SideMenu
import Kingfisher

class Employee: UIViewController , YourTableViewCellDelegate, switchdelegate{
    func switchbutton(id : Int , action: Bool) {
        print("in siwitch button ")
        if action == true {
            fetechedEmployee.changestatusemployee(id: id, action: "active", completion: { [weak self] result in
                   switch result {
                   case .success(let user):
                  
                    print("")
                 
                      
                   
                
                   case .failure(let networkError):
                       // Handle different types of errors
                      print("")
                     
                   }
               })
        }
        else {
          
            fetechedEmployee.changestatusemployee(id: id, action: "inactive", completion: { [weak self] result in
                   switch result {
                   case .success(let user):
                  
                    
                 print("")
                     

                
                   case .failure(let networkError):
                       // Handle different types of errors
                      print("")
                     
                   }
               })
        }
    }
    
    @IBAction func menubutton(_ sender: Any) {
        print("cliekc")
        present(menu!, animated: true)
    }
    func updateIdCell(id: String) {
        
for ar in array {
if String( ar.id) == id {

   
    let storyboard = UIStoryboard(name:   "AddEmployee", bundle: nil)
    let initialViewController = storyboard.instantiateViewController(withIdentifier:"UpdateEmployee") as? updateemployee
  
    initialViewController?.nameL = ar.name
    initialViewController?.phoneL = ar.phone
    initialViewController?.addressL = ar.address
    initialViewController?.idcardL = ar.idCard
    initialViewController?.emailL = ar.email
    initialViewController?.joiningDateL = ar.joiningDate
    initialViewController?.designationL = ar.designation
    initialViewController?.salarayL = String(ar.salary)
    initialViewController?.imageL = ar.image
    initialViewController?.dateL = ar.joiningDate
    initialViewController?.id = ar.id
    present(initialViewController!, animated: false, completion: nil)
    


}

}
    }
    @IBOutlet weak var menubutton: UIImageView!
    
  
    
    func didDeleteCell() {
        
       
            fetechedEmployee.employeFetching(whenFinish: { [weak self] result in
                   switch result {
                   case .success(let user):
                       print("idk success ")
                       self!.array = []
                       print(self!.array.count)
                       for ar in user.data {
                           
                           self?.array.append(ar)
                       }
                       DispatchQueue.main.async {
                           self?.colView.reloadData()
                       }

                
                   case .failure(let networkError):
                       // Handle different types of errors
                       switch networkError {
                       case .unexpected:
                           print("Unexpected error occurred")

                       case .apiError(let statusCode):
                           print("API error occurred with status code: \(statusCode)")

                       case .noRecordFound(let message):
                           self!.array.removeAll()
                           DispatchQueue.main.async {
                               self?.colView.reloadData()
                           }
                           print("No record found. Message: \(message)")
                       }
                     
                   }
               }
            )                      
      
        
      
    
     
    }
   
    var ids = Int ()
    var menu: SideMenuNavigationController!
    var fetechedEmployee = employeeProfileviewmodel()
    @IBOutlet weak var colView: UICollectionView!
    var array = [Employees]()
    
    @IBAction func button(_ sender: Any) {
     
        presentsemployee(name:  "AddEmployee", identifire: "AddEmployee")
    }
    @IBAction func menuButton(_ sender: Any) {
        present(menu!, animated: true)
    }
   
 
    @IBOutlet weak var menuview: UIView!
    @IBOutlet weak var menuButton: UIButton!
    let loadingView = Loading.instanceFromNib()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.setTitle("", for: .normal)
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.estimatedItemSize = flowLayout.estimatedItemSize
//        colView.collectionViewLayout = flowLayout
//        
        
        
//        let logo =    #imageLiteral(resourceName: "pexels-simon-robben-614810.jpg")
//        let imageView = UIImageView(image: logo)
//  
//            
//        // Set constraints for the custom image view
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//       
//        // Create a container view to add padding if needed
//        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
//        imageView.setRounded()
//        containerView.addSubview(imageView)
//        containerView.addSubview(secondLable)
//        containerView.addSubview(firstTextLabel)
//        // Set constraints for the container view
//        containerView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        containerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
//  
//        let leftBarButton = UIBarButtonItem(customView: containerView)
//    
//        self.navigationItem.leftBarButtonItem = leftBarButton
//        self.navigationItem.rightBarButtonItem = rightbutton
//        navigationController?.navigationBar.backgroundColor = UIColor(hex: 0xF18318)
//        
//        NSLayoutConstraint.activate([
//            secondLable.topAnchor.constraint(equalTo: firstTextLabel.bottomAnchor , constant: 2),
//            secondLable.leadingAnchor.constraint(equalTo: imageView.trailingAnchor , constant: 10),
//            firstTextLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor , constant: 10)
//        ])

        
    
        
        if #available(iOS 13.0, *) {
            
            let statusBar = UIView(frame: UIApplication.shared.statusBarFrame)
            statusBar.backgroundColor = UIColor(hex: 0xF18318) // Replace with your color
            view.addSubview(statusBar)
        } else {
            UIApplication.shared.statusBarStyle = .lightContent
        }

        employeefetching()
        
    
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        
        colView.delegate = self
        colView.dataSource = self
        
        let nib = UINib(nibName: "employeeCell", bundle: nil)
        colView.register(nib, forCellWithReuseIdentifier: "employeeCell")
        
        
     
     
    }
    func employeefetching(){
        // Assuming you are in a view controller, you can add the loading view as a subview
        self.view.addSubview(loadingView)
        loadingView.present(size: self.view.bounds)
        self.view.addSubview(loadingView)
        
        fetechedEmployee.employeFetching(whenFinish: { [weak self] result in
            switch result {
            case .success(let user):
             
                for ar in user.data {
                    self?.array.append(ar)
                    
                }
                DispatchQueue.main.async {
                    self?.colView.reloadData()
                }
                
                self?.loadingView.dismiss()
            case .failure(let networkError):
                // Handle different types of errors
                switch networkError {
                case .unexpected:
                    print("Unexpected error occurred")
                    self?.loadingView.dismiss()
                case .apiError(let statusCode):
                    print("API error occurred with status code: \(statusCode)")
                    self?.loadingView.dismiss()
                case .noRecordFound(let message):
                    
                    self!.array = []
                    print("No record found. Message: \(message)")
                }
                
                
                
                self?.loadingView.dismiss()
            }
            
        })
    }
    func  presentsemployee(name:String, identifire:String){
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifire)
        present(initialViewController, animated: false, completion: nil)
    }
    @objc func Toggled(_ sender: UISwitch) {
        let id  = sender.tag
        print()
        if sender.isOn == true {
            fetechedEmployee.changestatusemployee(id
                                                  :ids, action: "active", completion: { [weak self] result in
                   switch result {
                   case .success(let user):
                    print("")
                   case .failure(let networkError):
                       // Handle different types of errors
                      print("")
                   }
               })
            } else {
                fetechedEmployee.changestatusemployee(id:ids, action: "inactive", completion: { [weak self] result in
                       switch result {
                       case .success(let user):
                      
                        print("")
                       case .failure(let networkError):
                           // Handle different types of errors
                          print("")
                         
                       }
                   })
            }
    }
}
extension Employee: UICollectionViewDelegate, UICollectionViewDataSource {
    
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "employeeCell", for: indexPath) as! employeeCell
        // current position
        let currentEmployee = array[indexPath.row]
        cell.name.text! = currentEmployee.name
        cell.desigantion.text! = currentEmployee.designation
        cell.email.text! = currentEmployee.email
        cell.joiningDate.text! = currentEmployee.joiningDate
        cell.serialNumber.text! = "#\(indexPath.row)" // Adjusted index
        let url = URL(string: currentEmployee.image)
        cell.image.kf.setImage(with: url)
        cell.phoneNumber.text! = currentEmployee.phone
        cell.switchdelegate = self
     //   cell.`switch`.addTarget(self, action: #selector(Toggled(_:)), for: .valueChanged)
       
        print("status ",currentEmployee.status)
      
        let ids =   cell.confifure(employee: currentEmployee)
        cell.delegate = self
        // Configure your cell if needed
        return cell
    }
    
}


extension UISwitch {
    
    func set(width: CGFloat, height: CGFloat) {
        
        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51
        
        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth
        
        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}
extension UIImageView {
   
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}
