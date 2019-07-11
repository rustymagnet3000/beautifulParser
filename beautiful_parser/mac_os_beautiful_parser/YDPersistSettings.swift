import Foundation
import Cocoa

class YDPersistSettings {

    static func selectedFile() -> YDLogFile? {
        
        do {
            guard let persistedFileStr = UserDefaults.standard.object(forKey: "YDSelectedFile") as? String else {
                throw YDError.PersistedFileNotFound
            }
            guard let fileurl = URL(string: persistedFileStr) else {
                throw YDError.SelectedFileIssue
            }
            guard let logFile = YDLogFile(file: fileurl) else {
                throw YDError.SelectedFileIssue
            }
            return logFile
        }
        catch {
            print(error)
            return nil
        }
    }
}
