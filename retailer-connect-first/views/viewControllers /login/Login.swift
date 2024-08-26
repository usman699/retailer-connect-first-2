//
//  LoginsViewController.swift
//  retailer-connect-first
//
//  Created by Spark on 08/11/2023.
//

import UIKit
import Lottie
class LoginsViewController: UIViewController {
    @IBOutlet weak var footertwo: UILabel!
    
    @IBAction func loginbutton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "DashboardScreen", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "dashboard")
        self.navigationController?.present(initialViewController, animated: false)
        
    }
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBAction func ferget(_ sender: Any) {
        
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "forget")
        self.navigationController?.present(initialViewController, animated: true)
    }
    @IBOutlet weak var foooterone: UILabel!
    @IBOutlet weak var paragraph: UILabel!
    @IBOutlet weak var signlable: UILabel!
    @IBOutlet weak var loginbutton: UIButton!
    @IBOutlet weak var textFeild2: UITextField!
    @IBOutlet weak var textField1: UITextField!
    
    
    @IBAction func signUp(_ sender: Any) {
        animationView.isHidden = false
      
        // Set the new frame and content mode
        animationView.frame = CGRect(x: animationView.frame.origin.x, y: animationView.frame.origin.y, width: 100, height: 30)
        animationView.contentMode = .scaleAspectFill

        // Set background color
        animationView.backgroundColor = .orange
        animationView.layer.backgroundColor = UIColor.orange.cgColor

        // Set animation loop mode
        animationView.loopMode = .loop

        // Adjust animation speed
        animationView.animationSpeed = 0.5

        // Play animation
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
            // Play animation
            animationView.stop()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "signupwith")
            self.navigationController?.present(initialViewController, animated: false)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView!.isHidden = true
   
           
           inits()
            // Set other configurations and constraints as needed

        UIElementsManager.shared.CutomTextField(textField: textField1, name: "User name", imageName: "person.fill")
      
        UIElementsManager.shared.CutomTextField(textField: textFeild2, name: "Password", imageName: "lock.fill")

        
           // Customize login button if needed
       
    }
    
    func inits(){
        signlable.textColor = .black
        paragraph.textColor = .black
        view.backgroundColor = .white
        foooterone.textColor = .black
        footertwo.textColor = .black
    
        
        
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
