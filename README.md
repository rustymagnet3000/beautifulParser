# 🐝 Bee Parser 🐝
A macOS app.

The app parsed large log files.  You could add specific items of interest.  It was the user's effort of adding `search terms` that would reap the greatest rewards.

The code was written in `Swift 5.1`.

## Example Search Term file
The results from this file would populate the Summary `View Controller`.
```
[
    {"searchPattern": "FoO", "searchName": "Foo","cutColumns": 5},
    {"searchPattern": "b&r", "searchName": "Bar"}
]
```

## Example Search Tabs file
The results from this file would auto-generate a Tab and populate the Tab will all matches found.
```
[
    {"searchPattern": "https://", "tabName": "Network request"},
    {"searchPattern": "FooBar", "tabName": "Foo","cutColumns": 5},
    {"searchPattern": "errors", "tabName": "All Errors","cutColumns": 1}
]
```
## Building Blocks
-| Search Term  | Search Tabs
--|--|---
Input | json file |  json file
Purpose | Find first | Find all


## Planned improvements
- Add `Copy` when you press `Cmd+C`
- Add `Copy` from the `Edit` menu option
- Add a `Uniques_only` property on TabsModel
- Change `Search Model` to give pretty to read message
- Add `Spinner` to block activity while parsing
- Add search for `individual items`
- Add `custom regex` search

## Completed improvements
- ~Change Search Model to include a "count"~
- ~Dynamically add a TabBar~
- ~Multi-threaded, for parsing large files.~
- ~Persistent file names, to improve the user experience.~

## Design Notes
#### Avoid Swift Playgrounds on macOS
Swift Playgrounds remain unstable in Xcode 10.  version 10.1 made major stability improvements but I preferred to add a Command Line Swift target to my project to test new building blocks like _Structs_ and _Classes_.

#### Persistence in the real-world
When people could delete, rename or move a log file I had to use Swift `optionals` when trying to check if a persisted file still existed before offering it to the user.

#### Shipping "Search Terms" with the App Bundle vs choosing a second file
I was loathed to ship the _search terms_ file inside the App bundle.  If you do not ship the file, you are asking a user to point toward a log file and a search term files at start-up.  The file has to be correctly formatted json.  I choose the user interruption option.  I added _persistence_ to ensure this was only a one-time selection, to lessen the burden.
