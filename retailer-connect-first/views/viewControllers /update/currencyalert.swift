//
//  currency.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 23/05/2024.
//

import Foundation


import UIKit
import iOSDropDown
protocol  submitcurrency: AnyObject {
    func submit(name:String, code:String, symbol:String, id:Int )
}
class currencycalert: UIViewController {
    var CustomerName:String!
    var emails:String!
    var id:Int!
    var codeL:String!
    var symbolL:String!
    
    var rolearray = [roledata]()
    weak var delegate: submitcurrency?
    
    @IBAction func submitaction(_ sender: Any) {
        delegate?.submit(
            name: name.text!,
            code: code.text!,
            symbol: symbol.text!,
            id: id!
        )
    }
    @IBOutlet weak var symbol: CustomTextField!
    @IBOutlet weak var code: CustomTextField!
    @IBOutlet weak var name: CustomTextField!
    var model = peoplesviewmodel()
    var roleid  = Int()
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        code.text = codeL
        symbol.text = symbolL
        name.text = CustomerName
        let tap = UITapGestureRecognizer(target: self, action:#selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
