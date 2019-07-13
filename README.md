# 🐝 Bee Parser 🐝
A macOS app built in Swift 5 that could parse large log files.  

The app was designed to be extendable; you could add specific items of interest.  It was the user's effort in this area that would reap the greatest rewards.

## Example Search Term file
```
[
    {"searchPattern": "FoO", "searchName": "Foo","cutColumns": 5},
    {"searchPattern": "b&r", "searchName": "Bar"}
]
```
## Building Blocks
There are 3 Objects that provide the foundation of the `Bee Parser`.

Search  | Search & Count |   YDSearch
--|---|--
json file | json file |  json file
Add each search term  | Add each search term |  Point to file  
1 : 1 results  | 1 : N results   |  -


## Planned improvements
- Change Search Model to include a "count"
- Dynamically add a TabBar
- Change Search Model to allow you to override what is found in the logs with a nicer to read message
- ~Multi-threaded, for parsing large files.~
- ~Persistent file names, to improve the user experience.~
- Add Spinner to block activity while parsing.
- Count, search terms that focus on counting of certain strings.
- Order, search term that returns the order of specific log entries [like network requests]

## Design Notes
#### Avoid Swift Playgrounds on macOS
Swift Playgrounds remain unstable in Xcode 10.  version 10.1 made major stability improvements but I preferred to add a Command Line Swift target to my project to test new building blocks like _Structs_ and _Classes_.

#### Persistence in the real-world
When people could delete, rename or move a log file I had to use Swift `optionals` when trying to check if a persisted file still existed before offering it to the user.

#### Shipping "Search Terms" with the App Bundle vs choosing a second file
I was loathed to ship the _search terms_ file inside the App bundle.  If you do not ship the file, you are asking a user to point toward a log file and a search term files at start-up.  The file has to be correctly formatted json.  I choose the user interruption option.  I added _persistence_ to ensure this was only a one-time selection, to lessen the burden.
