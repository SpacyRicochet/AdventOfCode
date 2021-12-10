import XCTest
@testable import AdventOfCode2021

final class Day3Part2Tests: XCTestCase {

    func test_example() throws {
        let input = [
            "00100",
            "11110",
            "10110",
            "10111",
            "10101",
            "01111",
            "00111",
            "11100",
            "10000",
            "11001",
            "00010",
            "01010",
        ]
        let sut = Day3()
        XCTAssertEqual(sut.lifeSupportRating(from: input), 230)
    }
}
