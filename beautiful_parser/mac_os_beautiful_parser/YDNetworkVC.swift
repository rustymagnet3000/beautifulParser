import Cocoa

class YDNetworkVC: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!

    var tableViewData: [[String : String]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        do{
            guard let logFile = YDPersistSettings.selectedFile() else {
                throw YDError.LogFileFailed
            }
            
            guard let b = YDParseAndCount(logFileUrl: logFile.fileURL, searchStr: searchString) else{
                throw YDError.ParseFailed
            }
            
            tableViewData = b.returnAllRecords()
            self.tableView.reloadData()
        }
        catch{
            tableViewData = [["keyColumn":"select", "valueColumn":"log file"]]
            self.tableView.reloadData()
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    

}


extension YDNetworkVC:NSTableViewDataSource, NSTableViewDelegate{
    
    fileprivate enum CellIdentifiers {
        static let keyCell = "keyColumn"
        static let valueCell = "valueColumn"
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var cellIdentifier: String = ""
        
        if tableColumn == tableView.tableColumns[0] {
            cellIdentifier = CellIdentifiers.keyCell
        } else if tableColumn == tableView.tableColumns[1] {
            cellIdentifier = CellIdentifiers.valueCell
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = tableViewData[row][cellIdentifier] ?? "bug"
            return cell
        }
        return nil
    }
}
