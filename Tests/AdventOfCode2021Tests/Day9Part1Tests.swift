import XCTest
@testable import AdventOfCode2021

final class Day9Part1Tests: XCTestCase {

    func test_example() throws {
        let input = [
            "2199943210",
            "3987894921",
            "9856789892",
            "8767896789",
            "9899965678",
        ]
        let sut = Day9()
        XCTAssertEqual(sut.sumOfRiskLevels(from: input), 15)
    }
    
    func test_neighbours() throws {
        XCTAssertEqual(
            Coordinate(x: 0, y: 0).neighbours(length: 3, height: 3),
            [
                Coordinate(x: 1, y: 0),
                Coordinate(x: 0, y: 1),
            ]
        )
        XCTAssertEqual(
            Coordinate(x: 1, y: 1).neighbours(length: 3, height: 3),
            [
                Coordinate(x: 1, y: 0),
                Coordinate(x: 1, y: 2),
                Coordinate(x: 0, y: 1),
                Coordinate(x: 2, y: 1),
            ]
        )
        XCTAssertEqual(
            Coordinate(x: 2, y: 2).neighbours(length: 3, height: 3),
            [
                Coordinate(x: 1, y: 2),
                Coordinate(x: 2, y: 1),
            ]
        )
    }

}
