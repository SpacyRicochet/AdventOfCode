import XCTest
@testable import AdventOfCode2021

final class Day5Part1Tests: XCTestCase {

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
        XCTAssertEqual(sut.countDangerousSpots(allowing: .orthogonals, from: input), 5)
    }
    
    func test_route_horizontal() {
        XCTAssertEqual(Route(origin: .init(x: 9, y: 7), destination: .init(x: 7, y: 7)).path(), [
            .init(x: 9, y: 7),
            .init(x: 8, y: 7),
            .init(x: 7, y: 7),
        ])
        
        XCTAssertEqual(Route(origin: .init(x: 7, y: 7), destination: .init(x: 9, y: 7)).path(), [
            .init(x: 7, y: 7),
            .init(x: 8, y: 7),
            .init(x: 9, y: 7),
        ])
    }
    
    func test_route_vertical() {
        XCTAssertEqual(Route(origin: .init(x: 1, y: 1), destination: .init(x: 1, y: 3)).path(), [
            .init(x: 1, y: 1),
            .init(x: 1, y: 2),
            .init(x: 1, y: 3),
        ])

        XCTAssertEqual(Route(origin: .init(x: 1, y: 3), destination: .init(x: 1, y: 1)).path(), [
            .init(x: 1, y: 3),
            .init(x: 1, y: 2),
            .init(x: 1, y: 1),
        ])
    }

}
