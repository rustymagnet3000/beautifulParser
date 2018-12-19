import Foundation

class YDParseAndCount {
    
    private var stResults: [YDSearchCount]
    let logsByLine: [String.SubSequence]

    convenience init? (logFileUrl: URL) {

        do {
            let logStrs: String = try String(contentsOf: logFileUrl, encoding: String.Encoding.utf8)
            let searchTerms = "Coding/beautifulParser/beautiful_parser/not_on_repo/search_terms_count.json"
            let home = FileManager.default.homeDirectoryForCurrentUser
            let file = home.appendingPathComponent(searchTerms)
            
            guard let stFile = YDSelectedFile(file: file) else {
                return nil
            }
            let data: Data = try Data(contentsOf: stFile.fileURL)
            let results: [YDSearchCount] = try JSONDecoder().decode([YDSearchCount].self, from: data)
            
            self.init(stResults: results, logsByLine: logStrs.split(separator: "\n"))
        }
        catch {
            return nil
        }
    }
    
    private init?(stResults: [YDSearchCount], logsByLine: [String.SubSequence]) {
        self.stResults = stResults
        self.logsByLine = logsByLine

        for (i, _) in stResults.enumerated() {
            for (_, c) in logsByLine.enumerated() {
                if (YDStringKiller.findSubstring(str: String(c), substring: stResults[i].searchPattern) == true)
                {
                    let x = String(c).twoPrettyColumns(columnA: 1, columnB: 11)
                    stResults[i].result.append(x)
                }
            }
            
        }
    }
    
    internal func returnAllRecords(){
        for i in stResults {
            for y in (i.result){
                print("🐝 \(y)")
            }
        }
    }
}
