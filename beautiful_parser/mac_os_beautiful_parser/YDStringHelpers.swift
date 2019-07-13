
class YDStringHelpers {
    
    static func findSubstring(str: String, substring: String) -> Bool { // case sensitive
        if str.range(of:substring) != nil {
            return true
        }
        return false
    }
    
    static func twoPrettyColumns(logLine: String, columnA: Int, columnB: Int) -> [String: String] {
        
        let strArray: [String] = logLine.split(separators: " \t").compactMap { String($0) }
        if strArray.isEmpty || columnA > strArray.count || columnB > strArray.count {
            return ["keyColumn":"column", "valueColumn":"error"]
        }
        let a = strArray.endIndex
        if a <= columnB {
            return ["keyColumn":strArray[columnA], "valueColumn":(strArray.last ?? "not found")]
        }
        return ["keyColumn":strArray[columnA], "valueColumn":(strArray[columnB])]
    }

}

extension Collection where Element: Equatable {
    func split<S: Sequence>(separators: S) -> [SubSequence]
        where Element == S.Element
    {
        return split { separators.contains($0) }
    }
}

extension String {
    func condenseTrailingWhitespace() -> String {
        return self.components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
    
    func lastColumns(n: Int) -> String {
        var columns = self.split(separator: " ")
        var returnStr: String = ""
        
        guard columns.count > 0 && n > 0 else {
            return "zero column error"
        }
        
        columns.reverse()
        for i in 0..<n {
            returnStr = (columns[i]) + " " + returnStr
        }
        return returnStr
    }
}
