//
//  ManageDestination.swift
//  retailer-connect-first
//
//  Created by Spark on 11/12/2023.
//

import UIKit

class ManageDestination: UIViewController {

    @IBOutlet weak var secondview: UIView!
    @IBOutlet weak var menubutton: UIButton!
    
    @IBOutlet weak var FirstView: UIView!
    @IBAction func menubutton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        menubutton.setTitle("", for: .normal)
        UIElementsManager.shared.setViewSettingWithBgShade(view: FirstView)
        UIElementsManager.shared.setViewSettingWithBgShade(view: secondview)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
