import Cocoa

class YDMainViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var file_path_lbl: NSTextField!
    let tableViewData = [
        ["keyColumn":"waiting..","valueColumn":"for file"],
        ["keyColumn":"waiting2..","valueColumn":"for file 2"],
        ["keyColumn":"...","valueColumn":"..."]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }

    override var representedObject: Any? {
        didSet {

        }
    }

    @IBAction func find_file_btn(_ sender: Any) {
        guard let window = view.window else { return }
        
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        
        panel.beginSheetModal(for: window) { (result) in
            print("user selected file")
            
            if let a = panel.url {
                guard let b = YDSelectedFile(file: a) else {
                    self.file_path_lbl.stringValue = "❎ file not allowed"
                    return
                }
                self.file_path_lbl.stringValue = b.fileName
            }
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.title = "🐝 parser 🐝"
    }
}

extension YDMainViewController:NSTableViewDataSource, NSTableViewDelegate{
    
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
