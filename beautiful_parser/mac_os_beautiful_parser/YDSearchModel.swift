struct YDSearchTerm {
    
    var searchPattern: String
    var searchName: String
    var searchResult: String = "not found"
    
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

    func singleRecord() -> [String: String] {
        return ["keyColumn":searchName, "valueColumn":(searchResult)]
    }
}

extension YDSearchTerm: Decodable
{
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        searchPattern = try values.decode(String.self, forKey: .searchPattern)
        searchName = try values.decode(String.self, forKey: .searchName)
    }
}
