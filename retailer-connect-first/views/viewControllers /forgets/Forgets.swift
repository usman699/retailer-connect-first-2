//
//  LoginsViewController.swift
//  retailer-connect-first
//
//  Created by Spark on 08/11/2023.
//

import UIKit

class ForgetsViewController: UIViewController {

    
    @IBOutlet weak var emial: UILabel!
    @IBOutlet weak var fill: UILabel!
    @IBOutlet weak var titleone: UILabel!
    
    
    @IBOutlet weak var loinButton: UIButton!
    
    @IBOutlet weak var siginin: UILabel!
    @IBOutlet weak var textfeildone: UITextField!
    //    @IBAction func signUp(_ sender: Any) {
  
    //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "forget")
//        self.navigationController?.present(initialViewController, animated: true)
//        
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
 
   
           
           inits()
            // Set other configurations and constraints as needed

    
        UIElementsManager.shared.CutomTextField(textField: textfeildone, name: "Password", imageName: "lock.fill")

        
           // Customize login button if needed
       
    }
    
    func inits(){
       titleone.textColor = .black
       
        view.backgroundColor = .white
        siginin.textColor = .black
       
        loinButton.tintColor = .orange
        emial.textColor = .black
        fill.textColor = .black
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

