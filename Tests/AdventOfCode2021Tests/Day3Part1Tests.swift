import XCTest
@testable import AdventOfCode2021

final class Day3Part1Tests: XCTestCase {

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
        XCTAssertEqual(sut.powerConsumption(from: input), 198)
    }

    func test_powerConsumption_oneOneZeroZero_oneOneZeroOne_zeroOneZeroOne() throws {
        let input = [
            "1100",
            "1101",
            "0101",
        ]
        let sut = Day3()
        // Gamma:   1101 -> 13
        // Epsilon: 0010 ->  2
        XCTAssertEqual(sut.powerConsumption(from: input), 26)
    }

}
