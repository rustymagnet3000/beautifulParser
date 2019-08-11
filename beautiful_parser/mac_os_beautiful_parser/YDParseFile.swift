import Foundation

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
