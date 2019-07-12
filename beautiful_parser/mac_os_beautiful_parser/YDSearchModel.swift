struct YDSearchModel: Decodable {
    
    var searchPattern: String
    var searchName: String
    var searchResult: String?
    var cutColumns: YDCutColumns?
    
    init(searchPattern: String, searchName: String, cutColumns: YDCutColumns) {
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
}
