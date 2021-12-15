import XCTest

class MainTests: XCTestCase {
    let executableName = "advent2021"
    
    func testUnknownSubCommand() throws {
        XCTAssertEqual(try runAdventCommand(arguments: []), "No subcommand given\n")
        XCTAssertEqual(try runAdventCommand(arguments: ["foobar"]), "Unrecognized subcommand 'foobar'\n")
        XCTAssertEqual(try runAdventCommand(arguments: ["foo", "bar"]), "Unrecognized subcommand 'foo bar'\n")
    }
    
    func test2021Day1() throws {
        XCTAssertEqual(try runAdventCommand(arguments: ["day1", "part1"]), "1228\n")
        XCTAssertEqual(try runAdventCommand(arguments: ["day1", "part2"]), "1257\n")
    }
    
    func test2021Day2() throws {
        XCTAssertEqual(try runAdventCommand(arguments: ["day2", "part1"]), "1484118\n")
        XCTAssertEqual(try runAdventCommand(arguments: ["day2", "part2"]), "1463827010\n")
    }

    func test2021Day3() throws {
        XCTAssertEqual(try runAdventCommand(arguments: ["day3", "part1"]), "3958484\n")
        XCTAssertEqual(try runAdventCommand(arguments: ["day3", "part2"]), "1613181\n")
    }

    func test2021Day4() throws {
        XCTAssertEqual(try runAdventCommand(arguments: ["day4", "part1"]), "54275\n")
        XCTAssertEqual(try runAdventCommand(arguments: ["day4", "part2"]), "13158\n")
    }

    func test2021Day5() throws {
        XCTAssertEqual(try runAdventCommand(arguments: ["day5", "part1"]), "6666\n")
        XCTAssertEqual(try runAdventCommand(arguments: ["day5", "part2"]), "19081\n")
    }
}

// - MARK: Helpers
extension MainTests {
    private func runAdventCommand(arguments: [String]? = nil) throws -> String? {
        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            throw XCTSkip("This test case requires macOS 10.13 or higher")
        }
        
        let fooBinary = productsDirectory.appendingPathComponent(executableName)
        
        let process = Process()
        process.executableURL = fooBinary
        process.arguments = arguments
        
        let pipe = Pipe()
        process.standardOutput = pipe
        
        try process.run()
        process.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        
        return output
    }
    
    /// Returns path to the built products directory.
    private var productsDirectory: URL {
#if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
#else
        return Bundle.main.bundleURL
#endif
    }
}
