import Foundation

struct YDSpidersFearFactor {
    var elements: [(Int, String)]
    
    init(_ elements: KeyValuePairs<Int, String>) {
        self.elements = Array(elements)
    }
}
