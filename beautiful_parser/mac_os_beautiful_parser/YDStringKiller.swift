
class YDStringKiller {
    // case sensitive
    static func findSubstring(str: String, substring: String) -> Bool {
        if str.range(of:substring) != nil {
            return true
        }
        return false
    }
    
    static func lastWord(in input: String) -> String {
        let words = input.split(separators: [" "])
        guard let lastWord = words.last else { return "default" }
        return String(lastWord)
    }

}

extension Collection where Element: Equatable {
    func split<S: Sequence>(separators: S) -> [SubSequence]
        where Element == S.Element
    {
        return split { separators.contains($0) }
    }
}

extension String {
    func condenseTrailingWhitespace() -> String {
        return self.components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
}

extension String {
    func twoPrettyColumns(columnA: Int, columnB: Int) -> String {
        let strArray: [String] = self.split(separators: " \t").compactMap { String($0) }
        if strArray.isEmpty || columnA > strArray.count || columnB > strArray.count {
            return self
        }
        return (strArray[columnA] + "\t" + strArray[columnB])
    }
}
