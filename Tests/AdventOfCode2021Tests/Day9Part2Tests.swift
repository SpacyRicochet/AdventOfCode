import XCTest
@testable import AdventOfCode2021

final class Day9Part2Tests: XCTestCase {

    func test_example() throws {
        let input = [
            "2199943210",
            "3987894921",
            "9856789892",
            "8767896789",
            "9899965678",
        ]
        let sut = Day9()
        XCTAssertEqual(sut.productOfTopThreeBasins(from: input), 1134)
    }
    
}
