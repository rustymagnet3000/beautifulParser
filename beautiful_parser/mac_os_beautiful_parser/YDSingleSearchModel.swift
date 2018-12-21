
class YDSingleSearch {
    
    var searchPattern: String
    lazy var result: [[String: String]] = []
    
    init(searchPattern: String) {
        self.searchPattern = searchPattern
    }
    
    func allResults() -> [[String: String]] {
        return result
    }
}

