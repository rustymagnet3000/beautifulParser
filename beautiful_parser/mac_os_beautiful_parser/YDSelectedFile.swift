import Foundation

public enum YDError: Error {
    case LogFileFailed
    case SearchTermFileFailed
}

class YDSelectedFile {

    var fileURL: URL
    let fileName: String 
    private let home: URL
    
    convenience init? (fileString: String) {

        let home = FileManager.default.homeDirectoryForCurrentUser
        let file = home.appendingPathComponent(fileString)
        
        guard FileManager.default.fileExists(atPath: file.path),
                FileManager.default.isReadableFile(atPath: file.path),
                    !FileManager.default.isExecutableFile(atPath: file.path) else {
            return nil
        }
        
        self.init(fileURL: file, fileName: file.lastPathComponent, home: home)
    }
    
    private init?(fileURL: URL, fileName: String, home: URL) {
        self.fileURL = fileURL
        self.fileName = fileName
        self.home = home
    }
}
