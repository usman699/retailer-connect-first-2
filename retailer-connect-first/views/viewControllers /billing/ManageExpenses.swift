//
//  MANAGEEXPENSESViewController.swift
//  retailer-connect-first
//
//  Created by Spark on 29/11/2023.
//

import UIKit
import DGCharts
import SideMenu
class MANAGEEXPENSESViewController: UIViewController {
    var menu : SideMenuNavigationController!
    
    @IBOutlet weak var incomviewMainChart: UIView!
    @IBOutlet weak var mainview: UIView!
    @IBAction func menuButton(_ sender: Any) {
        present(menu! , animated: true)
      
    }
    @IBOutlet weak var menuButton: UIButton!
    //    hmanagexpemnsed
    
    @IBOutlet weak var CVIEW: UIView!
    //    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var IncomeChart: PieChartView!
    
    @IBOutlet weak var menubutton: UIButton!
    @IBAction func menu(_ sender: Any) {
    }
    @IBOutlet weak var expenseslineChart: BarChartView!
    @IBOutlet weak var TotalExpenseChart: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
             let nib = UINib(nibName: "HManageExpensesCell", bundle: nil)
             firstCollectionvierw.register(nib, forCellWithReuseIdentifier: "hmanage")
             firstCollectionvierw.backgroundColor = .white
     
             // Set the data source for the collection view
             firstCollectionvierw.dataSource = self
             firstCollectionvierw.delegate = self
     
             let nib2 = UINib(nibName: "MangegeExpensesCell", bundle: nil)
             secondSECOND.register(nib2, forCellWithReuseIdentifier: "manage")
             secondSECOND.backgroundColor = .white
             secondSECOND.dataSource = self
             secondSECOND.delegate = self
  
    
      
        menubutton.setTitle("", for: .normal)
        
        
     
       
        UINavigationBar.appearance().tintColor = UIColor.white // Check for something like this affecting text color
        CVIEW.backgroundColor = .white

        setViewSettingWithBgShade(view: lastWeekview)
        setViewSettingWithBgShade(view: CVIEW)
     //   setViewSettingWithBgShade(view: TotalExpenseChart)
       // setViewSettingWithBgShade(view: IncomeChart)
        setViewSettingWithBgShade(view: mainview)
        setViewSettingWithBgShade(view:incomviewMainChart)
        
       // firstCollectionvierw.backgroundColor = .white
        secondSECOND.backgroundColor = .white
        
       
        UIElementsManager.shared.setupPieChartOne(piechart1: IncomeChart)
        UIElementsManager.shared.setupPieChartTwo(piechart2: TotalExpenseChart)
        UIElementsManager.shared.BarChartfunc2(barcharts: expenseslineChart)
        UIElementsManager.shared.setChart2(barcharts: expenseslineChart)
        mainview.backgroundColor = .white
        incomviewMainChart.backgroundColor = .white
        expenseslineChart.backgroundColor = .white
        IncomeChart.backgroundColor = .white
    //    TotalExpenseChart.backgroundColor = .white
      
    }


    @IBOutlet weak var lastWeekview: UIView!
    @IBOutlet weak var secondSECOND: UICollectionView!

    @IBOutlet weak var firstCollectionvierw: UICollectionView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MANAGEEXPENSESViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstCollectionvierw {
            // Return the number of items for hCollectionviews
            return 1
        } else {
            // Return the number of items for collectionView
            return 3
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          if scrollView == firstCollectionvierw {
             secondSECOND.contentOffset = scrollView.contentOffset
          } else if scrollView == secondSECOND {
              firstCollectionvierw.contentOffset = scrollView.contentOffset
          }
      }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == secondSECOND {
            // Dequeue and return a cell for hCollectionviews
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "manage", for: indexPath) as! MangegeExpensesCell
            cell.layer.cornerRadius = 5
            // Configure the cell for hCollectionviews
           
            return cell
        } else {
            // Dequeue and return a cell for collectionView
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hmanage", for: indexPath) as! HManageExpensesCell
            // Configure the cell for collectionView
            cell.backgroundColor = .white
            return cell
        }
    }
}
