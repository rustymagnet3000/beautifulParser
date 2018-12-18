struct YDSearchTerm: Codable {
    
    var searchPattern: String
    var searchName: String
    lazy var searchResult: String = "not found"
    
    init(searchPattern: String, searchName: String) {
        self.searchPattern = searchPattern
        self.searchName = searchName
    }
    
    enum CodingKeys: String, CodingKey
    {
        case searchPattern = "sp"
        case searchName = "sn"
    }
    func searchDescription() -> String {
        return searchPattern + "\t" + (searchName)
    }

    mutating func singleRecord() -> [String: String] {
        return ["keyColumn":searchName, "valueColumn":(searchResult)]
    }
}
