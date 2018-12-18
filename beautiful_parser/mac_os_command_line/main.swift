import Foundation

do {
    let searchTerms = "Coding/beautifulParser/beautiful_parser/not_on_repo/search_terms.json"
    let home = FileManager.default.homeDirectoryForCurrentUser
    let file = home.appendingPathComponent(searchTerms)
    guard let stFile = YDSelectedFile(file: file) else {
        throw YDError.SearchTermFileFailed
    }
    /* Convert into the Search Term model */
    let data: Data = try Data(contentsOf: stFile.fileURL)
    let results: [YDSearchTerm] = try JSONDecoder().decode([YDSearchTerm].self, from: data)
    for i in results {
        print(i.searchDescription())
    }
    
    exit(EXIT_SUCCESS)
}
catch {
    print(error.localizedDescription)
}
