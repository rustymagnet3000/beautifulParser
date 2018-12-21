import Foundation


class YDSelectedFile {

    var fileURL: URL
    let fileName: String
    static var globalFile: URL? = nil

    convenience init?(file: URL) {
        guard FileManager.default.fileExists(atPath: file.path),
                FileManager.default.isReadableFile(atPath: file.path),
                    !FileManager.default.isExecutableFile(atPath: file.path) else {
            return nil
        }
        self.init(fileURL: file, fileName: file.lastPathComponent)
    }
    
    init?(fileURL: URL, fileName: String) {
        self.fileURL = fileURL
        self.fileName = fileName
    }
}

class YDLogFile: YDSelectedFile {
    init?(logFile: URL) {
        super.init(fileURL: logFile, fileName: logFile.lastPathComponent)
        YDSelectedFile.globalFile = super.fileURL
    }
}
