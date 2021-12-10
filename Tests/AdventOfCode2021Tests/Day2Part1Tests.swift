import XCTest
@testable import AdventOfCode2021

final class Day2Part1Tests: XCTestCase {

    func test_example() throws {
        let input = [
            "forward 5",
            "down 5",
            "forward 8",
            "up 3",
            "down 8",
            "forward 2",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.naiveLocationMultiplied(from: input), 150)
    }
    
    func test_locationMultiplied_zeroInput() throws {
        let input = [String]()
        let sut = Day2()
        XCTAssertEqual(sut.naiveLocationMultiplied(from: input), 0)
    }
    
    func test_locationMultiplied_oneInput() throws {
        let input = [
            "forward 5",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.naiveLocationMultiplied(from: input), 0)
    }
    
    func test_locationMultiplied_onlyForwards() throws {
        let input = [
            "forward 5",
            "forward 2",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.naiveLocationMultiplied(from: input), 0)
    }
    
    func test_locationMultiplied_onlyUps() throws {
        let input = [
            "up 5",
            "up 2",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.naiveLocationMultiplied(from: input), 0)
    }

    
    func test_locationMultiplied_onlyDowns() throws {
        let input = [
            "down 5",
            "down 2",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.naiveLocationMultiplied(from: input), 0)
    }
    
    
    func test_locationMultiplied_onlyUpsAndDowns() throws {
        let input = [
            "up 5",
            "down 2",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.naiveLocationMultiplied(from: input), 0)
    }

    func test_locationMultiplied_forwardAndUp() throws {
        let input = [
            "forward 1",
            "up 10",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.naiveLocationMultiplied(from: input), -10)
    }

    func test_locationMultiplied_forwardAndDown() throws {
        let input = [
            "forward 1",
            "down 10",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.naiveLocationMultiplied(from: input), 10)
    }

    func test_locationMultiplied_forwardAndUpAndDown() throws {
        let input = [
            "forward 1",
            "up 10",
            "down 20",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.naiveLocationMultiplied(from: input), 10)
    }

    func test_locationMultiplied_moreForward() throws {
        let input = [
            "forward 1",
            "up 10",
            "down 20",
            "forward 2",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.naiveLocationMultiplied(from: input), 30)
    }
}
