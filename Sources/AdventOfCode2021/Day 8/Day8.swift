public struct Day8 {
    public init() {}

    public func runPart1() throws -> Int {
        let input = try Input.fromFile("day8")
            .filter({ !$0.isEmpty })
        return countEasyDigits(from: input)
    }
    
    public func runPart2() throws -> Int {
        let input = try Input.fromFile("day8")
            .filter({ !$0.isEmpty })
        return sumOfOutputs(from: input)
    }
}

extension Day8 {
    func countEasyDigits(from input: [String]) -> Int {
        let digitSegments = Set([1, 4, 7, 8].map({ $0.numberOfSegments }))
        return input
            .map({ $0.components(separatedBy: "|").last ?? "" })
            .flatMap({ $0.components(separatedBy: " ") })
            .filter({ !$0.isEmpty })
            .map({ $0.count })
            .filter({ digitSegments.contains($0) })
            .count
    }
    
    func sumOfOutputs(from input: [String]) -> Int {
        let entries = codeAndOutputs(from: input)
        let result = entries.reduce(0) { partialResult, entry in
            let mapping = numbers(from: entry.code)
            let digits = entry.output.map({ mapping[$0] ?? "" }).joined()
            let output = Int(digits) ?? 0
            return partialResult + output
        }
        return result
    }
}

private extension Day8 {
    func codeAndOutputs(from input: [String]) -> [(code: [Set<String.Element>], output: [Set<String.Element>])] {
        input.map(codeAndOutput(from:))
    }
    
    func codeAndOutput(from input: String) -> (code: [Set<String.Element>], output: [Set<String.Element>]) {
        let codeAndOutput = input
            .components(separatedBy: " ")
            .map({ Set($0) })
            .split(separator: Set<String.Element>("|"))
        return (code: Array(codeAndOutput.first ?? .init()) as [Set<String.Element>],
                output: Array(codeAndOutput.last ?? .init()) as [Set<String.Element>])
    }
    
    func numbers(from digits: [Set<String.Element>]) -> [Set<String.Element>: String] {
        // The easy ones.
        let one   = digits.first { $0.count == 1.numberOfSegments } ?? .init()
        let four  = digits.first { $0.count == 4.numberOfSegments } ?? .init()
        let seven = digits.first { $0.count == 7.numberOfSegments } ?? .init()
        let eight = digits.first { $0.count == 8.numberOfSegments } ?? .init()
        
        // Then make groups of the others, based on their segments.
        let twoThreeFive = digits.filter { $0.count == 2.numberOfSegments }
        let zeroSixNine = digits.filter { $0.count == 0.numberOfSegments }

        // We know that 3 has the same segments as 1.
        let three = twoThreeFive.first { $0.isSuperset(of: one) } ?? .init()
        
        // Only 9 has the same segments in common as 3 AND 4 have.
        let threeFourCommon = three.intersection(four)
        let nine = zeroSixNine.first { $0.isSuperset(of: threeFourCommon) } ?? .init()
        
        // Only 6 has the same segments as 8 MINUS 7.
        let sevenEightDifference = eight.subtracting(seven)
        let six = zeroSixNine.first { $0.isSuperset(of: sevenEightDifference) } ?? .init()
        
        // Only 0 is left of zeroSixNine.
        let zero = zeroSixNine.first { $0 != six && $0 != nine } ?? .init()
        
        // 5 is a subset of 6.
        let five = twoThreeFive.first { $0.isSubset(of: six) } ?? .init()
        
        // 2 is the only one left.
        let two = twoThreeFive.first { $0 != three && $0 != five } ?? .init()
        
        return [
            zero:  "0",
            one:   "1",
            two:   "2",
            three: "3",
            four:  "4",
            five:  "5",
            six:   "6",
            seven: "7",
            eight: "8",
            nine:  "9",
        ]
    }
}

private extension Int {
    var numberOfSegments: Int {
        switch self {
            case 0: return 6
            case 1: return 2
            case 2: return 5
            case 3: return 5
            case 4: return 4
            case 5: return 5
            case 6: return 6
            case 7: return 3
            case 8: return 7
            case 9: return 6
                
            default: return 0
        }
    }
    
}
