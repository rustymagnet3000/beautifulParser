import Foundation

do {
    var pairs = YDSpidersFearFactor([5: "Wolf", 1: "Huntsmen", 1: "Redback", 3: "Wandering", 2: "Trapdoor"])
    
    pairs.elements.reverse()
    print(pairs.elements)
    
    // HERE: Try and get it working on macOS so I can debug $0
    guard let account = pairs.elements[3].1.first(where: { $0 == "H" }) else {
        exit(111)
    }
    print("account: \(account)")
    let firstIndex = pairs.elements[3].1.firstIndex(of: account)

    print(firstIndex)

    exit(EXIT_SUCCESS)
}
catch {
    print("+] caught:\(error.localizedDescription)")
}
