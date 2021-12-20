public struct Day7 {
    public init() {}

    public func runPart1() throws -> Int {
        let input = try Input.fromFile("day7")
        return fuelUsage(increasesPerStep: false, from: input)
    }
    
    public func runPart2() throws -> Int {
        let input = try Input.fromFile("day7")
        return fuelUsage(increasesPerStep: true, from: input)
    }
}

extension Day7 {
    func fuelUsage(increasesPerStep: Bool, from input: [String]) -> Int {
        input
            .flatMap { $0.components(separatedBy: .punctuationCharacters) }
            .filter { !$0.isEmpty }
            .compactMap { Int($0) }
            .countOccurences() // See Day5.swift for implementation.
            .minimumFuelUsage(increasesPerStep: increasesPerStep)
    }
}

private extension Dictionary where Key == Int, Value == Int {
    var minKey: Int {
        keys.min() ?? 0
    }
    
    var maxKey: Int {
        keys.max() ?? 0
    }
    
    func minimumFuelUsage(increasesPerStep: Bool) -> Int {
        func fuelUsage(to destination: Int) -> Int {
            keys.reduce(0) { (partial, origin) in
                let diff = abs(origin - destination)
                let fuelUsage = increasesPerStep ? ((diff + diff * diff) / 2) : diff
                let amount = self[origin] ?? 0
                let result = partial + fuelUsage * amount
                return result
            }
        }
        
        return (minKey...maxKey)
            .map { fuelUsage(to: $0) }
            .min() ?? 0
    }

    func minimumFuelUsageBruteForce(increasePerStep: Int) -> Int {
        func fuelUsage(to destination: Int, increasePerStep: Int) -> Int {
            keys.reduce(0) { (partial, origin) in
                let diff = abs(origin - destination)
                let fuelUsage = diff == 0 ? 0
                : (0..<diff).reduce(0) { partial, step in
                    partial + 1 + (step * increasePerStep)
                }
                let amount = self[origin] ?? 0
                let result = partial + amount * fuelUsage
                return result
            }
        }
        
        return (minKey...maxKey)
            .map { fuelUsage(to: $0, increasePerStep: increasePerStep) }
            .min() ?? 0
    }
    
}
