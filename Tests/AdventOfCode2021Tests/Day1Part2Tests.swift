import XCTest
@testable import AdventOfCode2021

final class Day1Part2Tests: XCTestCase {

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
        XCTAssertEqual(sut.numberOfWindowedIncreases(size: 3, from: input), 5)
    }

    func test_numberOfWindowedIncreases_withEmptyInput() throws {
        let input = [String]()
        let sut = Day1()
        XCTAssertEqual(sut.numberOfWindowedIncreases(size: 3, from: input), 0)
    }

    func test_numberOfWindowedIncreases_withOneInput() throws {
        let input = [
            "0",
        ]
        let sut = Day1()
        XCTAssertEqual(sut.numberOfWindowedIncreases(size: 3, from: input), 0)
    }

    func test_numberOfWindowedIncreases_withTwoInputs() throws {
        let input = [
            "0",
            "1",
        ]
        let sut = Day1()
        XCTAssertEqual(sut.numberOfWindowedIncreases(size: 3, from: input), 0)
    }

    func test_numberOfWindowedIncreases_withThreeInputs() throws {
        let input = [
            "0",
            "1",
            "2",
        ]
        let sut = Day1()
        XCTAssertEqual(sut.numberOfWindowedIncreases(size: 3, from: input), 0)
    }

    func test_numberOfWindowedIncreases_withFourInputs() throws {
        let input = [
            "0",
            "1",
            "2",
            "3",
        ]
        let sut = Day1()
        XCTAssertEqual(sut.numberOfWindowedIncreases(size: 3, from: input), 1)
    }

    func test_numberOfWindowedIncreases_withOnlyIncreases() throws {
        let input = [
            "0",
            "1",
            "2",
            "3",
            "4",
        ]
        let sut = Day1()
        XCTAssertEqual(sut.numberOfWindowedIncreases(size: 3, from: input), 2)
    }

    func test_numberOfWindowedIncreases_withSomeIncreases() throws {
        let input = [
            "0",
            "1",
            "2",
            "0",
            "2",
        ]
        let sut = Day1()
        XCTAssertEqual(sut.numberOfWindowedIncreases(size: 3, from: input), 1)
    }

    func test_numberOfWindowedIncreases_withOnlyEquals() throws {
        let input = [
            "1",
            "1",
            "1",
            "1",
            "1",
        ]
        let sut = Day1()
        XCTAssertEqual(sut.numberOfWindowedIncreases(size: 3, from: input), 0)
    }
    
    func test_numberOfWindowedIncreases_withOnlyDecreases() throws {
        let input = [
            "0",
            "-1",
            "-2",
            "-3",
            "-4",
        ]
        let sut = Day1()
        XCTAssertEqual(sut.numberOfWindowedIncreases(size: 3, from: input), 0)
    }
}
