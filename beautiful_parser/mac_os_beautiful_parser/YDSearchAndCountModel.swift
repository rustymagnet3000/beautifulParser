
class YDSearchCount: Decodable {
    
    var searchPattern: String
    var searchName: String
    lazy var result: [String] = []
    
    init(searchPattern: String, searchName: String) {
        self.searchPattern = searchPattern
        self.searchName = searchName
    }
    
    enum CodingKeys: String, CodingKey {
        case searchPattern = "sp"
        case searchName = "sn"
    }
    
    func searchDescription() -> String {
        return searchPattern + "\t" + (searchName)
    }
}

