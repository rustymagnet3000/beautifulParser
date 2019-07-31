import Foundation

struct YDTabsModel: Decodable {
    var tabName: String
    var searchPattern: String
    
    func prettyDescription() -> String {
        return "\t[+] " + tabName
    }
}

class YDParseAndCount {
    
    var searchPattern: String
    var results: YDSpidersFearFactor = YDSpidersFearFactor([:])
    let logsByLine: [String.SubSequence]
    
    convenience init? (logFileUrl: URL, searchStr: String) {

        do {
            let logStrs: String = try String(contentsOf: logFileUrl, encoding: String.Encoding.utf8)
            self.init(searchPattern: searchStr, logsByLine: logStrs.split(separator: "\n"))
        }
        catch {
            return nil
        }
    }
    
    private init?(searchPattern: String, logsByLine: [String.SubSequence]) {
        self.searchPattern = searchPattern
        self.logsByLine = logsByLine
        
        for (i, c) in logsByLine.enumerated() {
            if (YDStringHelpers.findSubstring(str: String(c), substring: searchPattern) == true)
            {
                let x = String(c).lastColumns(n: 1)
                results.elements.append((Int(i), x))
            }
        }
    }
}
