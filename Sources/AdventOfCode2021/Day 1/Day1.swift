import Foundation

public struct Day1 {
    public init() {}

    public func runPart1() throws -> Int {
        let input = try Input.fromFile("day1")
        return numberOfIncreases(from: input)
    }
    
    public func runPart2() throws -> Int {
        let input = try Input.fromFile("day1")
        return numberOfWindowedIncreases(size: 3, from: input)
    }
}

extension Day1 {
    func numberOfIncreases(from input: [String]) -> Int {
        input
            .compactMap({ Int($0) })
            .numberOfIncreases()
    }
    
    func numberOfWindowedIncreases(size: Int, from input: [String]) -> Int {
        input
            .compactMap({ Int($0) })
            .numberOfWindowedIncreases(size: size)
    }
}

private extension Day1 {
    func inputFromFile() throws -> [String] {
        guard let inputUrl = Bundle.module.url(forResource: "day1", withExtension: "txt") else { throw AdventError.missingInput }
        let inputString = try String(contentsOf: inputUrl)
        let input = inputString
            .components(separatedBy: CharacterSet.newlines)
        return input
    }
}


private extension Collection where Index == Int, Element: SignedInteger {
    func numberOfIncreases() -> Int {
        guard count > 1 else { return 0 }
        return zip(dropLast(), dropFirst())
            .filter({ $0 < $1 })
            .count
    }
    
    func numberOfWindowedIncreases(size: Int) -> Int {
        // 0. If the input is not large enough, we're done.
        guard count > size else { return 0 }
        // 1. Get the entire range.
        return (startIndex..<endIndex)
        // 2. Map the range to a sequence of "windows".
            .dropLast(size - 1)
            .map { index in index..<index + size}
        // 3. Map the windows to a sequence of sums…
            .map { range in
                // … by reducing the input values to a total.
                range.reduce(0) { (sum, index) in sum + self[index] }
            }
        // 4. Then count the number of increases.
            .numberOfIncreases()
    }
}
