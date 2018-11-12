struct YDSearchTerm: Codable {
    
    var searchPattern: String
    var searchResult: String?
    
    init(searchPattern: String, searchResult: String? = nil) {
        self.searchPattern = searchPattern
        self.searchResult = searchResult
    }
    
    enum CodingKeys: String, CodingKey
    {
        case searchPattern = "sp"
        case searchResult = "sr"
    }
    func YDdescription() -> String {
        return searchPattern + "\t" + (searchResult ?? "not found")
    }
}
