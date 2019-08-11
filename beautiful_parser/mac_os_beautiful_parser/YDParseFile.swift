import Foundation

class YDParseFile {
    
    var stResults: [YDSearchModel]
    let logsByLine: [String.SubSequence]
    lazy var matchesFound: Int = 0
    lazy var printableResults: [[String : String]] = []
    
    convenience init? (logFileUrl: URL) {
        
        do {
            guard let stFile = YDLogFile(file: YDTabsStub.fileURL) else {
                throw YDError.SearchTermFileFailed
            }
            
            let data: Data = try Data(contentsOf: stFile.fileURL)
            let results: [YDSearchModel] = try JSONDecoder().decode([YDSearchModel].self, from: data)
            
            let logStrs: String = try String(contentsOf: logFileUrl, encoding: String.Encoding.utf8)
            
            self.init(stResults: results, logsByLine: logStrs.split(separator: "\n"))
        }
        catch {
            return nil
        }
    }
        
    private init?(stResults: [YDSearchModel], logsByLine: [String.SubSequence]) {
            self.stResults = stResults
            self.logsByLine = logsByLine
    }
 
    internal func ydEnumerateResults() -> [[String : String]]{
        /* Loop through search terms */
        for (i, _) in stResults.enumerated() {
            
            /* Read log file for each search term */
            for (_, c) in logsByLine.enumerated() {
                if (YDStringHelpers.findSubstring(str: String(c), substring: stResults[i].searchPattern) == true)
                {
                    if let cut = stResults[i].cutColumns { // deals  nil / incorrect values
                        stResults[i].searchResult = String(c).lastColumns(n: cut)
                    } else {
                        stResults[i].searchResult = String(c).lastColumns(n: 1)
                    }
                    
                    matchesFound += 1
                }
            }
            printableResults.append(stResults[i].singleRecord())
            
        }
        return printableResults
    }
}
