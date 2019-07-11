import Foundation

do {
    let log = "Coding/beautifulParser/beautiful_parser/not_on_repo/logs.txt"
    let home = FileManager.default.homeDirectoryForCurrentUser
    let file = home.appendingPathComponent(log)
    guard let origLogFile = YDLogFile(file: file) else {
        throw YDError.LogFileFailed
    }
    
    let persisted = origLogFile.fileAbsoluteStr as String?
    var logFile: YDLogFile?
    
    if let persistedFileStr = persisted {
        if let fileurl = URL(string: persistedFileStr) {
            logFile = YDLogFile(file: fileurl)
            if logFile != nil {
                
            }
        }

    }
    
    exit(EXIT_SUCCESS)
}
catch {
    print(error.localizedDescription)
}
