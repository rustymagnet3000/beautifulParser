import Foundation

class YDFileSetup {

    let fileURL: URL
    
    init(fileURL: URL) {
        self.fileURL = fileURL
    }
    
    func fileExist() -> Bool {
        
        let fileExists = FileManager.default.fileExists(atPath: fileURL.path)
        return fileExists
    }
}
