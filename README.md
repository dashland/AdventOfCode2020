# Advent of Code 2020

These are my [Advent of Code 2020](https://adventofcode.com/2020) puzzle solutions and puzzle running tool. The solutions and tool are written in Swift and can be run as a command line tool on macOS or with the included Xcode project. The tool can optionally download and cache puzzle input from adventofcode.com if a session cookie is provided.

## Running Puzzles

### Usage

```
USAGE: swift run AdventOfCode <puzzle-index> [--cookie <cookie>] [--test-input <test-input>] [--force-download]

OPTIONS:
  --cookie <cookie>       The cookie named "session" for adventofcode.com. Used to authenticate for downloading puzzle input. Optional if puzzle input is already stored in ./Input/<puzzle-index>.txt or
                          provided with --input. 
  --test-input <test-input>
                          An input string to test run the puzzle with. The input file will not be downloaded or read if test input is provided.
  --force-download        Force a download of puzzle input even if there's a local file cached. 
```

### Retrieving Your Session Cookie
In Safari the cookie can be retrieved from Develop → Show Web Inspector → Storage.

You can store your session cookie in an environment variable to ease running puzzles (e.g. `echo 'export SESSION_COOKIE=<session-cookie>' >> ~/.zshenv`).

### Example

```
$ swift run AdventOfCode 1 --cookie $AOC_COOKIE --force-download 

🗃 Preparing Input

Downloading input from https://adventofcode.com/2020/day/1/input
Downloaded 200 lines (988 chars) of input

🚀 Running AOC1

Part 1 Solution: 1009899 | ⏱ 24ms

Part 2 Solution: 44211152 | ⏱ 270ms
```

## Adding New Puzzles

1. Add a new struct in `Sources/AdventOfCode/Puzzles` that conforms to `Puzzle` and include in the `AdventOfCode` and `AdventOfCodeTests` targets in Xcode.
2. Update `PuzzleSet.swift`'s `puzzlesByIndex` to map the puzzle index to the new struct.
3. Implement `solve1(input:)` and `solve2(input:)` to provide the puzzle solutions.

## Testing

Unit tests for running puzzles with custom test input are available in `PuzzleTests.swift`. These can be run with the `AdventOfCodeTests` target.

### Example

```swift
class AOCTests: XCTestCase {

    func testAOC1() {
        XCTAssertEqual(AOC1().solve1(input: "1721,979,366,299,675,1456"), 514579)
        XCTAssertEqual(AOC1().solve2(input: "1721,979,366,299,675,1456"), 241861950)
    }

}
```