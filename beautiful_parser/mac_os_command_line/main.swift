import Foundation

do {
        let data: Data = try Data(contentsOf: YDTabsStub.fileURL)
        let results: [YDTabsModel] = try JSONDecoder().decode([YDTabsModel].self, from: data)

        for i in results {
                print(i.tabName + "-> \(i.cutColumns)")
        }
    exit(EXIT_SUCCESS)
}
catch {
    print("+] caught:\(error.localizedDescription)")
}
