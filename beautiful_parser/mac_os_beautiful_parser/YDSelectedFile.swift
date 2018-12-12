import Foundation

class YDSelectedFile {

    let fileURL: URL
    let fileName: String
    
    convenience init (file: URL) {
        self.init(fileURL: file, fileName: file.lastPathComponent)
    }
    
    private init(fileURL: URL, fileName: String) {
        self.fileURL = fileURL
        self.fileName = fileName
        fileChecks()  // MARK: add handling code
    }
    
    func fileChecks() -> Bool {
        if !FileManager.default.fileExists(atPath: fileURL.path){
            return false
        }
        if !FileManager.default.isReadableFile(atPath: fileURL.path){
            return false
        }
        if FileManager.default.isExecutableFile(atPath: fileURL.path){
            return false
        }
        return true
    }
}
