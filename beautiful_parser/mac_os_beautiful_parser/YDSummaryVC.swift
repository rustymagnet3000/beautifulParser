import Cocoa

class YDSummaryController: NSViewController {

    @IBOutlet weak var run_btn_outlet: NSButton!
    @IBOutlet weak var file_btn_outlet: NSButton!
    
    @IBOutlet weak var time_lbl: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var file_path_lbl: NSTextField!
    
    var tableViewData: [[String : String]] = []
    var logFile: YDLogFile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        run_btn_outlet.YDButtonStyle()
        file_btn_outlet.YDButtonStyle()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
        logFile = YDPersistSettings.selectedFile()
        
        if logFile != nil {
                    file_path_lbl.stringValue = logFile!.fileName
                    run_btn_outlet.isHidden = false
        }
        else {
                run_btn_outlet.isHidden = true
        }
    }
    
    @IBAction func run_btn(_ sender: Any) {
        let start_time = YD_Time_Helper(raw_date: Date())
        tableViewData = []                  // Needed to be cleaned after each button click
        let multipleTabs: [YDTabsModel]
        let summaryPage: [YDSummaryModel]
        
        let tabvc = YDtabvc(nibName: YDNibIdentifier.ydtabvc, bundle: nil)
        
        do {
            var data = try Data(contentsOf: YDTabsStub.searchTabsURL)
            multipleTabs = try JSONDecoder().decode([YDTabsModel].self, from: data)
            data = try Data(contentsOf: YDTabsStub.searchTermsURL)
            summaryPage = try JSONDecoder().decode([YDSummaryModel].self, from: data)
            
        }
        catch {
            print("🕵🏼‍♂️ catch block")
            return
        }
       
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            
            if let logs: YDLogFile = self.logFile {
                
                guard let parsed = YDSimpleParse(logFileUrl: logs.fileURL) else {
                    return
                }
  
                for var i in summaryPage {
                    i.findAndCutResult(logsByLine: parsed.logsByLine)
                    self.tableViewData.append(i.singleRecord())
                }
                
                for var i in multipleTabs {
                    i.cutter(logsByLine: parsed.logsByLine)
                    if i.results.elements.count > 0 {
                        let vc = YDplainVC(nibName: YDNibIdentifier.ydplainvc, bundle: nil)
                        vc.tableViewData = i.results
                        let tabbaritem = NSTabViewItem.init(viewController: vc)
                        tabbaritem.label = i.tabName
                        tabvc.addTabViewItem(tabbaritem)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.presentAsModalWindow(tabvc)
                return
            }
        }
        
        group.leave()
        group.notify(queue: .main) {
            self.tableView.reloadData()
            let end_time = YD_Time_Helper(raw_date: Date())
            let total_time = YD_Time_Helper.start_minus_finish_epoch(start_time_epoch: start_time.epoch_time, end_time_epoch: end_time.epoch_time)
            self.time_lbl.stringValue = total_time

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
                self.logFile = YDLogFile(file: a)
            }
            
            if let b = self.logFile {
                self.file_path_lbl.stringValue = b.fileName
                if self.run_btn_outlet.isHidden {
                    self.run_btn_outlet.isHidden = false
                }
                
                UserDefaults.standard.set(b.fileURL.absoluteString, forKey: "YDSelectedFile")
                return
            }
            
            self.file_path_lbl.stringValue = "❎ file not allowed"
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.title = YDStaticStrings.ydWindowTitle
        
    }
}

extension YDSummaryController:NSTableViewDataSource, NSTableViewDelegate{

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
