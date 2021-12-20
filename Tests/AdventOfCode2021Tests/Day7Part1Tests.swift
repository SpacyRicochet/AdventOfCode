import XCTest
@testable import AdventOfCode2021

final class Day7Part1Tests: XCTestCase {

    func test_example() throws {
        let input = [
            "16,1,2,0,4,2,7,1,2,14",
            "",
        ]
        let sut = Day7()
        XCTAssertEqual(sut.fuelUsage(increasesPerStep: false, from: input), 37)
    }

}
