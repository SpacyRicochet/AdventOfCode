import XCTest
@testable import AdventOfCode2021

final class Day7Part2Tests: XCTestCase {

    func test_example() throws {
        let input = [
            "16,1,2,0,4,2,7,1,2,14",
            "",
        ]
        let sut = Day7()
        XCTAssertEqual(sut.fuelUsage(increasesPerStep: true, from: input), 168)
    }

}
