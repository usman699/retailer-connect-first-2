//
//  HomeViewController.swift
//  retailer-connect-first
//
//  Created by Spark on 02/11/2023.
//

import UIKit
var buttonGetstarted = UIButton()
var paragraphLable = UILabel()
var image1: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.layer.cornerRadius = 10
    image.image = UIImage(named: "email")
    return image
}()

var imagetwo: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.layer.cornerRadius = 10
    image.image = UIImage(named: "facebook")
    return image
}()

var image3: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.image = UIImage(named: "google")
    image.layer.cornerRadius = 10
    return image
}()


class ChoosingController: UIViewController {
   
    
   
  
    override func viewDidLoad() {
        super.viewDidLoad()
   
        inits()
        applyConstraints()
  
      
   
     //   startAutoScroll()
        
        // Do any additional setup after loading the view.
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
     //   PageControl.frame = CGRect(x: view.frame.origin.x, y:   view.frame.size.height - 20, width: 200, height: 20)
     //   PageControl.frame = CGRect(x: 0, y: 0, width: 200, height:30)
    }
    func inits(){
        buttonGetstarted = UIElementsManager.shared.buttonGetstarted
        
        paragraphLable = UIElementsManager.shared.paragraphLable
        
        view.addSubview(imageIcon)
        view.addSubview(image1)
        view.addSubview(imagetwo)
        view.addSubview(image3)
        view.addSubview(paragraphLable)
        let buttonGesture = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
          buttonGetstarted.addGestureRecognizer(buttonGesture)
        
        
        buttonGetstarted.setTitle("Login With", for: .normal)
        paragraphLable.text = "In this modified code, the collectionView is constrained to the bottom of the pageControl with a margin of -20 points (to give space between the collection view and the page control)"
    
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        view.addSubview(buttonGetstarted)
    
    }
    @objc func    profileTapped(){
     
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LOGINWITH")
        self.navigationController?.present(initialViewController, animated: true)
        
        
        
//        let initialViewController = ViewControllerHandler(for: Storybords.Main, viewController: ViewCtrl.Product).genrateViewController() as! ProductViewController
//        initialViewController.isSearchable = true
//        initialViewController.searchQuery = tfSearch.text
//        self.navigationController?.pushViewController(initialViewController, animated: true)
    }
    func applyConstraints() {
        // Constraints for imageIcon
        NSLayoutConstraint.activate([
            imageIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageIcon.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8), // 80% of the screen width
            imageIcon.heightAnchor.constraint(equalToConstant: 100),
            imageIcon.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 80)
        ])
        
        // Constraints for paragraphLable
        NSLayoutConstraint.activate([
            paragraphLable.topAnchor.constraint(equalTo: imageIcon.bottomAnchor, constant: 80),
            paragraphLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            paragraphLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        // Constraints for buttonGetstarted
        NSLayoutConstraint.activate([
            buttonGetstarted.topAnchor.constraint(equalTo: paragraphLable.bottomAnchor, constant: 80),
            buttonGetstarted.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonGetstarted.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8), // 80% of the screen width
            buttonGetstarted.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Constraints for image1, imagetwo, and image3
        NSLayoutConstraint.activate([
            image1.widthAnchor.constraint(equalToConstant: 50),
            image1.heightAnchor.constraint(equalToConstant: 50),
            image1.topAnchor.constraint(equalTo: buttonGetstarted.bottomAnchor, constant: 70),
            image1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imagetwo.widthAnchor.constraint(equalToConstant: 50),
            imagetwo.heightAnchor.constraint(equalToConstant: 50),
            imagetwo.topAnchor.constraint(equalTo: buttonGetstarted.bottomAnchor, constant: 70),
            imagetwo.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60),
            
            image3.widthAnchor.constraint(equalToConstant: 50),
            image3.heightAnchor.constraint(equalToConstant: 50),
            image3.topAnchor.constraint(equalTo: buttonGetstarted.bottomAnchor, constant: 70),
            image3.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60)
        ])
    }

   
    var imageIcon:UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image?.withRenderingMode(.alwaysOriginal)
        image.image = UIImage(named: "logo-final 2")
      //  image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return image
    }()
  
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   

}

