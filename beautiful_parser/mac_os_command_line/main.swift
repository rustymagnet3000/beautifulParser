import Foundation

let log = "Coding/beautifulParser/beautiful_parser/not_on_repo/logs.txt"
let home = FileManager.default.homeDirectoryForCurrentUser
let file = home.appendingPathComponent(log)

do {
    
    guard let logFile = YDSelectedFile(file: file) else {
        throw YDError.SearchTermFileFailed
    }
    
    if let a = YDParseFile(logFileUrl: logFile.fileURL){
        let b = a.ydEnumerateResults()
        print(b)
    }
    
    
    exit(EXIT_SUCCESS)
}
catch {
    print(error.localizedDescription)
}
