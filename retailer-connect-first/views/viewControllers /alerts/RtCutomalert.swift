//
//  RtCutomalert.swift
//  retailer-connect-first
//
//  Created by Spark on 15/01/2024.
//

import UIKit

class RtCutomalert: UIViewController {
    @IBOutlet weak var status: UILabel!
    
    @IBAction func confrim(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var msg:String!
    var ttiles:String!
    @IBOutlet weak var message: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        message.text = msg
        status.text = ttiles
        
        
        // Do any additional setup after loading the view.
    }
    init() {
    super.init(nibName: "RtCutomalert", bundle: Bundle(for: RtCutomalert.self))
    self.modalPresentationStyle = .overCurrentContext
    self.modalTransitionStyle = .crossDissolve
    }
    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    func show() {
        DispatchQueue.main.async {
                UIApplication.shared.windows.first?.rootViewController?.present(self, animated: true, completion: nil)
                UIApplication.shared.keyWindow?.rootViewController!.present(self, animated: true, completion: nil)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


