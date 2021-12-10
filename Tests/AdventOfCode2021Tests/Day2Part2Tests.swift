import XCTest
@testable import AdventOfCode2021

final class Day2Part2Tests: XCTestCase {

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
        XCTAssertEqual(sut.locationMultiplied(from: input), 900)
    }
    
    func test_locationMultiplied_zeroInput() throws {
        let input = [String]()
        let sut = Day2()
        XCTAssertEqual(sut.locationMultiplied(from: input), 0)
    }
    
    func test_locationMultiplied_oneInput() throws {
        let input = [
            "forward 5",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.locationMultiplied(from: input), 0)
    }
    
    func test_locationMultiplied_onlyForwards() throws {
        let input = [
            "forward 5",
            "forward 2",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.locationMultiplied(from: input), 0)
    }
    
    func test_locationMultiplied_onlyUps() throws {
        let input = [
            "up 5",
            "up 2",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.locationMultiplied(from: input), 0)
    }

    
    func test_locationMultiplied_onlyDowns() throws {
        let input = [
            "down 5",
            "down 2",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.locationMultiplied(from: input), 0)
    }
    
    
    func test_locationMultiplied_onlyUpsAndDowns() throws {
        let input = [
            "up 5",
            "down 2",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.locationMultiplied(from: input), 0)
    }

    func test_locationMultiplied_forwardOnlyAtFirst() throws {
        let input = [
            "forward 1",
            "up 10",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.locationMultiplied(from: input), 0)
    }

    func test_locationMultiplied_UpAndForward() throws {
        let input = [
            "up 10",
            "forward 1",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.locationMultiplied(from: input), -10)
    }

    func test_locationMultiplied_downAndForward() throws {
        let input = [
            "down 10",
            "forward 1",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.locationMultiplied(from: input), 10)
    }

    func test_locationMultiplied_UpAndDownAndForward() throws {
        let input = [
            "up 10",
            "down 20",
            "forward 1",
        ]
        let sut = Day2()
        XCTAssertEqual(sut.locationMultiplied(from: input), 10)
    }

    func test_locationMultiplied_moreForward() throws {
        let input = [
            "up 10",     // aim -10
            "forward 1", // position 1, depth -10
            "down 20",   // aim 10
            "forward 2", // position 3, depth 10
        ]
        let sut = Day2()
        XCTAssertEqual(sut.locationMultiplied(from: input), 30)
    }
}
