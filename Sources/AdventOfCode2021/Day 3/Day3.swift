import Foundation

public struct Day3 {
    public init() {}

    public func runPart1() throws -> Int {
        let input = try Input.fromFile("day3")
        return powerConsumption(from: input)
    }
    
    public func runPart2() throws -> Int {
        let input = try Input.fromFile("day3")
        return lifeSupportRating(from: input)
    }
}

extension Day3 {
    func powerConsumption(from input: [String]) -> Int {
        let bitsArray = arrayOfBits(from: input)
        let mostBits = naiveMostCommonBits(from: bitsArray)
        
        let gamma = int(from: mostBits)
        let epsilon = int(from: arrayOfReversedBits(from: mostBits))
        
        return gamma * epsilon
    }
    
    func lifeSupportRating(from input: [String]) -> Int {
        let bitsArray = arrayOfBits(from: input)
        let oxygen = rating(onBit: 1, from: bitsArray)
        let carbon = rating(onBit: 0, from: bitsArray)
        return oxygen * carbon
    }
}

private extension Day3 {
    func rating(onBit bit: Int, from input: [[Int]]) -> Int {
        assert((0...1).contains(bit), "Invalid bit for binary work.")
        
        guard !input.isEmpty else { return 0 }
        let columnCount = input[0].count
        
        var currentColumn = 0
        var currentRows = Array(input.indices)
        var bitResult = [Int]()
        while currentColumn < columnCount && currentRows.count > 1 {
            let columnResult = mostCommonBit(bit, in: currentColumn, from: input, with: currentRows)
            currentColumn += 1
            currentRows = columnResult.rows
            bitResult += [columnResult.bit]
        }
        let finalRow = input[currentRows.first ?? 0]
        return int(from: finalRow)
    }
}

private extension Day3 {
    func arrayOfBits(from input: [String]) -> [[Int]] {
        let charArray = input.compactMap { string in string.isEmpty ? nil : Array(string) }
        let result = charArray.map { chars in chars.map({ c in c == Character("0") ? 0 : 1 }) }
        return result
    }
    
    func int(from input: [Int]) -> Int {
        guard let firstBit = input.first else { return 0 }
        var result = 0 + firstBit
        input.dropFirst().forEach { bit in
            result <<= 1
            result += bit
        }
        return result
    }
    
    func arrayOfReversedBits(from input: [Int]) -> [Int] {
        input.map { $0 == 0 ? 1 : 0 }
    }
    
    func naiveMostCommonBits(from input: [[Int]]) -> [Int] {
        guard let columnCount = input.first?.count else { fatalError("No rules about equal amounts…") }
        
        // A bit is the most common if it's in at least half of the input rows.
        let minimumCount = input.count / 2 + 1

        // Our result storage.
        var zeroCount = [Int](repeating: 0, count: columnCount)
        var mostCommon = [Int?](repeating: nil, count: columnCount)
        var columnIndices = IndexSet(mostCommon.indices)
        
        // We're going to loop over each row.
        for (rowIndex, bitRow) in input.enumerated() {
            // If we don't have to check any columns anymore, we're done.
            if columnIndices.isEmpty { break }
            
            // Make a copy of indices to iterate over, since we might change the original.
            let indices = columnIndices
            
            // For each column, we're going to count zeroes.
            indices.forEach { columnIndex in
                let bit = bitRow[columnIndex]

                switch bit {
                    // In case of zero, count it.
                    case 0: zeroCount[columnIndex] += 1
                    default: break
                }
                if zeroCount[columnIndex] == minimumCount {
                    // If we have enough zeroes, then we can stop checking this column.
                    mostCommon[columnIndex] = 0
                    columnIndices.remove(columnIndex)
                } else if rowIndex - zeroCount[columnIndex] == minimumCount - 1 {
                    // If we passed enough ones, then we can also stop checking.
                    mostCommon[columnIndex] = 1
                    columnIndices.remove(columnIndex)
                }
            }
        }
        // Prepare for the result.
        let result = mostCommon.compactMap({ $0 })
        assert(result.count == columnCount, "Result count \(result.count) different from columns \(columnCount).")
        return result
    }
    
    func mostCommonBit(_ preferredBit: Int, in columnIndex: Int, from input: [[Int]], with rows: [Int]) -> (bit: Int, rows: [Int]) {
        var zeroCount = 0
        var zeroRows = [Int]()
        var oneCount = 0
        var oneRows = [Int]()
        
        for rowIndex in rows {
            let bitRow = input[rowIndex]
            let bit = bitRow[columnIndex]
            if bit == 0 {
                zeroCount += 1
                zeroRows += [rowIndex]
            } else {
                oneCount += 1
                oneRows += [rowIndex]
            }
        }
        
        if preferredBit == 0 {
            if zeroCount <= oneCount {
                return (bit: 0, rows: zeroRows)
            } else {
                return (bit: 1, rows: oneRows)
            }
        } else {
            if oneCount >= zeroCount {
                return (bit: 1, rows: oneRows)
            } else {
                return (bit: 0, rows: zeroRows)
            }
        }
    }
}
