
import UIKit



import UIKit
import iOSDropDown
import PDFKit
import SideMenu
import SimplePDF
import PDFGenerator

class viewexpensecategoires:  UIViewController ,UIDocumentInteractionControllerDelegate , editCategory, submitcategory, deleteCategory {
    func deletecategory(selected: viewcategoriesdata) {
        
    }
    
    func submit(name: String, descriptions: String, id: Int) {
        model.addcategories(name: name, description: descriptions, id:id) { result  in
            switch result {
            case .success(let success):
                print("success")
                self.fetchpurchaseList()
                self.tableview.reloadData()
                self.dismiss(animated: true)
            case .failure(let error):
                print("success")
            }
        }
    }
    
    func editcategory(selected: viewcategoriesdata) {
        let storyboard = UIStoryboard(name: "UPDATE", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "categoryalert") as! Categoryalert
        initialViewController.delegate  = self
        initialViewController.id = selected.id
        initialViewController.CustomerName = selected.name
        initialViewController.descriptionL = selected.description
        present(initialViewController, animated: false)
       
    }
    
   
    

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
    
    @IBAction func button(_ sender: Any) {
        present(menus!, animated: true)
    }
    //  @IBOutlet weak var hieghttableview: NSLayoutConstraint!
   
    
    var ttotalpage = [Int]()
    var custumerId = Int()

    var customerName:String!
    var date:String!
    var payment_status:String!
   @IBOutlet weak var pdf: UIButton!
    @IBOutlet weak var tableview: UITableView!
    var checked =  false
    var salesArray = [Datum]()
 
  
    
   // @IBOutlet weak var nextpages: UIButton!
  
    var prevpage =  String()
    var nextpage = String()
    var currentpage = 1
    var perpage = Int()
    var totalpages = Int()
    var stringArray = [String]()
    var idArray = [Int]()
    var filterData = [viewcategoriesdata]()
    var reportdata = [viewcategoriesdata]()
    var menus: SideMenuNavigationController!
    var model = productviewmodel()
  
    @IBOutlet weak var searchbar: UISearchBar!
    var salesViewModel = salesViewmodel()

var settingmodel  = settingsviewmodel()
 
    @IBAction func excelexport(_ sender: Any) {
        settingmodel.exportexcel(type: "export-category",  completion: {
            
            [self]result in
            
            switch result {
                
            case .success(let res ):
                
                Global.shared.saveFile(data: res, fileName: "expencecategory.xlsx", presenter: self)
            case .failure(let error):
                
                
                print("error", error)
                
                
                print("erorrs" .errorDescription)
            }
        })
    }
    
    var from = Int()
    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        // Register custom cell
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
        collectionview.reloadData()

        menubutton.setTitle("", for: .normal)
                pdf.setTitle("", for: .normal)
                excelnewthing.setTitle("", for: .normal)
                menus = SideMenuNavigationController(rootViewController: MenuSlider())
                menus.leftSide = true
                SideMenuManager.default.leftMenuNavigationController = menus
                SideMenuManager.default.addPanGestureToPresent(toView: self.view)
   
                tableview.register(UINib(nibName: "hmanageCategoirs", bundle: nil), forCellReuseIdentifier: "hmanageCategories")
                let secondNib = UINib(nibName: "managecat", bundle: nil)
                tableview.backgroundColor = .white
                tableview.register(secondNib, forCellReuseIdentifier: "manageCat")
                tableview.delegate = self
                tableview.dataSource = self
         
        
           //  fetchDatawithpage(page: currentpage)
                fetchpurchaseList()
    }
    
    func updatePaginationButtons() {
        
//        previouspage.isEnabled = currentpage < totalpages
//        goingnextpage.isEnabled = currentpage > 1
    }

    func fetchpurchaseList(){
      
        model.productviewcategories( completion: {
            
            [self]result in
            
            switch result {
                
            case .success(let res ):
             
                reportdata = res.data
                filterData  = reportdata
           
               tableview.reloadData()
                collectionview.reloadData()
            case .failure(let error):
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
                
                print("erorrs" .errorDescription)
            }
        })
    }
        
    }


    
  
extension viewexpensecategoires: UISearchBarDelegate{
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
       filterData = []
        if searchText == ""
        {
            searchbar.perform(#selector(self.resignFirstResponder), with: nil, afterDelay: 0.1)
            filterData = reportdata
        }
        for word in reportdata{
            if word.name.uppercased().contains(searchText.uppercased()){
                filterData.append(word)
            }
            
        }
      self.tableview.reloadData()
    }
}

extension viewexpensecategoires: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalpages
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pagecollection", for: indexPath) as! pagecollectionviewcell
        
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

extension  viewexpensecategoires:  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hmanageCategories") as!  hmanageCategoirs
        
        // Customize the header cell as needed
        
        // Add the header cell to the header view
        headerView.addSubview(headerCell)
        
        // You might need to adjust the frame of the header cell within the header view
        headerCell.frame = CGRect(x: 0, y: -10, width: tableView.bounds.width, height: 50)
        
        return headerView
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    80
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:managecat
        
        
        cell = tableView.dequeueReusableCell(withIdentifier: "manageCat", for: indexPath) as!   managecat
        print("current", indexPath.item , (currentpage - 1) * perpage)
        let adjustedIndex = indexPath.item + 1  + (currentpage - 1) * perpage
        
        let currentCustomer =  filterData[indexPath.row]
        if currentCustomer.status == "active"{
            cell.switches.isOn = true
        }
        else{
            cell.switches.isOn = false
        }
        cell.name.text = currentCustomer.name
        cell.descriptions.text = currentCustomer.description
        cell.index.text = String(indexPath.row)
        cell.type.text  = "Expenses"
        cell.editcategory = self
        cell.deletecategory = self
        cell.configure(with: currentCustomer)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return filterData.count
     
    }
}

