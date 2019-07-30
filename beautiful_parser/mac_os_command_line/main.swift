import Foundation

do {
        let tabs = "Coding/beautifulParser/beautiful_parser/not_on_repo/search_tabs.json"
        let home = FileManager.default.homeDirectoryForCurrentUser
        let file = home.appendingPathComponent(tabs)


        let data: Data = try Data(contentsOf: file)
        let results: [YDTabsModel] = try JSONDecoder().decode([YDTabsModel].self, from: data)

        for i in results {
                print(i.prettyDescription())
        }
    exit(EXIT_SUCCESS)
}
catch {
    print("+] caught:\(error.localizedDescription)")
}
