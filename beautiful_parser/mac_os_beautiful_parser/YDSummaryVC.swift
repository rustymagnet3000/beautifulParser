import Cocoa

class YDMainViewController: NSViewController {

    @IBOutlet weak var run_btn_outlet: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var file_path_lbl: NSTextField!
    
    var tableViewData: [[String : String]] = []
    var logFile: YDLogFile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        run_btn_outlet.isHidden = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    @IBAction func run_btn(_ sender: Any) {
        
        // TODO: Add spinner
        let start_time = YD_Time_Helper(raw_date: Date())

        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            if let logs = self.logFile {
                if let a = YDParseFile(logFileUrl: logs.fileURL){
                    self.tableViewData = a.ydEnumerateResults()
                }
            }
            
                // Go back to the main thread to update the UI
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    return
                }
            }
        
        group.leave()

        group.notify(queue: .main) {
            let end_time = YD_Time_Helper(raw_date: Date())
            let total_time = YD_Time_Helper.start_minus_finish_epoch(start_time_epoch: start_time.epoch_time, end_time_epoch: end_time.epoch_time)
            print(total_time)
        }

    }
    
    @IBAction func find_file_btn(_ sender: Any) {
        guard let window = view.window else { return }
        
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        
        panel.beginSheetModal(for: window) { (result) in
            
            if let a = panel.url {
                self.logFile = YDLogFile(logFile: a)
            }
            
            if let b = self.logFile {
                self.file_path_lbl.stringValue = b.fileName
                if self.run_btn_outlet.isHidden {
                    self.run_btn_outlet.isHidden = false
                }
                return
            }
            
            self.file_path_lbl.stringValue = "❎ file not allowed"
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.title = "🐝 Bee Parser 🐝"
        
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
