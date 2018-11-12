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
        if self.searchResult == nil {
            return searchPattern
        } else {
            return searchPattern + "\t" + searchResult!
        }
    }
}
