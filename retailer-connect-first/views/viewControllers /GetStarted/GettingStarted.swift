//
//  HomeViewController.swift
//  retailer-connect-first
//
//  Created by Spark on 02/11/2023.
//

import UIKit

class HomeViewController: UIViewController {
    var timer: Timer?
    
    var array = [Slidermodel]()
    var collectionViewBottomConstraint: NSLayoutConstraint!
    var collectionView: UICollectionView!
    var collectionView2: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       buttonGetstarted.setTitle("Geting started", for: .normal)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonGetstartedTapped))
           buttonGetstarted.addGestureRecognizer(tapGesture)
        view.addSubview(imageIcon)
        inits()
        applyConstaints()
        let arrays =  [Slidermodel(label1: "Lets To" , label2: "Retailer", label3: "Connect",paragraph: "In this modified code, the collectionView is constrained to the bottom of the pageControl with a margin of -20 points (to give space between the collection view and the page control)"),
                      Slidermodel(label1: "Lets To" , label2: "Retailer", label3: "Connect",paragraph: "In this modified code, the collectionView is constrained to the bottom of the pageControl with a margin of -20 points (to give space between the collection view and the page control)"),
                      Slidermodel(label1: "Lets To" , label2: "Retailer", label3: "Connect",paragraph: "In this modified code, the collectionView is constrained to the bottom of the pageControl with a margin of -20 points (to give space between the collection view and the page control)"),
                      Slidermodel(label1: "Lets To" , label2: "Retailer", label3: "Connect",paragraph: "In this modified code, the collectionView is constrained to the bottom of the pageControl with a margin of -20 points (to give space between the collection view and the page control)")
        
        
        ]
        array = arrays
     //   startAutoScroll()
        
        // Do any additional setup after loading the view.
    }
    @objc func buttonGetstartedTapped() {
        let nextViewController = ChoosingController() // Replace with your next view controller class
        navigationController?.pushViewController(nextViewController, animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
     //   PageControl.frame = CGRect(x: view.frame.origin.x, y:   view.frame.size.height - 20, width: 200, height: 20)
     //   PageControl.frame = CGRect(x: 0, y: 0, width: 200, height:30)
    }
    let pageControl: CustomPageControl = {
        let pageControl = CustomPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 4 // Set the total number of pages based on your collection view content
       
        pageControl.currentPage = 0 // Set the initial current page
        
        return pageControl
    }()
    func startAutoScroll() {
          timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
      }

  
    @objc func autoScroll() {
           let totalItems = array.count
           var nextIndex = (pageControl.currentPage + 1) % totalItems
           let indexPath = IndexPath(item: nextIndex, section: 0)
           
           UIView.animate(withDuration: 0.5) {
               self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
           }
           
           pageControl.currentPage = nextIndex
           
           // Reset to the first item if reached the end
           if nextIndex == 0 {
               let firstIndexPath = IndexPath(item: 0, section: 0)
               UIView.animate(withDuration: 0.5) {
                   self.collectionView.scrollToItem(at: firstIndexPath, at: .centeredHorizontally, animated: false)
               }
               pageControl.currentPage = 0
           }
       }
    deinit{
        timer?.invalidate()
    }


   
    func inits(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.bounds.width, height: 290)
        collectionView = UICollectionView(frame: CGRect(x: 0 , y: 0 ,width: view.bounds.width, height: 290), collectionViewLayout: layout)
        collectionView.center = view.center
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GettingCollectionViewCell.self, forCellWithReuseIdentifier: GettingCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
      
        view.addSubview(collectionView)
        view.backgroundColor = .white
        view.addSubview(buttonGetstarted)
        view.addSubview(pageControl)
    }
  func  applyConstaints(){
      if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
          // Compact width (iPhone in portrait mode)
          // Adjust constraints for smaller iPhones
          imageIcon.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
          imageIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          imageIcon.widthAnchor.constraint(equalToConstant: 100).isActive = true
          imageIcon.heightAnchor.constraint(equalToConstant: 100).isActive = true
          
          collectionViewBottomConstraint = collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: 150)
          
          
          
          
      } else {
          // Regular width (iPhone in landscape mode or larger devices)
          // Default constraints for other devices
          imageIcon.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
          imageIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          imageIcon.widthAnchor.constraint(equalToConstant: 150).isActive = true
          imageIcon.heightAnchor.constraint(equalToConstant: 150).isActive = true
          collectionViewBottomConstraint = collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: 350)
      }
     
          // Activate the constraint
          collectionViewBottomConstraint.isActive = true
      NSLayoutConstraint.activate([

        buttonGetstarted.bottomAnchor.constraint(equalTo: view.bottomAnchor ,constant: -80),
        buttonGetstarted.widthAnchor.constraint(equalToConstant: view.bounds.width),
        buttonGetstarted.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40),
        buttonGetstarted.heightAnchor.constraint(equalToConstant: 50),
        buttonGetstarted.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: 150),
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
       // collectionView.heightAnchor.constraint(equalToConstant: 250),

                // Page Control constraints
        pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
        pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor ,constant: -40),
//        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//               pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      ])
    }
  
   
    var imageIcon:UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image?.withRenderingMode(.alwaysOriginal)
        image.image = UIImage(named: "logo-iocn 1")
      //  image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return image
    }()
  
    let buttonGetstarted:UIButton = {
        var button = UIButton()
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get Started", for: .normal)
        
        button.backgroundColor = .orange
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let width = collectionView.frame.width
            let currentPage = Int((scrollView.contentOffset.x + width / 2) / width)
            pageControl.currentPage = currentPage
        }

}
extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GettingCollectionViewCell.reuseIdentifier, for: indexPath) as? GettingCollectionViewCell
        let sliderModel = array[indexPath.row]
        cell?.config(sliderModel: array[indexPath.row], indexPath: indexPath)
        return cell!
    }
    
    
}

