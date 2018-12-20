# 🐝 Beautiful Parser 🐝
A macOS app built in Swift 4 that can parse through log files.  

The app is extendable, you can add specific items of interest, based on the effort you put into creating the `Search Term` file.

## Example Search Term file
```
[
    {"sp": "app version", "App Version"},  
    {"sp": "guid_api", "API Key"}
]
```
## Building Blocks
There are 3 Objects that provide the foundation of the log parser.

Search  | Search & Count |   YDSearch
--|---|--
json file | json file |  json file
Add each search term  | Add each search term |  Point to file  
1 : 1 results  | 1 : N results   |  -
## Planned improvements
- Multi-threading, for parsing large files.
- Persistence, to improve the user experience.
- Count, search terms that focus on counting of certain strings.
- Order, search term that returns the order of specific log entries [like network requests]

## Design Notes
#### Avoid Swift Playgrounds on macOS
Swift Playgrounds remain unstable in Xcode 10.  version 10.1 made major stability improvements but I preferred to add a Command Line Swift target to my project to test new building blocks like _Structs_ and _Classes_.

#### Shipping "Search Terms" with the App Bundle vs choosing a second file
I was loathed to ship the _search terms_ file inside the App bundle.  If you do not ship the file, you are asking a user to point toward a log file and a search term files at start-up.  The fike has to be correctly formatted json.  I choose the user interruption option.  I added some _persistence_ to ensure this was only a one-time selection, to lessen the burden.
