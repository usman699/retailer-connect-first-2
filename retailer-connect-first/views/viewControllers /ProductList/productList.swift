//
//  productList.swift
//  retailer-connect-first
//
//  Created by Spark on 04/12/2023.
//

import UIKit
import SideMenu
class productList: UIViewController {
    @IBOutlet weak var search: UIButton!

    @IBOutlet weak var firstCollectionvierw: UICollectionView!
    var menu :SideMenuNavigationController!
    @IBAction func menuButton(_ sender: Any) {
            present(menu! , animated: true)
     
    }
    @IBOutlet weak var secondSECOND: UICollectionView!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var addproduct: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuNavigationController(rootViewController: MenuSlider())
        
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        search.setTitle("", for: .normal)
        menuButton.setTitle("", for: .normal)
        
             let nib = UINib(nibName: "hProductCollectionViewCell", bundle: nil)
             firstCollectionvierw.register(nib, forCellWithReuseIdentifier: "hproductCell")
             firstCollectionvierw.backgroundColor = .white
     
             // Set the data source for the collection view
             firstCollectionvierw.dataSource = self
             firstCollectionvierw.delegate = self
     
             let nib2 = UINib(nibName: "ProductCollectionView", bundle: nil)
             secondSECOND.register(nib2, forCellWithReuseIdentifier: "ProductCell")
             secondSECOND.backgroundColor = .white
             secondSECOND.dataSource = self
             secondSECOND.delegate = self
  
        
    
      
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

}
extension productList: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstCollectionvierw {
            // Return the number of items for hCollectionviews
            return 1
        } else {
            // Return the number of items for collectionView
            return 10
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionview
            cell.layer.cornerRadius = 5
            // Configure the cell for hCollectionviews
           
            return cell
        } else {
            
            // Dequeue and return a cell for collectionView
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hproductCell", for: indexPath) as! hProductCollectionViewCell
            // Configure the cell for collectionView
            cell.backgroundColor = .white
            return cell
        }
    }
}
