struct YDSummaryModel: Decodable {
    
    var searchPattern: String
    var searchName: String
    var searchResult: String?
    var cutColumns: Int?

    init(searchPattern: String, searchName: String, cutColumns: Int) {
        self.searchPattern = searchPattern
        self.searchName = searchName
        self.cutColumns = cutColumns
        
    }
    
    func searchDescription() -> String {
        return "\t[+] " + searchName
    }

    func singleRecord() -> [String: String] {
        return ["keyColumn":searchName, "valueColumn":(searchResult ?? "not found")]
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
