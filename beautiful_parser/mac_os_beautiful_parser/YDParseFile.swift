import Foundation

class YDParseFile {
    
    var stResults: [YDSearchTerm]
    let logsByLine: [String.SubSequence]
    lazy var matchesFound: Int = 0
    lazy var printableResults: [[String : String]] = []
    
    convenience init? (logFileUrl: URL) {
        
        do {
            let searchTerms = "Coding/beautifulParser/beautiful_parser/not_on_repo/search_terms.json"
            let home = FileManager.default.homeDirectoryForCurrentUser
            let file = home.appendingPathComponent(searchTerms)
            guard let stFile = YDSelectedFile(file: file) else {
                throw YDError.SearchTermFileFailed
            }
            /* Convert into the Search Term model */
            let data: Data = try Data(contentsOf: stFile.fileURL)
            let results: [YDSearchTerm] = try JSONDecoder().decode([YDSearchTerm].self, from: data)
            
            /* Split log file into large String and chop by separator */
            let logStrs: String = try String(contentsOf: logFileUrl, encoding: String.Encoding.utf8)
            
            self.init(stResults: results, logsByLine: logStrs.split(separator: "\n"))
        }
        catch {
            return nil
        }
    }
        
    private init?(stResults: [YDSearchTerm], logsByLine: [String.SubSequence]) {
            self.stResults = stResults
            self.logsByLine = logsByLine
    }
 
    internal func ydEnumerateResults() -> [[String : String]]{
        /* Loop through search terms */
        for (i, _) in stResults.enumerated() {
            
            /* Read log file for each search term */
            for (_, c) in logsByLine.enumerated() {
                if (YDStringKiller.findSubstring(str: String(c), substring: stResults[i].searchPattern) == true)
                {
                    stResults[i].searchResult = YDStringKiller.lastWord(in: String(c))
                    matchesFound += 1
                }
            }
            printableResults.append(stResults[i].YDsingleRecord())
            
        }
        return printableResults
    }
}
