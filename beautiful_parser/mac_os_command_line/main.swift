import Foundation

do {
    let fm = FileManager.default
    let home = fm.homeDirectoryForCurrentUser
    
    /* Get the Search Terms */
    let st_file = "Coding/beautifulParser/beautiful_parser/not_on_repo/search_terms.json"
    let log_file = "Coding/beautifulParser/beautiful_parser/not_on_repo/logs.txt"
    let st_file_URL: URL = home.appendingPathComponent(st_file)
    let log_file_URL: URL = home.appendingPathComponent(log_file)
    guard fm.fileExists(atPath: st_file_URL.path),
            fm.fileExists(atPath: log_file_URL.path)
        else {
            print("can't find the log file or search terms")
            exit(EXIT_FAILURE)
    }

    /* Convert into the Search Term model */
    let st = try Data(contentsOf: st_file_URL)
    var stresult = try JSONDecoder().decode([YDSearchTerm].self, from: st)

    let log = try String(contentsOf: log_file_URL, encoding: String.Encoding.utf8)
    let logs_by_line = log.split(separator: "\n")
    
    /* Loop through search terms */
    for (i, _) in stresult.enumerated() {
        /* Read log file for each search term */
        for (_, c) in logs_by_line.enumerated() {
            if (YDStringKiller.findSubstring(str: String(c), substring: stresult[i].searchPattern) == true)
            {
                stresult[i].searchResult = YDStringKiller.lastWord(in: String(c))
            }
        }
        print(stresult[i].YDdescription())
    }
   
    exit(EXIT_SUCCESS)
}
catch {
    print(error)
}
