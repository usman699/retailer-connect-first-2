import Foundation
import UIKit
import iOSDropDown
import PDFKit
import SideMenu
import SimplePDF
import PDFGenerator

class viewexpnse:  UIViewController ,UIDocumentInteractionControllerDelegate, pagebutton, updateexpence, deleteexpence {
    func deleteCusomer(selected: orignalexpense) {
        expensemodel.changeexpense(id: selected.id, completion: {result  in
            switch result{
                
            case .success(let succcess):
                self.viewexpenselist()
                
            case .failure(let error):
                print("error")
            }
            
        })
    }
    
    func updateExpense(selected: orignalexpense) {
        
        let storyboard = UIStoryboard(name: "expence", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "updateexpence") as! Updateexpence
        initialViewController.id = selected.id
        initialViewController.amountL = String(selected.amount)
        initialViewController.dateL = selected.createdAt
        initialViewController.descriptionL = selected.description ?? ""
        initialViewController.bankL =  selected.bankID!
        initialViewController.categoryL =  selected.categoryID
        initialViewController.paymenttypeL =  selected.paymentTypeID
        initialViewController.trasactionL =  selected.transactionType
        initialViewController.checknoL =   selected.checkNumber!
        initialViewController.nameL =   selected.name
        present(initialViewController, animated: false)
    }
    
    func pageaction(currentindex:Int) {
        
        fetchDatawithpage(page: currentindex)
    }
    var settingmodel = settingsviewmodel()
    @IBOutlet weak var menubutton: UIButton!
    
    @IBOutlet weak var excelnewthing: UIButton!
    
    @IBAction func pdfaction(_ sender: Any) {
        //        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 612, height: 792))
        //        let filePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("TableViewPDFss.pdf")
        //
        //        do {
        //            try pdfRenderer.writePDF(to: filePath, withActions: { context in
        //                let pageCount = self.tableview.numberOfRows(inSection: 0)
        //                var currentPage = 0
        //                var currentY: CGFloat = 20
        //
        //                while currentPage < pageCount {
        //                    let currentPageRect = CGRect(x: 20, y: currentY, width: 572, height: 40)
        //                    context.beginPage()
        //                    for row in 0..<min(10, pageCount - currentPage) {
        //                        let indexPath = IndexPath(row: currentPage + row, section: 0)
        //                        let cell = self.tableview.cellForRow(at: indexPath)!
        //                        cell.textLabel?.draw(currentPageRect)
        //                        currentY += 40
        //                    }
        //                    currentPage += 10
        //                }
        //            })
        //
        //            print("PDF Generated: \(filePath.absoluteString)")
        //        } catch {
        //            print("Error generating PDF: \(error.localizedDescription)")
        //        }
        //
        
        
        //        let pdf = SimplePDF(pageSize: CGSize(width: 400, height: 400))
        //
        //                // Add a page to the PDF
        //        pdf.addTable(5, columnCount: 5, rowHeight: 100, columnWidth: 50, tableLineWidth: 500, font: .systemFont(ofSize: 12), dataArray: )
        //
        //                // Set font and text size for the content
        //
        //
        //                // Add content to the PDF
        //                for row in 0..<tableview.numberOfRows(inSection: 0) {
        //                    let indexPath = IndexPath(row: row, section: 0)
        //                    if let cell = tableview.cellForRow(at: indexPath), let text = cell.textLabel?.text {
        //                        pdf.addText(text)
        //                    }
        //                }
        //
        //                // Save the PDF
        //                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //                let pdfPath = documentsDirectory.appendingPathComponent("TableViewPDF.pdf")
        //
        //                do {
        //                    try pdf.write(to: pdfPath)
        //                    print("PDF Generated: \(pdfPath)")
        //                } catch {
        //                    print("Error generating PDF: \(error.localizedDescription)")
        //                }
        
        //        pdf.addText("Hello World!")
        //        // or
        //        // pdf.addText("Hello World!", font: myFont, textColor: myTextColor)
        //
        //      //  pdf.addImage( anImage )
        //
        //        let dataArray = [["Test1", "Test2"],["Test3", "Test4"]]
        //        pdf.addTable(2, columnCount: 2, rowHeight: 20.0, columnWidth: 30.0, tableLineWidth: 1.0, font: UIFont.systemFont(ofSize: 5.0), dataArray: dataArray)
        //
        //        let pdfData = pdf.generatePDFdata()
        //
        //        // save as a local file
        //        try? pdfData.writeToFile(path, options: .DataWritingAtomic)
        
        //    createPDF()
        //        let pdf_file = UIDocumentInteractionController(url: URL(fileURLWithPath: Global.shared.pdfDataWithTableView(tableView: self.tableview, view: self.view)))
        //        pdf_file.delegate = self
        //
        //        pdf_file.presentPreview(animated: true)
        //
        
        
        
        
        
        
        //    exportAsPdfFromTable()
        
    }
    @IBAction func exportexcel(_ sender: Any) {
        settingmodel.exportexcel(type: "export-expense",  completion: {
            
            [self]result in
            
            switch result {
                
            case .success(let res ):
                
                Global.shared.saveFile(data: res, fileName: "expence.xlsx", presenter: self)
            case .failure(let error):
                
                
                print("error", error)
                
                
                print("erorrs" .errorDescription)
            }
        })
        
    }
    
    func exportAsPdfFromTable() -> String {
        let originalBounds = self.tableview.bounds
        self.tableview.bounds = CGRect(x:originalBounds.origin.x, y: originalBounds.origin.y, width: self.tableview.contentSize.width, height: self.tableview.contentSize.height)
        let pdfPageFrame = CGRect(x: 0, y: 0, width: self.tableview.bounds.size.width, height: self.tableview.contentSize.height)
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return "" }
        self.tableview.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        self.tableview.bounds = originalBounds
        // Save pdf data
        return self .saveTablePdf(data: pdfData)
        
    }
    func saveTablePdf(data: NSMutableData) -> String {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = paths[0]
        let pdfPath = docDirectoryPath.appendingPathComponent("tablePdf.pdf")
        if data.write(to: pdfPath, atomically: true) {
            return pdfPath.path
        } else {
            return ""
        }
    }
    func renderAsImage() -> UIImage? {
        // Calculate the visible rect in the coordinate space of the table view
        let visibleRect = CGRect(origin: tableview.contentOffset, size: tableview.bounds.size)
        
        // Initialize a graphics context with the size of the visible rect
        UIGraphicsBeginImageContextWithOptions(visibleRect.size, false, UIScreen.main.scale)
        
        // Get the current graphics context
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // Translate the graphics context so that the visible rect origin becomes the origin of the context
        context.translateBy(x: -visibleRect.origin.x, y: -visibleRect.origin.y)
        
        // Iterate through all visible cells
        for cell in self.tableview.visibleCells {
            // Only render cells that intersect with the visible rect
            if cell.frame.intersects(visibleRect) {
                // Convert cell frame to the coordinate system of the table view
                var cellFrame = cell.frame
                cellFrame.origin.y += tableview.contentOffset.y
                // Render the cell into the graphics context
                cell.layer.render(in: context)
            }
        }
        
        // Get the combined image from the graphics context
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // End the graphics context
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    @IBAction func menuButtonss(_ sender: Any) {
        
        present(menus!, animated: true)
    }
    
    let dateFormatter = DateFormatter()
    var fromDate = String()
    var todate = String()
    var ttotalpage = [Int]()
    @IBOutlet weak var to: UIDatePicker!
    var suppliersId = Int()
    @IBOutlet weak var from: UIDatePicker!
    @objc func fromDateChanged(_ sender: UIDatePicker) {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           let formdate = dateFormatter.string(from: sender.date)
           fromDate = formdate
       }

    @IBAction func reset(_ sender: Any) {
                fromDate = ""
                todate = ""
                 singletrasaction = ""
                 paymenttype.selectedIndex = nil
                paymenttype.text = nil
                trasactiontype.selectedIndex = nil
                trasactiontype.text = nil
        viewexpenselist()
    }
    @IBAction func searchbuttonaction(_ sender: Any) {
            expensemodel.searchexpense(startdate: fromDate, enddate: todate, paymentid: singlepaymentid ?? "", trasactiontype: singletrasaction, completion: { result in
            switch result {
            case .success(let success):
                self.expencearray = success.data.data
                self.tableview.reloadData()
            case .failure(let error):
                switch error {
                case .decodingError:
                    print("")
                case .notFound:
                    Global.shared.showMsg(msg: "", title: "not found")
                case .conflict:
                    print("")
                case .unknownError:
                    print("")
                case .unresponseEntity:
                    print("")
                case .outofstack:
                    print("")
                }
            }
        })
    
        
   

    }
    var suppliersName:String!
    var date:String!
    var payment_status:String!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var selectcustomerLable: UILabel!
    @IBOutlet weak var trasactiontype: DropDown!
    @IBOutlet weak var paymenttype: DropDown!
    var paymenttypearray = [orignalpayement]()
    
   
    @IBOutlet weak var selectCustomer: UILabel!
    @IBOutlet weak var bottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var pdf: UIButton!
    
    @IBOutlet weak var tableview: UITableView!
    var checked =  false
    var expencearray = [orignalexpense]()
//    @IBAction func reset(_ sender: Any) {
//        
//        paymenttype.selectedIndex = nil
//        paymenttype.text = nil
//        trasactiontype.selectedIndex = nil
//        trasactiontype.text = nil
//        
//        
//    }
    @IBAction func previouspage(_ sender: Any) {
        print("clicked")
        if currentpage > 1 {
            currentpage -= 1
            fetchDatawithpage(page: currentpage)
        }
    }
    @IBAction func goingtonextpage(_ sender: Any) {
        print("clicked")
        if currentpage < totalpages{
            currentpage += 1
            fetchDatawithpage(page: currentpage)
        }
    }
    @IBOutlet weak var previouspage: UIButton!
    
    // @IBOutlet weak var nextpages: UIButton!
    
    var prevpage =  String()
    var nextpage = String()
    var currentpage = 1
    var perpage = Int()
    var totalpages = Int()
    var catrystringArray = [String]()
    var stringArray = [String]()
    var idArray = [Int]()
    var categoryName = String()
    var categoryid = Int()
    var paymenttypeString = [String]()
    var paymenttypeid = [Int]()
    @IBOutlet weak var filter: UIButton!
    @IBAction func filter(_ sender: Any) {
        checked.toggle()
        if checked {
            filter.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
            searchview.isHidden = true
            search.isHidden = true
            reset.isHidden = true
            bottomConstrains.constant =  -330
        } else {
            bottomConstrains.constant = 10
            searchview.isHidden = false
            search.isHidden = false
            reset.isHidden = false
            filter.setImage (UIImage(systemName: "xmark.circle.fill"), for: .normal)
            
        }
    }
    var singletrasaction = String()
    //   @IBOutlet weak var goingnextpage: UIButton!
    var trasactiontypearray = [String]()
    var menus: SideMenuNavigationController!
    var expensemodel = expenseviewmodel()
    @IBOutlet weak var buttonstack: UIStackView!
    var singlepaymentid: String? // Initialize to nil
    @IBOutlet weak var scroollview: UIScrollView!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var search: UIButton!
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var searchview: UIView!
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("clicked")
        if currentpage < totalpages{
            currentpage += 1
            fetchDatawithpage(page: currentpage)
        }
        
        
        print("clicked")
        // Your action
    }
    
    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupui()
        fetchpayment()
        fetchtrasaction()
        viewexpenselist()
    }
    func setupui(){
        todate = ""
        fromDate = ""
        trasactiontype.selectedIndex = nil
        trasactiontype.text = nil
        paymenttype.selectedIndex = nil
        paymenttype.text = nil
        let nib = UINib(nibName: "pagecollectionviewcell", bundle: nil)
        collectionview.register(nib, forCellWithReuseIdentifier: "pagecollection")
        // Configure collection view layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 4, right: 4)
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.scrollDirection = .horizontal            // Apply layout to collection view
        collectionview.collectionViewLayout = layout
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.backgroundColor = .clear
        // Reload data if needed
        collectionview.reloadData()
        filter.setTitle("", for: .normal)
        filter.setImage(  UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        pdf.setTitle("", for: .normal)
        excelnewthing.setTitle("", for: .normal)
        menus = SideMenuNavigationController(rootViewController: MenuSlider())
        menus.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menus
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        tableview.register(UINib(nibName: "Hviewexpence", bundle: nil), forCellReuseIdentifier: "Hviewexpence")
        let secondNib = UINib(nibName: "viewexpence", bundle: nil)
        tableview.backgroundColor = .white
        tableview.register(secondNib, forCellReuseIdentifier: "viewexpence")
        tableview.delegate = self
        tableview.dataSource = self
        bottomConstrains.constant = -330
        searchview.isHidden = true
        reset.isHidden = true
        search.isHidden = true
        menu.setTitle("", for: .normal)
        paymenttype.backgroundColor = UIColor(hex: "F5F9FC")
        trasactiontype.backgroundColor = UIColor(hex: "F5F9FC")
        trasactiontype.selectedIndex = nil
        trasactiontype.text = nil
        paymenttype.selectedIndex = nil
        paymenttype.text = nil
        from.addTarget(self, action: #selector(fromDateChanged(_:)), for: .valueChanged)
        to.addTarget(self, action: #selector(toDateChanged(_:)), for: .valueChanged)
          
    }
    
    @objc func toDateChanged(_ sender: UIDatePicker) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let todate = dateFormatter.string(from: sender.date)
        self.todate = todate
        }
    var suppliers = purchaseviewmodel()
    func   fetchpayment(){
        expensemodel.fetchpayment(completion: { [self]result in
                switch result {
                case .success(let data ):
                    paymenttypearray = data.data.data
                    for i in paymenttypearray{
                        paymenttypeString.append(i.name)
                        paymenttypeid.append(i.id)
                    }
                        Global.shared.configuredDropDownwithid(dropDown: paymenttype, array: paymenttypeString, ids: paymenttypeid ) { selectedText, id  in
                            
                        singlepaymentid =  String(id)
                        }
                case .failure(let error):
                    print("errror",error)
                }
            }
            
            )
      }
    func   fetchtrasaction(){
        expensemodel.fetchtrasactiontype(completion: { [self]result in
                switch result {
                case .success(let data ):
                   
                    trasactiontypearray = data
                   
       
                    Global.shared.configuredDropDown(dropDown: trasactiontype, array: trasactiontypearray  ){ selectedtext in
                            
                            singletrasaction = selectedtext
                            
                        }
                        
                    
                case .failure(let error):
                    print("errror",error)
                }
            }
            
            )
      }
    
    
    func viewexpenselist(){
        
        expensemodel.fetchviewexpense(completion: {result  in
                switch result{
                case .success(let succcess):
                self.expencearray = succcess.data.data
                self.totalpages = succcess.totalPages
                self.currentpage = succcess.data.currentPage
                print("total page",self.totalpages)
                self.tableview.reloadData()
                self.collectionview.reloadData()
                case .failure(let error):
                print("error")
            }
            
        })
        
    }
    func fetchDatawithpage(page:Int){
        expensemodel.fetchviewexpensewithpage(page: page, completion: {result  in
            switch result{
                
            case .success(let succcess):
                self.expencearray = succcess.data.data
                self.totalpages = succcess.totalPages
          
                print(self.totalpages)
                self.tableview.reloadData()
                self.collectionview.reloadData()
            case .failure(let error):
                print("error")
            }
            
        })
        
    }
    
}


    
  

extension  viewexpnse: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(totalpages)
        return totalpages
    }
   

  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pagecollection", for: indexPath) as! pagecollectionviewcell
        cell.delegate = self
        cell.index = indexPath.row + 1
        
        // Check if the cell is selected
        if cell.isSelected {
            print("seelted in clel")
            // Cell is selected, set button color to yellow
            cell.uibutton.tintColor = .yellow
        } else {
            // Cell is not selected, set button color to gray
            cell.uibutton.tintColor = .gray
        }
        
        cell.uibutton.setTitle("\(indexPath.row + 1)", for: .normal)
        cell.uibutton.setTitleColor(.white, for: .normal)
        cell.uibutton.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        
        return cell
    }
}

extension  viewexpnse:  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = .lightGray

        let headerCell = tableView.dequeueReusableCell(withIdentifier: "Hviewexpence") as!
        Hviewexpencecell
        
//        tableview.register(UINib(nibName: "viewexpenceTableViewCell", bundle: nil), forCellReuseIdentifier: "Hviewexpence")
//        let secondNib = UINib(nibName: "viewexpenceTableViewCell", bundle: nil)
//        tableview.backgroundColor = .white
//        tableview.register(secondNib, forCellReuseIdentifier: "viewexpence")
        
        
        // Customize the header cell as needed
        
        // Add the header cell to the header view
        headerView.addSubview(headerCell)
        
        // You might need to adjust the frame of the header cell within the header view
        headerCell.frame = CGRect(x: 0, y: -20, width: tableView.bounds.width, height: 60)
        
        return headerView
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:viewexpencecell
        cell = tableView.dequeueReusableCell(withIdentifier: "viewexpence", for: indexPath) as!   viewexpencecell
      
        
        
        
        
        let adjustedIndex = indexPath.item + 1  + (currentpage - 1) * perpage
        let currentCustomer =  expencearray[indexPath.row]
        cell.editt = self
        cell.deleted = self
        cell.amount.text = String(currentCustomer.amount)
        cell.bacnk.text = currentCustomer.bankInfo?.name
        cell.acounttitle.text = currentCustomer.bankInfo?.accountTitle
        cell.date.text = String( currentCustomer.createdAt)
        cell.category.text = String(currentCustomer.categoryInfo.name)
        cell.index.text =  String(adjustedIndex)
        cell.trasactiontype.text = String(currentCustomer.transactionType)
        cell.paymenttype.text = String(currentCustomer.transactionType)
        cell.bacnk.text = currentCustomer.bankInfo?.name
        cell.configure(with: currentCustomer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return expencearray.count

    }
    
}
