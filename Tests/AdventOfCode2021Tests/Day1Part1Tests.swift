import XCTest
@testable import AdventOfCode2021

final class Day1Part1Tests: XCTestCase {

    func test_example() throws {
        let input = [
            "199",
            "200",
            "208",
            "210",
            "200",
            "207",
            "240",
            "269",
            "260",
            "263",
        ]
        let sut = Day1()
        XCTAssertEqual(sut.numberOfIncreases(from: input), 7)
    }

    func test_numberOfIncreases_withEmptyInput() throws {
        let input = [String]()
        let sut = Day1()
        XCTAssertEqual(sut.numberOfIncreases(from: input), 0)
    }

    func test_numberOfIncreases_withOneInput() throws {
        let input = [
            "0",
        ]
        let sut = Day1()
        XCTAssertEqual(sut.numberOfIncreases(from: input), 0)
    }

    func test_numberOfIncreases_withTwoInputs() throws {
        let input = [
            "0",
            "1",
        ]
        let sut = Day1()
        XCTAssertEqual(sut.numberOfIncreases(from: input), 1)
    }

    func test_numberOfIncreases_withOnlyIncreases() throws {
        let input = [
            "0",
            "1",
            "2",
        ]
        let sut = Day1()
        XCTAssertEqual(sut.numberOfIncreases(from: input), 2)
    }

    func test_numberOfIncreases_withOnlyEquals() throws {
        let input = [
            "0",
            "0",
            "0",
        ]
        let sut = Day1()
        XCTAssertEqual(sut.numberOfIncreases(from: input), 0)
    }
    
    func test_numberOfIncreases_withOnlyDecreases() throws {
        let input = [
            "0",
            "-1",
            "-2",
        ]
        let sut = Day1()
        XCTAssertEqual(sut.numberOfIncreases(from: input), 0)
    }
}
