import XCTest
@testable import AdventOfCode2021

final class Day6Part2Tests: XCTestCase {

    func test_example() throws {
        let input = [
            "3,4,3,1,2",
            "",
        ]
        let sut = Day6()
        XCTAssertEqual(sut.simulateLanternfishGrowth(days: 256, from: input), 26984457539)
    }
    
}
