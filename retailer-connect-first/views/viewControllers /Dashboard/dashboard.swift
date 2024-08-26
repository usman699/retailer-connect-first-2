//
//  dashboardViewController.swift
//  retailer-connect-first
//
//  Created by Spark on 10/11/2023.
//

import UIKit

import SideMenu
import DGCharts
class DDashboardViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
   // @IBOutlet weak var smallview: UIView!
    let months = ["Jan", "Feb", "Mar", "Apr", "May"]
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0]
    let unitsBought = [10.0, 14.0, 60.0, 13.0, 2.0]
    var menu: SideMenuNavigationController!
    @IBAction func menubutton(_ sender: Any) {
        
  present(menu! , animated: true)

     
    }
   
    
    @IBOutlet weak var saleView: UIView!
    @IBOutlet weak var hCollectionview: UICollectionView!
    @IBOutlet weak var piechart2: PieChartView!
    
    @IBOutlet weak var piechart1: PieChartView!
    
  
    @IBOutlet weak var ffb: UIButton!
    @IBOutlet weak var topviews: UIView!
    @IBOutlet weak var barcharts:BarChartView!
    @IBOutlet weak var fourhb: UIButton!
    @IBOutlet weak var thirdB: UIButton!
    @IBOutlet weak var secondb: UIButton!
    @IBOutlet weak var firstb: UIButton!
    @IBOutlet weak var viewback: UIView!
    @IBOutlet weak var uiview4: UIView!
    @IBOutlet weak var uiview2: UIView!
    @IBOutlet weak var firstTotal: UILabel!
    @IBOutlet weak var uiview: UIView!
    
   @IBOutlet weak var menubtton: UIButton!
@IBOutlet weak var barChartView:HorizontalBarChartView!
    @IBOutlet weak var bb: UIButton!
    @IBOutlet weak var uiview3: UIView!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var leftbarbuttonitem: UIBarButtonItem!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cbigview.backgroundColor = .white
        
        
        
          
 
       
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        
        UIElementsManager.shared.BarChartfunc(barcharts: barcharts)
        UIElementsManager.shared.horizontalBarData(horizontalBars: barChartView)
        
        UIElementsManager.shared.setChart(barcharts: barcharts)
        UIElementsManager.shared.setupPieChartOne(piechart1: piechart1)
        UIElementsManager.shared.setupPieChartTwo(piechart2: piechart2)
        piechart1.backgroundColor = .white
        menubtton.setTitle("", for: .normal)
        piechart2.backgroundColor = .white

           
                let nib = UINib(nibName: "cCollectionViewCell", bundle: nil)
                collectionView.register(nib, forCellWithReuseIdentifier: "collectionCells")
                collectionView.backgroundColor = .white
        
                // Set the data source for the collection view
                collectionView.dataSource = self
                collectionView.delegate = self
        
                let nib2 = UINib(nibName: "HCollectionViewCell", bundle: nil)
                hCollectionview.register(nib2, forCellWithReuseIdentifier: "Hcollectionviewcell")
                hCollectionview.backgroundColor = .white
                hCollectionview.dataSource = self
        
        
                hCollectionview.delegate = self
     
       
     
        
  
        
        bb.setTitle("", for: .normal)
        ffb.setTitle("", for: .normal)
       
        UINavigationBar.appearance().tintColor = UIColor.white // Check for something like this affecting text color
        

        setViewSettingWithBgShade(view: uiview)
        setViewSettingWithBgShade(view: uiview2)
        setViewSettingWithBgShade(view: uiview3)
        setViewSettingWithBgShade(view: uiview4)
        setViewSettingWithBgShadess(view: firstb)
        setViewSettingWithBgShadess(view: secondb)
        setViewSettingWithBgShadess(view: thirdB)
     //   setViewSettingWithBgShade(view: smallview)
        setViewSettingWithBgShade(view: saleView)
        setViewSettingWithBgShade(view: piechart2)
        setViewSettingWithBgShade(view: cbigview)
        cbigview.layer.cornerRadius  = 10

        barcharts.layer.cornerRadius = 10
        barcharts.backgroundColor = .white
       
    //    smallview.layer.cornerRadius = 10

    }
    
    
    @IBOutlet weak var cbigview: UIView!
    
   
    
        
     
}

       
    

    
    

    
    extension UIColor {
        convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
            let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(hex & 0x0000FF) / 255.0
            
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
    }

public func setViewSettingWithBgShade(view: UIView)
{
    view.layer.cornerRadius = 6
  //  view.layer.borderWidth = 1
 //   view.layer.borderColor = UIColor.red.cgColor
    
    //MARK:- Shade a view
    view.layer.shadowOpacity = 0.2
    view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    view.layer.shadowRadius = 2.0
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.masksToBounds = false
}




public func setViewSettingWithBgShados(view: UIView)
{
view.layer.cornerRadius = 8
view.layer.masksToBounds = true
view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  //  view.layer.borderWidth = 1
 //   view.layer.borderColor = UIColor.red.cgColor
    
    //MARK:- Shade a view
    view.layer.shadowOpacity = 0.2
    view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    view.layer.shadowRadius = 2.0
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.masksToBounds = false
}
public func   setViewSettingWithBgShadess(view: UIView)
{
    view.layer.cornerRadius = 8
  //  view.layer.borderWidth = 1
 //   view.layer.borderColor = UIColor.red.cgColor
    
    //MARK:- Shade a view
    view.layer.shadowOpacity = 0.1
    view.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    view.layer.shadowRadius = 0.5
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.masksToBounds = false
}






extension DDashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hCollectionview {
            // Return the number of items for hCollectionviews
            return 1
        } else {
            // Return the number of items for collectionView
            return 2
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          if scrollView == collectionView {
             hCollectionview.contentOffset = scrollView.contentOffset
          } else if scrollView == hCollectionview {
              collectionView.contentOffset = scrollView.contentOffset
          }
      }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hCollectionview {
            // Dequeue and return a cell for hCollectionviews
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Hcollectionviewcell", for: indexPath) as! HCollectionViewCell
            cell.layer.cornerRadius = 5
            // Configure the cell for hCollectionviews
           
            return cell
        } else {
            // Dequeue and return a cell for collectionView
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCells", for: indexPath) as! cCollectionViewCell
            // Configure the cell for collectionView
            cell.backgroundColor = .green
            return cell
        }
    }
}


