import Foundation

struct YDTabsModel: Decodable {
    
    var tabName: String
    var searchPattern: String
    var cutColumns: Int?
    lazy var results: YDSpidersFearFactor = YDSpidersFearFactor([:])
    
    mutating func cutter(logsByLine: [String.SubSequence]) {
        for (i, c) in logsByLine.enumerated() {
            if (YDStringHelpers.findSubstring(str: String(c), substring: searchPattern) == true)
            {
                let x: String
                if let column = cutColumns {
                    x = String(c).lastColumns(n: column)
                }
                else {
                    x = String(c).lastColumns(n: 1)
                }
                results.elements.append((Int(i), x))
            }
        }
    }
}

class YDSimpleParse {
    let logsByLine: [String.SubSequence]
    
    init? (logFileUrl: URL) {
        
        do {
            let logStrs: String = try String(contentsOf: logFileUrl, encoding: String.Encoding.utf8)
            logsByLine = logStrs.split(separator: "\n")
        }
        catch {
            return nil
        }
    }
}
