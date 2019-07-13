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
