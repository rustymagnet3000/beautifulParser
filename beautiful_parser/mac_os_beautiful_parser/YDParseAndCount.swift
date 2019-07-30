import Foundation

class YDSingleSearch {
    
    var searchPattern: String
    lazy var result: [[String: String]] = []
    
    init(searchPattern: String) {
        self.searchPattern = searchPattern
    }
    
    func allResults() -> [[String: String]] {
        return result
    }
}

struct YDTabsModel: Decodable {
    var tabName: String
    var searchPattern: String
    lazy var result: KeyValuePairs<Int, String> = [:]
    
    func prettyDescription() -> String {
        return "\t[+] " + tabName
    }
    
    func prettyResultsForTableColumns() -> YDResultsModel {
        return YDResultsModel(title: "scary", logs: [11: "Camel",
                                                      12: "Wolf",
                                                      13: "Giant Huntsmen",
                                                      1: "Harvestman",
                                                      14: "Daddy Long Legs",
                                                      22: "Inchy Wincy",
                                                      21: "Brasilian Wandering",
                                                      15: "Daddy Long Legs",
                                                      21: "Inchy Wincy",
                                                      20: "Brasilian Wandering",
                                                      13: "Shelob",
                                                      21: "Funnel Web"])
    }
}




class YDParseAndCount {
    
    var stResult: YDSingleSearch
    let logsByLine: [String.SubSequence]
    
    convenience init? (logFileUrl: URL, searchStr: String) {

        do {
            let logStrs: String = try String(contentsOf: logFileUrl, encoding: String.Encoding.utf8)
            let results = YDSingleSearch(searchPattern: searchStr)

            self.init(stResult: results, logsByLine: logStrs.split(separator: "\n"))
        }
        catch {
            return nil
        }
    }
    
    private init?(stResult: YDSingleSearch, logsByLine: [String.SubSequence]) {
        self.stResult = stResult
        self.logsByLine = logsByLine
        
        for (i, c) in logsByLine.enumerated() {
            if (YDStringHelpers.findSubstring(str: String(c), substring: stResult.searchPattern) == true)
            {
                let x = String(c).lastColumns(n: 1)
                stResult.result.append(["keyColumn":String(i), "valueColumn":x])
            }
        }
    }
    
    internal func returnAllRecords() -> [[String: String]] {
        return stResult.result
    }
}
