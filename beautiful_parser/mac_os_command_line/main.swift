import Foundation

do {
    let log = "Coding/beautifulParser/beautiful_parser/not_on_repo/logs.txt"
    guard let a = YDSelectedFile(fileString: log) else {
        throw YDError.LogFileFailed
    }
    
    let searchTerms = "Coding/beautifulParser/beautiful_parser/not_on_repo/search_terms.json"
    guard let b = YDSelectedFile(fileString: searchTerms) else {
        throw YDError.SearchTermFileFailed
    }
    print("happy" + b.fileName)
    
  //  let st_file_URL: URL = home.appendingPathComponent(st_file)
    
//
//
//    /* Convert into the Search Term model */
//    let st = try Data(contentsOf: st_file_URL)
//    var stresult = try JSONDecoder().decode([YDSearchTerm].self, from: st)
//
//    let log = try String(contentsOf: log_file_URL, encoding: String.Encoding.utf8)
//    let logs_by_line = log.split(separator: "\n")
//
//    /* Loop through search terms */
//    for (i, _) in stresult.enumerated() {
//        /* Read log file for each search term */
//        for (_, c) in logs_by_line.enumerated() {
//            if (YDStringKiller.findSubstring(str: String(c), substring: stresult[i].searchPattern) == true)
//            {
//                stresult[i].searchResult = YDStringKiller.lastWord(in: String(c))
//            }
//        }
//        print(stresult[i].YDdescription())
//    }
   
    exit(EXIT_SUCCESS)
}
catch {
    print(error)
}
