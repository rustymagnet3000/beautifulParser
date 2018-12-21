import Foundation

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
        
        for (_, c) in logsByLine.enumerated() {
            if (YDStringKiller.findSubstring(str: String(c), substring: stResult.searchPattern) == true)
            {
                let x: [String : String] = YDStringKiller.twoPrettyColumns(logLine: String(c), columnA: 1, columnB: 11)
                    stResult.result.append(x)
            }
        }
    }
    
    internal func returnAllRecords() -> [[String: String]] {
        return stResult.result
    }
}
