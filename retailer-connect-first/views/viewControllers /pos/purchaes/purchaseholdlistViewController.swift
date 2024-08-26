//
//  purchaseholdlistViewController.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 18/04/2024.
//


import UIKit
import SideMenu


class purchaseholdlistViewController:  UIViewController, unhold {
    func unhold(holder: String) {
        var lable = String()
        model.unholdpurchase(holder_name: holder, completion: { [self]result in
              switch result {
              case .success(let success):
                  print("success", success.message)
                  table.reloadData()
              case .failure(let error ):
                  switch error {
                      
                  case .decodingError:
                      print("decoding eror ")
                  case .notFound:
                      print("not found")
                  case .conflict:
                      print("conflick error ")
                      lable = "cart already exist!"
                       Global.shared.showMsg(msg: "", title: lable )
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
    
  
    
    
    @IBOutlet weak var menubutton: UIButton!
    
    @IBAction func m1(_ sender: Any) {
        present(menu!, animated: true)
    }
    @IBAction func createpdf(_ sender: Any) {
        
  
            // 1. estimate tableview contentsize
            UIGraphicsBeginImageContextWithOptions(table.contentSize, false, 0)
            table.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            table.layer.render(in: UIGraphicsGetCurrentContext()!)

            // 2. calculate number of part of tableview, loop and get snapshot
            let iterationCount = Int(ceil(table.contentSize.height / table.bounds.size.height))
            for i in 0..<iterationCount {
                table.setContentOffset(CGPoint(x: 0, y: Int(table.bounds.size.height) * i), animated: false)
                table.layer.render(in: UIGraphicsGetCurrentContext()!)
            }

            // 3. merge and make UIImageView from snapshot
            let image = UIGraphicsGetImageFromCurrentImageContext()
            let pdfImageView = UIImageView(image: image)

            //4. render imageView to PDF
            let pdfData: NSMutableData = NSMutableData()
            UIGraphicsBeginPDFContextToData(pdfData, pdfImageView.bounds, nil)
            UIGraphicsBeginPDFPageWithInfo(pdfImageView.bounds, nil)
            pdfImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
            UIGraphicsEndPDFContext()
            
            // 5. Save PDF to documents directory
            let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let documentsFileName = documentDirectories! + "/" + "MyPDF.pdf"
            pdfData.write(toFile: documentsFileName, atomically: true)

            // 6. Download and show the PDF
            if let url = URL(string: "file://" + documentsFileName) {
                let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                present(activityViewController, animated: true, completion: nil)
            }
        

        
        
    }
    @IBOutlet weak var hieghtconstant: NSLayoutConstraint!
    @IBOutlet weak var nodata: UILabel!
    var model =  purchaseviewmodel()
    var holdlists = [Holder]()
    var menu:SideMenuNavigationController!
    @IBOutlet weak var pdf: UIButton!
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        nodata.isHidden  = false
        pdf.setTitle("", for: .normal)
        menubutton.setTitle("", for: .normal)
        setupui()
        holdlistf()
    //    Global.shared.updateTableViewHeight(tableview: table, hieightconstant: hieghtconstant, view: view)
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBOutlet weak var mainview: SetShadow!
    func  holdlistf(){
        model.fetchpurchaseholdlist(completion: { [self]result in
            switch result {
            case .success(let success):
                print("success")
                for i in success.data{
                    holdlists.append(i)
                }
                table.reloadData()
                
                if holdlists.isEmpty {
             
                    self.nodata.isHidden  = false
                    self.mainview.isHidden = true
                    // Perform actions with holderName
                }
                else{
                    
                    self.mainview.isHidden = false
                    self.nodata.isHidden  = true
                }
            
                
            case .failure(let error ):
                switch error {
                    
                case .decodingError:
                    print("decoding eror ")
                case .notFound:
                    print("not found")
                case .conflict:
                    print("conflict")
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
    func setupui(){
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        menu.leftSide = true
        table.register(UINib(nibName: "hholdlistTableViewCell", bundle: nil), forCellReuseIdentifier: "hholdlistcell")
        table.delegate = self
        table.dataSource = self
        
        let secondNib = UINib(nibName: "holdlistTableViewCell", bundle: nil)
        table.backgroundColor = .white
        table.register(secondNib, forCellReuseIdentifier: "holdlistcell")
    }
}
extension purchaseholdlistViewController:  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hholdlistcell") as!  hholdlistTableViewCell
        
        // Customize the header cell as needed
        
        // Add the header cell to the header view
        headerView.addSubview(headerCell)
        
        // You might need to adjust the frame of the header cell within the header view
        headerCell.frame = CGRect(x: 0, y: -20, width: tableView.bounds.width, height: 49)
        
        return headerView
    }
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "holdlistcell", for: indexPath) as! holdlistTableViewCell
        cell.unold = self
        let currentpostion = holdlists[indexPath.row]
        cell.headername.text = currentpostion.holder_name
        cell.index.text = String(indexPath.row + 1 )
        cell.configure(data: currentpostion)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return   holdlists.count // Or whatever number you need for the second table
        
    }
    
}
