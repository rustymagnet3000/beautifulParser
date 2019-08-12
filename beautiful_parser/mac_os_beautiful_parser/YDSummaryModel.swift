struct YDSummaryModel: Decodable {
    
    var searchPattern: String
    var searchName: String
    var searchResult: String?
    var cutColumns: Int?
    var prettyResult: String?
    
    init(searchPattern: String, searchName: String, cutColumns: Int) {
        self.searchPattern = searchPattern
        self.searchName = searchName
        self.cutColumns = cutColumns
        
    }
    
    func searchDescription() -> String {
        return "\t[+] " + searchName
    }

    func singleRecord() -> [String: String] {
        
        if let a = prettyResult {
            return ["keyColumn":searchName, "valueColumn":a]
        }
        return ["keyColumn":searchName, "valueColumn":(searchResult ?? "🎭")]
        
    }
    
    mutating func findAndCutResult(logsByLine: [String.SubSequence]) {
        for (_, c) in logsByLine.enumerated() {
            if (YDStringHelpers.findSubstring(str: String(c), substring: searchPattern) == true)
            {
                if let column = cutColumns {
                    searchResult = String(c).lastColumns(n: column)
                }
                else {
                    searchResult = String(c).lastColumns(n: 1)
                }
            }
        }
    }
}
