import Foundation

class YDLogFile {

    var fileURL: URL
    let fileName: String
    let fileAbsoluteStr: String
    static var globalFile: URL? = nil

    convenience init?(file: URL) {
        guard FileManager.default.fileExists(atPath: file.path),
                FileManager.default.isReadableFile(atPath: file.path),
                    !FileManager.default.isExecutableFile(atPath: file.path) else {
            return nil
        }
        self.init(fileURL: file, fileName: file.lastPathComponent, fileAbsoluteStr: file.absoluteString)
    }
    
    init?(fileURL: URL, fileName: String, fileAbsoluteStr: String) {
        self.fileURL = fileURL
        self.fileName = fileName
        self.fileAbsoluteStr = fileAbsoluteStr
    }
}

//class YDLogFile: YDSelectedFile {
//    init?(logFile: URL) {
//        super.init(fileURL: logFile, fileName: logFile.lastPathComponent)
//        YDSelectedFile.globalFile = super.fileURL
//    }
//}
