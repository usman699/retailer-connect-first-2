//
//  purchasereturnViewController.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 24/04/2024.
//



import UIKit



import UIKit
import iOSDropDown
import PDFKit
import SideMenu
import SimplePDF
import PDFGenerator

class purchasereturnViewController:  UIViewController ,UIDocumentInteractionControllerDelegate {
 
    @IBAction func prevpage(_ sender: Any) {
        
        model.prevpage(url:firstpageurl, completion: { result in
            switch result {
                
            case .success(let data ):
                
                self.puchaselist = []
                self.puchaselist =  data.data.returnProducts.data
                self.tableview.reloadData()
           
            case .failure(_):
                print("")
            }
        })
        
    }
   
    @IBAction func nextpage(_ sender: Any) {
        
        model.prevnextpage(url: lastpageurl, completion: { [self] result in
            
            switch result {
                
            case .success(let data ):
                self.puchaselist = []
                self.puchaselist =  data.data.returnProducts.data
                tableview.reloadData()
            case .failure(_):
                print("")
            }
        })
        
        
        
        
    }
    @IBOutlet weak var firstpage: UIButton!
    @IBOutlet weak var lastpage: UIButton!
    
    @IBOutlet weak var backword: UIButton!
    
    @IBOutlet weak var forword: UIButton!
    
    var currentPage = Int()
    var totalPages = Int()
    
  

    
    
    
    
    
    @IBOutlet weak var M1: UIButton!
    
    @IBOutlet weak var M2: UIButton!
    
    
    @IBOutlet weak var emptylabel: UILabel!
    var orderId = Int()
    
    

    
    
    
  //  @IBOutlet weak var heightTableView: NSLayoutConstraint!
    @IBOutlet weak var menubutton: UIButton!
    
    @IBOutlet weak var excelnewthing: UIButton!
    @IBAction func excelbutton(_ sender: Any) {
        
        
        //        let file_name = "my_contacts.csv"
        //        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(file_name)
        //
        //        // Header row
        //        var csvText = "#sr,supplier  Name, purchase date , tax , totall bill, payment status\n"
        //
        //        for (index, contact) in puchaselist.enumerated() {
        //            // Rows
        //            let row = "#\( contact.id), \(contact.supplierName), \(contact.date), \(contact.tax), \(contact.totalBill), \(contact.paymentStatus)  \n"
        //            csvText.append(row)
        //        }
        //
        //        do {
        //            try csvText.write(to: path!, atomically: true, encoding: .utf8)
        //
        //            let exportSheet = UIActivityViewController(activityItems: [path as Any], applicationActivities: nil)
        //            present(exportSheet, animated: true, completion: nil)
        //
        //            print("Export successful")
        //        } catch {
        //            print("Error exporting CSV: \(error.localizedDescription)")
        //        }
        //
//        let file_name = "my_contacts.xlsx" // Change the file extension to .xlsx
//        
//        // Create a new Excel workbook
//        let workbook = ExcelWorkbook()
//        
//        // Add a worksheet to the workbook
//        let worksheet = workbook.addWorksheetNamed("Contacts")
//        
//        // Add headers to the Excel worksheet
//        worksheet.addRow(values: ["#", "Supplier Name", "Purchase Date", "Tax", "Total Bill", "Payment Status"])
//        
//        // Add data rows to the Excel worksheet
//        for (index, contact) in puchaselist.enumerated() {
//            worksheet.addRow(values: [
//                "\(contact.id)",
//                "\(contact.supplierName)",
//                "\(contact.date)",
//                "\(contact.tax)",
//                "\(contact.totalBill)",
//                "\(contact.paymentStatus)"
//            ])
//        }
//        
//        // Save the workbook to a file
//        do {
//            let fileURL = try workbook.writeToXLSX()
//            
//            // Present the share sheet
//            let exportSheet = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
//            present(exportSheet, animated: true, completion: nil)
//            
//            print("Export successful")
//        } catch {
//            print("Error exporting Excel file: \(error.localizedDescription)")
//        }
    }
    
    
    @IBOutlet weak var dots: UIImageView!
    
    
    var buttons:[UIButton] = []
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
    
    @IBOutlet weak var stackview: UIStackView!
    
    @IBOutlet weak var menusmallbutton: UIButton!
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
    @IBAction func searchbutton(_ sender: Any) {
        dateFormatter.dateFormat = "MM-dd-yyyy"
        //
        //        let formattedDate = dateFormatter.string(from: calender.date)
        //        salesViewModel.searchEmployee(start_date:formattedDate,
        //                                      customer:custumerId,
        //                                      payment_status:payment_status ,
        //                                      whenFinish:
        //                                        {
        //            [self]
        //            result in
        //            switch result {
        //            case .success(let res ):
        //
        //                saleList = []
        //                print(saleList.count)
        //                saleList = res.data!.data!
        //                for ar in  saleList
        //                {
        //                    if customerName == ar.customer_name {
        //
        //
        //                    }
        //                }
        //
        //                tableview.reloadData()
        //            case .failure(let error):
        //            print(error)
        //            }
        //        }
        //        )
    }
    
    
    var custumerId = Int()
    @IBOutlet weak var calender: UIDatePicker!
    var customerName:String!
    var date:String!
    var lastpageurl:String!
    var firstpageurl:String!
    var payment_status:String!
    @IBOutlet weak var searchButton: UIButton!
    //   @IBOutlet weak var selectcustomerLable: UILabel!

    @IBOutlet weak var customers: DropDown!
    @IBOutlet weak var selectCustomer: UILabel!
    @IBOutlet weak var bottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var pdf: UIButton!
    var puchaseviewmodel = purchaseviewmodel()
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var tableview: UITableView!
    var checked =  false
    var salesArray = [Datum]()
    
    @IBOutlet weak var paid: DropDown!
    @IBAction func reset(_ sender: Any) {
        
        //        fetchsalesList()
        
    }
    var stringArray = [String]()
    var idArray = [Int]()
    var puchaselist = [dataclass]()
    @IBOutlet weak var filter: UIButton!
    @IBAction func filter(_ sender: Any) {
        checked.toggle()
        if checked {
            filter.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
            searchview.isHidden = true
            search.isHidden = true
            reset.isHidden = true
            bottomConstrains.constant = -320
        } else {
            bottomConstrains.constant = 10
            searchview.isHidden = false
            search.isHidden = false
            reset.isHidden = false
            filter.setImage (UIImage(systemName: "xmark.circle.fill"), for: .normal)
            
        }
    }
    
    @IBAction func paid(_ sender: Any) {
        
    }
    var prevpage =  String()
    var nextpage = String()
    var currentpage =  Int()
    var totalpages = Int()
    var menus: SideMenuNavigationController!
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var buttonstack: UIStackView!
    @objc func loadData() {
        // Make network call to fetch data for currentPage
        currentPage += 1
        refreshControl.endRefreshing()
    }
    @IBOutlet weak var scroollview: UIScrollView!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var search: UIButton!
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var searchview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableview.refreshControl = refreshControl
        
        
        
        
        
        
        forword.setTitle("", for: .normal)
        
        backword.setTitle("", for: .normal)
        M2.setTitle("", for: .normal)
        M1.setTitle("", for: .normal)
        filter.setTitle("", for: .normal)
        filter.setImage(  UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        pdf.setTitle("", for: .normal)
        excelnewthing.setTitle("", for: .normal)
        menus = SideMenuNavigationController(rootViewController: MenuSlider())
        
        
        
        menus.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menus
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        
        
        //   dots.isHidden = true
        
        emptylabel.isHidden = true
        tableview.register(UINib(nibName: "HpurchasereturnTableViewCell", bundle: nil), forCellReuseIdentifier: "hpurchasereturn")
        let secondNib = UINib(nibName: "purchasereturnTableViewCell", bundle: nil)
        tableview.backgroundColor = .white
        tableview.register(secondNib, forCellReuseIdentifier: "purchasereturn")
        tableview.delegate = self
        tableview.dataSource = self
        bottomConstrains.constant = -320
        searchview.isHidden = true
        reset.isHidden = true
        search.isHidden = true
        menu.setTitle("", for: .normal)
        //     filter.setTitle("", for: .normal)
        //    pdf.setTitle("", for: .normal)
        customers.backgroundColor = UIColor(hex: "F5F9FC")
        paid.backgroundColor = UIColor(hex: "F5F9FC")
        Global.shared.configuredDropDown(dropDown: paid, array: ["Paid", "UnPaid", "Partial"]) { selectedText in
            // Handle the selected text from the 'paid' dropdown
            self.payment_status = selectedText
            
            
            
        }
        
        
        //     updateTableViewHeight()
        //    fetchCusomters()
        fetchpurchaseList()
        
        
        
        
    }
    func updatenodata(){
        
        
        
    }
    //  @IBOutlet weak var heightconstraints: NSLayoutConstraint!
    //    func updateTableViewHeight() {
    //        tableview.reloadData()
    //        tableview.layoutIfNeeded()
    //
    //        let contentHeight = tableview.contentSize.height
    //        let maximumAllowedHeight = view.bounds.height * 0.6 // 60% of available height
    //        let fixedHeight = CGFloat(400) // Set your desired fixed height here
    //
    //        if contentHeight <= maximumAllowedHeight {
    //            // If content height is within 60% of available height, allow dynamic height
    //            tableview.isScrollEnabled = true
    //            heightconstraints.constant = contentHeight + 130
    //        } else {
    //            // If content height exceeds 60% of available height, set fixed height with scrolling
    //            tableview.isScrollEnabled = true
    //            heightconstraints.constant = fixedHeight  + 130
    //        }
    //    }
    func fetchCusomters(){
        //        salesViewModel.employeFetching(whenFinish: { [self]result in
        //            switch result {
        //            case .success(let data ):
        //
        //
        //
        //                for dat in data.data!{
        //
        //                    self.salesArray.append(dat)
        //
        //                    self.stringArray.append(dat.name)
        //                    self.idArray.append(dat.id)
        //                    Global.shared.configuredDropDownwithid(dropDown: customers, array: stringArray, ids: idArray ) { selectedText, id  in
        //
        //                        self.customerName = selectedText
        //                        self.custumerId = id
        //                        for ar in  stringArray
        //                        {
        //                            if customerName == ar{
        //
        //
        //                            }
        //                        }
        //                        // Handle the selected text from the 'paid' dropdown
        //
        //                    }
        //                }
        //            case .failure(let error):
        //                print("errror",error)
        //            }
        //        }
        //        )
        //    }
        
        
        
    }
    
    func fetchpurchaseList(){
   
        
        
        
        puchaseviewmodel.purchasereturn(completion: {
            
            
            [self]result in
            
            switch result {
                
            case .success(let res ):
                
                puchaselist = res.data.returnProducts.data
               
                
                
                
                totalpages = res.totalPages
                currentpage = res.data.returnProducts.currentPage
                firstpage.setTitle( String(currentpage), for:.normal)
                lastpage.setTitle( String(totalpages), for:.normal)
                
                firstpageurl = res.data.returnProducts.firstPageURL
                lastpageurl = res.data.returnProducts.lastPageURL
                prevpage = res.data.returnProducts.prevPageURL ?? ""
                nextpage = res.data.returnProducts.nextPageURL ?? ""
                //                        if let data = res.data?.data{
                //                         //   mainview.isHidden = false
                //                            emptylabel.isHidden = true
                //                            buttonstack.isHidden = false
                //                            saleList = res.data!.data!
                //                            // Access data properties safely
                //                        } else {
                //                        //    mainview.isHidden = true
                //                            emptylabel.isHidden = false
                //                            buttonstack.isHidden = true
                //                            saleList = []
                //                            // Handle case where data is nil (empty or missing)
                //                        }
                //
                //    print("count",saleList.count)
                tableview.reloadData()
                
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
    func createPDF() {
      
   
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want t do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
extension  purchasereturnViewController:  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        // Create a table view cell for the header
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "hpurchasereturn") as!
        HpurchasereturnTableViewCell
        // Customize the header cell as needed
        
        // Add the header cell to the header view
        headerView.addSubview(headerCell)
        
        // You might need to adjust the frame of the header cell within the header view
        headerCell.frame = CGRect(x: 0, y: -20, width: tableView.bounds.width, height: 60)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == puchaselist.count - 1, currentPage < totalPages {
            loadData()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:purchasereturnTableViewCell
   
            
            cell = tableView.dequeueReusableCell(withIdentifier: "purchasereturn", for: indexPath) as!  purchasereturnTableViewCell
            
            if indexPath.row % 2  == 0  {
                cell.colorset(color1: UIColor(hex: 0xF5F9FC))
            } else {
                cell.colorset(color1: .white)
            }
            
                        let currentCustomer =  puchaselist[indexPath.row]
                       
                        cell.date.text = currentCustomer.date
      //  cell.discount.text = String(currentCustomer.)
        cell.supliername.text = currentCustomer.suplierName
                       cell.index.text = String(indexPath.row + 1)
        cell.date.text  = String(currentCustomer.date)
                        cell.tax.text = String(currentCustomer.tax)
        cell.paymentstatusa.text =       currentCustomer.paymentStatus
        cell.discount.text = String(currentCustomer.discount)
        let url = URL(string: currentCustomer.image)!

        // Use Kingfisher to load the image from the URL into the imageView
        cell.images.kf.setImage(with: url)
       
        cell.total.text = String(currentCustomer.total)
        cell.tax.text = String(currentCustomer.tax)
        cell.productname.text = currentCustomer.name
        cell.quantity.text = String( currentCustomer.quantity)
        cell.price.text = String(currentCustomer.price)
        cell.code.text =  String(currentCustomer.code)
                        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
             
        return  puchaselist.count
                
            }
        
    }
    
    
    
    
    
    
    
    


