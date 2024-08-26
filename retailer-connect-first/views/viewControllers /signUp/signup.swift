
//
//  LoginsViewController.swift
//  retailer-connect-first
//
//  Created by Spark on 08/11/2023.
//

import UIKit

class SIGNUPVIEWSCONTOLLER: UIViewController {
    
    @IBOutlet weak var titleone: UILabel!
    @IBOutlet weak var textfeildthree: UITextField!
    
    @IBOutlet weak var textfeildone: UITextField!
    
    @IBOutlet weak var textfeildtow: UITextField!
    
    @IBOutlet weak var loginbutton: UIButton!
    
    @IBOutlet weak var footer: UILabel!
    @IBOutlet weak var paraph: UILabel!
    override func viewDidLoad() {
       
        super.viewDidLoad()
 
   
           
           inits()
            // Set other configurations and constraints as needed

        UIElementsManager.shared.CutomTextField(textField: textfeildone, name: "User name", imageName: "person.fill")
      
      
         
            UIElementsManager.shared.CutomTextField(textField: self.textfeildtow, name: "Email", imageName: "envelope")
        
   
        
        
        UIElementsManager.shared.CutomTextField(textField: textfeildthree, name: "Password", imageName: "lock.fill")
        
           // Customize login button if needed
       
    }
    
    func inits(){
        titleone.textColor = .black
       paraph.textColor = .black
        view.backgroundColor = .white

        footer.textColor = .black
    
        
        
        loginbutton.tintColor = .orange
   
    }

    /*
     @IBOutlet weak var signLable: UILabel!
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}




