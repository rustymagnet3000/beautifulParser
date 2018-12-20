import Cocoa

class YDNetworkVC: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!

    var tableViewData: [[String : String]] = [["keyColumn":"whoop", "valueColumn":"whoop."]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let log = "Coding/beautifulParser/beautiful_parser/not_on_repo/logs.txt"
        let home = FileManager.default.homeDirectoryForCurrentUser
        let file = home.appendingPathComponent(log)
        guard let logFile = YDSelectedFile(file: file) else {
            return
        }
        if let results = YDParseAndCount(logFileUrl: logFile.fileURL){
            results.returnAllRecords()
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
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
