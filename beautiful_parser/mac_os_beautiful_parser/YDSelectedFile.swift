import Foundation

public enum YDError: Error {
    case FileCheckFailed
}

class YDSelectedFile {

    var fileURL: URL
    let fileName: String 
    private let home: URL
    
    convenience init? (file: URL) {
        if !FileManager.default.fileExists(atPath: file.path) || !FileManager.default.isReadableFile(atPath: file.path){
            return nil
        }
        if FileManager.default.isExecutableFile(atPath: file.path){
            return nil
        }
        self.init(fileURL: file, fileName: file.lastPathComponent)
    }
    
    private init?(fileURL: URL, fileName: String) {
        self.fileURL = fileURL
        self.fileName = fileName
        self.home = FileManager.default.homeDirectoryForCurrentUser
    }
}
