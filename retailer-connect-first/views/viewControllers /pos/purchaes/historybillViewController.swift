//
//  historybillViewController.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 19/04/2024.
//

import UIKit
import iOSDropDown
protocol paydelegates:AnyObject{
    func paynow()
}
class historybillViewController: UIViewController, UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hieghtconstraints.constant = 800
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        hieghtconstraints.constant = 528
    }
    @IBOutlet weak var pending: CustomTextField!
    weak  var Delegate : paydelegates!
    var totall : Int!
    var id: Int!
    var pendings : Int!
    @IBAction func Paynow(_ sender: Any) {
        print("id", id! , "payment id ", paymentid, "trasaction type", trasaction)
        
        model.paynowpurchase(received: Int(paid.text!)! , id: id!, payment_id: paymentid, transaction_type: String(trasactionType!), completion: {result in
            switch result {
            case .success(let success):
                
                self.Delegate.paynow()
              
                
                self.dismiss(animated: true)
                
            case .failure(let error ):
                switch error {
                    
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
            }
        })
                             }
        
        
    
    var trasactionType:String!
    var trasaction = [String]()
    var paymentarray = [String]()
    @IBOutlet weak var trasactiontypes: DropDown!
    var paymentids = [Int]()
    var paymentid = Int()
    @IBAction func trasactiontype(_ sender: Any) {
    }
    var model = purchaseviewmodel()
    @IBOutlet weak var paynow: UIButton!
    @IBOutlet weak var paid: CustomTextField!
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBOutlet weak var hieghtconstraints: NSLayoutConstraint!
    @IBOutlet weak var payment: DropDown!
    @IBOutlet weak var total: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchpayment()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
       //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
       //tap.cancelsTouchesInView = false
        tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
        fetchtrasaction()
        paid.delegate = self
        paid.keyboardType = .numberPad
        
        total.text =  String(totall.description)
        pending.text =  String(pendings.description)
        pending.isUserInteractionEnabled = false
        total.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }
   
    
    func fetchtrasaction(){
        model.fetchTrasaction( completion: { [self]result in
            switch result {
            case .success(let success):
                
                trasaction = success.data
              
                print(trasaction , "array")
                Global.shared.configuredDropDown(dropDown: trasactiontypes, array: self.trasaction, didSelect: { selectedText in
                    trasactionType = selectedText
                 //   self.labletrasaction.isHidden = true
                    
                })
                
            case .failure(let error ):
                switch error {
                    
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
            }
        })
    }
    func fetchpayment(){
        model.fetchpayment( completion: { [self]result in
            switch result {
            case .success(let success):
                for i in success.data{
                    paymentarray.append(i.name)
                    paymentids.append(i.id)
                }
                
                Global.shared.configuredDropDownwithid(dropDown: payment, array: self.paymentarray, ids: self.paymentids, didSelect: {selectedtext,id in
                    paymentid = id
                    print("data of cutomer", selectedtext,id)
              //      labelpayment.isHidden = true
                //    paymentid = id
                })
                
            case .failure(let error ):
                switch error {
                    
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
            }
        })
    }
}
