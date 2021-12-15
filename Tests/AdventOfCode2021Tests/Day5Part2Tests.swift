import XCTest
@testable import AdventOfCode2021

final class Day5Part2Tests: XCTestCase {

    func test_example() throws {
        let input = [
            "0,9 -> 5,9",
            "8,0 -> 0,8",
            "9,4 -> 3,4",
            "2,2 -> 2,1",
            "7,0 -> 7,4",
            "6,4 -> 2,0",
            "0,9 -> 2,9",
            "3,4 -> 1,4",
            "0,0 -> 8,8",
            "5,5 -> 8,2",
            "",
        ]
        let sut = Day5()
        XCTAssertEqual(sut.countDangerousSpots(allowing: .includeDiagonals, from: input), 12)
    }
    
    func test_route_diagonal() {
        XCTAssertEqual(Route(origin: .init(x: 1, y: 1), destination: .init(x: 3, y: 3)).path(allowing: .includeDiagonals), [
            .init(x: 1, y: 1),
            .init(x: 2, y: 2),
            .init(x: 3, y: 3),
        ])

        XCTAssertEqual(Route(origin: .init(x: 3, y: 3), destination: .init(x: 1, y: 1)).path(allowing: .includeDiagonals), [
            .init(x: 3, y: 3),
            .init(x: 2, y: 2),
            .init(x: 1, y: 1),
        ])
        
        XCTAssertEqual(Route(origin: .init(x: 8, y: 0), destination: .init(x: 0, y: 8)).path(allowing: .includeDiagonals), [
            .init(x: 8, y: 0),
            .init(x: 7, y: 1),
            .init(x: 6, y: 2),
            .init(x: 5, y: 3),
            .init(x: 4, y: 4),
            .init(x: 3, y: 5),
            .init(x: 2, y: 6),
            .init(x: 1, y: 7),
            .init(x: 0, y: 8),
        ])
        
    }
}
