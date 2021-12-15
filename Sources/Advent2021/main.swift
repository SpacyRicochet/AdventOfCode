import Foundation
import AdventOfCode2021

let commands = CommandLine.arguments.dropFirst()

do {
switch commands {
    case ["day1", "part1"]:
        print(try AdventOfCode2021.Day1().runPart1())
    case ["day1", "part2"]:
        print(try AdventOfCode2021.Day1().runPart2())
    case ["day2", "part1"]:
        print(try AdventOfCode2021.Day2().runPart1())
    case ["day2", "part2"]:
        print(try AdventOfCode2021.Day2().runPart2())
    case ["day3", "part1"]:
        print(try AdventOfCode2021.Day3().runPart1())
    case ["day3", "part2"]:
        print(try AdventOfCode2021.Day3().runPart2())
    case ["day4", "part1"]:
        print(try AdventOfCode2021.Day4().runPart1())
    case ["day4", "part2"]:
        print(try AdventOfCode2021.Day4().runPart2())
    case ["day5", "part1"]:
        print(try AdventOfCode2021.Day5().runPart1())
    case ["day5", "part2"]:
        print(try AdventOfCode2021.Day5().runPart2())
        
    case []:
        print("No subcommand given"); exit(1)
    default:
        print("Unrecognized subcommand '\(commands.joined(separator: " "))'")
        exit(1)
}
} catch {
    print("Error occurred: \(error)")
    exit(1)
}
