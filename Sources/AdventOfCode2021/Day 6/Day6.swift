import AppKit
public struct Day6 {
    public init() {}

    public func runPart1() throws -> Int {
        let input = try Input.fromFile("day6")
        return simulateLanternfishGrowth(days: 80, from: input)
    }
    
    public func runPart2() throws -> Int {
        let input = try Input.fromFile("day6")
        return simulateLanternfishGrowth(days: 256, from: input)
    }
}

extension Day6 {
    func simulateLanternfishGrowth(days: Int, from input: [String]) -> Int {
        var growthSimulator = input
            .flatMap { $0.components(separatedBy: .punctuationCharacters) }
            .filter { !$0.isEmpty }
            .compactMap { Int($0) }
            .countOccurences() // See Day5.swift for implementation.
            .createGrowthSimulator()
        growthSimulator.advance(until: days)
        
        return growthSimulator.population
    }
}

struct GrowthSimulator {
    var population: Int
    var timers: [Int: Int]
    var step: Int = 0
    let cycle: Int = 6
    let newCycleIncrease: Int = 2
    
    var newCycle: Int { cycle + newCycleIncrease}
    
    mutating func advance() {
        let newPopulation = timers[0] ?? 0
        population += newPopulation
        
        var newTimers = timers
        newTimers[newCycle] = timers[0] ?? 0
        (1...newCycle).forEach {
            newTimers[$0 - 1] = timers[$0] ?? 0
        }
        newTimers[cycle] = (newTimers[cycle] ?? 0) + newPopulation
        newTimers[newCycle] = newPopulation
        
        timers = newTimers
        step += 1
    }
    
    mutating func advance(until step: Int) {
        (0..<step).forEach { _ in
            advance()
        }
    }
}

extension GrowthSimulator: CustomStringConvertible {
    var description: String {
        """
        GrowthSimulator(
          step: \(step), cycle: \(cycle), newCycleIncrease: \(newCycleIncrease),
          population: \(population),
          timers: [\(timers.sortedDescription)]
        )
        """
    }
}

extension Dictionary where Key == Int, Value == Int {
    func createGrowthSimulator() -> GrowthSimulator {
        .init(population: values.reduce(0, +), timers: self)
    }
    
    var sortedDescription: String {
        keys
            .sorted()
            .map({ "\($0): \(self[$0]!)" })
            .joined(separator: ", ")
    }
}

