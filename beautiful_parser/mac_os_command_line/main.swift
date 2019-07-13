import Foundation

do {
        let log = "Coding/beautifulParser/beautiful_parser/not_on_repo/logs.txt"
        let home = FileManager.default.homeDirectoryForCurrentUser
        var file = home.appendingPathComponent(log)
        guard let origLogFile = YDLogFile(file: file) else {
            throw YDError.LogFileFailed
        }
    
        let searchTerms = "Coding/beautifulParser/beautiful_parser/not_on_repo/search_terms.json"
        file = home.appendingPathComponent(searchTerms)

        guard let stFile = YDLogFile(file: file) else {
            throw YDError.SearchTermFileFailed
        }
    
        let data: Data = try Data(contentsOf: stFile.fileURL)
        let results: [YDSearchModel] = try JSONDecoder().decode([YDSearchModel].self, from: data)
    
        for i in results {
                print(i.searchDescription())
        }
    exit(EXIT_SUCCESS)
}
catch {
    print(error.localizedDescription)
}
