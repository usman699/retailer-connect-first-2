
import UIKit
import SideMenu
import iOSDropDown
import Keychain
struct MenuWithSubmenus {
    let menu: roledata
    var submenus: [roledata]
}
extension Notification.Name {
    static let myCustomNotification = Notification.Name("myCustomNotification")
   static let notificationIdentifier =   Notification.Name("enable")
}
struct modelmenu {
    let menu:  Int
    var submenus:  Int
}



class grouppermetionsviewcontroller: UIViewController {
    var onDataAvailable : (( _ data: [activeselectedrole]) -> ())?
    var menu:SideMenuNavigationController!
    @IBOutlet weak var lables: UILabel!
    var check = false
    var menuid = Int()
    var submenuid = Int()
    @IBOutlet weak var dropdonw: DropDown!

    @IBAction func viewpermistions(_ sender: Any) {
        let storyboard = UIStoryboard(name: "newUser", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "viewUser")
        present(initialViewController, animated: true)
    }
    var farray: [activeselectedrole] = []
    @IBOutlet weak var viewpermistions: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var mainview: UIView!
    @IBAction func menuButton(_ sender: Any) {
        DispatchQueue.main.async {
            
            self.present(self.menu!, animated: true)
        }
    }
   
    
    let useremail = Keychain.load("user_email") as? String
    let username = Keychain.load("username") as? String
@IBOutlet weak var name: UILabel!
@IBOutlet weak var email: UILabel!
   

@IBAction func signout(_ sender: Any) {
    Keychain.save("", forKey: "tokken") as? String
    Keychain.save("", forKey: "user_email")
    Keychain.save("", forKey: "username")
    let loadtokken = Keychain.load("tokken") as? String

    if (  loadtokken == "" ){
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "login")
        initialViewController.modalPresentationStyle = .fullScreen
               present(initialViewController, animated: true)
                
        print("tokken is empty ", loadtokken)
    }
       
    else {
        print("tokken is  ", loadtokken)
    }
}


    @IBOutlet weak var menubutton: UIButton!
    @IBAction func button(_ sender: Any) {
        check( button: button)}
  
    var arrayroles = [String]()
    var arrayrolesid = [Int]()
    var model  = settingsviewmodel()
    func check( button:UIButton){
        check.toggle()
        if  check{
            button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
       
        }
        else {
            button.setImage(UIImage(systemName: "square"), for: .normal)
           
        }
        
    }
    @IBOutlet weak var widthconstraints: NSLayoutConstraint!
    var menuArray: [roledata] = []
    var submenus: [roledata] = []
    var menuWithSubmenusArray: [MenuWithSubmenus] = []
    var selectedarray = [activeselectedrole ]()
    var id:Int?
    @IBOutlet weak var views: SetShadow!
    @IBOutlet weak var mmainview: UIView!
    @IBOutlet weak var viewButton: UIButton!
    var subandmenu = [modelmenu]()
    override func viewDidLoad() {
          
        super.viewDidLoad()
        setupui()
        fetchroles()
        fetchData()
       
        name.text = username
            email.text = useremail
        
    }
    
    func fetchData() {
        let dispatchGroup = DispatchGroup()
                dispatchGroup.enter()
        model.activemenu { [weak self] result in
                    defer { dispatchGroup.leave() }
                    switch result {
                    case .success(let menus):
                  
                        self?.menuArray = menus.data
                    
                        for i in self!.menuArray {
                 
                        }
                    case .failure(let error):
                        print("Failed to fetch menus: \(error)")
                    }
                }
        dispatchGroup.enter()
        model.activesubmenu { [weak self] result in
                defer { dispatchGroup.leave() }
                switch result {
                case .success(let submenus):
                    self?.submenus = submenus.data
                    for i in self!.submenus {
                  
                    }
                case .failure(let error):
                    print("Failed to fetch submenus: \(error)")
                }
            }
            
        dispatchGroup.notify(queue: .main) { [weak self] in
               guard let self = self else { return }

               let mergedArray = self.mergeMenuAndSubmenu(menuArray: self.menuArray, submenuArray: self.submenus)
               self.menuWithSubmenusArray = mergedArray
         
            for i in menuWithSubmenusArray {
                print("megrged data",i.menu, i.submenus)
            }
               self.tableview.reloadData()
           }
    }
    
    func mergeMenuAndSubmenu(menuArray: [roledata], submenuArray: [roledata]) -> [MenuWithSubmenus] {
        var mergedArray: [MenuWithSubmenus] = []
        var index = 0
        
        for menu in menuArray {
            let menuWithSubmenus = MenuWithSubmenus(menu: menu, submenus: submenuArray)
            mergedArray.append(menuWithSubmenus)
            index += 1
        }
        
      //  print("Merged Array: \(mergedArray)")
        
        return mergedArray
    }
    func fetchselectedrolles(id:Int){
        model.fetchselectedroles(id: id,completion: {result in
            switch result {
            case .success(let res):
                self.selectedarray = res.data
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "MessageReceived"), object: self.selectedarray))
                
                self.fetchresults(selectedarrays: self.selectedarray)
                
                self.tableview.reloadData()
            case .failure(let error ):
                switch error{
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
                
                print("erorrs" .errorDescription)
                
            }
            
            
        })
    }
  
       
    @IBAction func submit(_ sender: Any) {
    print("role id",id)
        if id == nil {
     
            Global.shared.showMsg(msg: "Please Select Roles", title: "")
            return
        }
        
        if  subandmenu.count  == 0 {
            Global.shared.showMsg(msg: "Please Select SubMenus", title: "")
            return
        }
        
        
        print("submeenu ", subandmenu)
        
        
    }
    func fetchresults(selectedarrays: [activeselectedrole]) {
        var menuDict = [Int: [Int]]()
        
        // Iterate over selectedarrays to populate menuDict
        for item in selectedarrays {
            if let menuId = item.menuId, let subMenuId = item.subMenuId {
                if var subMenuIds = menuDict[menuId] {
                    subMenuIds.append(subMenuId)
                    menuDict[menuId] = subMenuIds
                } else {
                    menuDict[menuId] = [subMenuId]
                }
            }
        }
        
        // Convert the dictionary into the required format
        var newArray: [[String: Any]] = []
        for (menuId, subMenuIds) in menuDict {
            var entry: [String: Any] = ["menuId": menuId]
            entry["subMenuId"] = subMenuIds
            newArray.append(entry)
        }
        
   
        
        // Assuming you want to update farray with the new array
        farray = newArray.map { dictionary in
            // Since subMenuIds in dictionary is an array, we need to convert it to a suitable format
            let menuId = dictionary["menuId"] as? Int
            let subMenuIds = dictionary["subMenuId"] as? [Int] ?? []
            
            // Creating a flat list of activeselectedrole instances
            return subMenuIds.map { subMenuId in
                activeselectedrole(menuId: menuId, subMenuId: subMenuId)
            }
        }.flatMap { $0 }
        print("new farray ",newArray)
        
    }
    func fetchroles(){
        model.activerole(completion: {result in
            switch result {
            case .success(let res):
                
                for i in res.data {
                    self.arrayroles.append(i.name!)
                    self.arrayrolesid.append(i.id!)
                }
               
                Global.shared.configurewithids(dropDown: self.dropdonw, array: self.arrayroles, ids: self.arrayrolesid, didSelect: {selectedtext,ids, index in
                    self.lables.isHidden = true
                    
                    self.id = ids
                
                    self.fetchselectedrolles(id: self.id!)
                    
                  
                                               })
            case .failure(let error ):
                switch error{
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
                
                print("erorrs" .errorDescription)
                
            }
            
            
        })
        
    }
 
    func setupui(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleCustomNotification(_:)), name: .myCustomNotification, object: nil)
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menubutton.setTitle("", for: .normal)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .white    
        tableview.register(UINib(nibName: "gruoppermistion", bundle: nil), forCellReuseIdentifier: "group")
    }
    @objc func handleCustomNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any] {
            let menuId = userInfo["menuId"] as? Int
            let submenuId = userInfo["submenuId"] as? Int
            print("Received notification - Menu ID: \(menuId), Submenu ID: \(submenuId)")
            if id == nil {
                Global.shared.showMsg(msg: "Please Select Role First", title: "")
                // Enable the check button if id is not nil
                // Post a notification
                // Create a dictionary to hold menuId and submenuId
                var checkbutton  = true
                
                // Post the custom notification with the dictionary
                NotificationCenter.default.post(name: .notificationIdentifier, object: checkbutton)
                return
            }
            subandmenu.append(modelmenu(menu: menuId!, submenus: submenuId!))
            
            // Handle the menuId and submenuId as needed
        }
    }

      
      deinit {
          // Remove the observer
          NotificationCenter.default.removeObserver(self, name: .myCustomNotification, object: nil)
      }
}

    extension  grouppermetionsviewcontroller: UITableViewDelegate, UITableViewDataSource{
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "group", for: indexPath) as! gruoppermistioncell
                   let currentMenuWithSubmenus = menuWithSubmenusArray[indexPath.row]
                   cell.label.text = currentMenuWithSubmenus.menu.name
            
            
            cell.configure(with: currentMenuWithSubmenus.submenus, selectedItems: currentMenuWithSubmenus.menu , selectedarray : farray )
//            print("Cell width: \(cell.frame.width)")
//                    print("Content view width: \(cell.contentView.frame.width)")
//                    
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
        }
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
                // Print the cell width
            
            widthconstraints.constant = cell.contentView.frame.width + 80
            widthconstraints.isActive = true
                print("Cell width: \(cell.frame.width)")
                print("Content view width: \(cell.contentView.frame.width)")
            }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return  menuWithSubmenusArray.count  // Or whatever number you need for the second
            
        }
    }

