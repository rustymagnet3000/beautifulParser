enum YDCutColumns : Int, Codable {
    case    Last_Three = 3
    case    Last_Six = 6
    case    Last_Eighteen = 18
    case    Default = 1
}

public enum YDError: Error {
    case LogFileFailed
    case ParseFailed
    case SearchTermFileFailed
    case PersistedFileNotFound
    case SelectedFileIssue
    case TimeError
}
