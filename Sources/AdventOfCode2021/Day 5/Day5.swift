import AppKit
public struct Day5 {
    public init() {}

    public func runPart1() throws -> Int {
        let input = try Input.fromFile("day5")
        return countDangerousSpots(allowing: .orthogonals, from: input)
    }
    
    public func runPart2() throws -> Int {
        let input = try Input.fromFile("day5")
        return countDangerousSpots(allowing: .includeDiagonals, from: input)
    }
}

extension Day5 {
    func countDangerousSpots(allowing orientations: Route.Orientation, from input: [String]) -> Int {
        input
            .compactMap(Route.init(string:))
            .flatMap({ $0.path(allowing: orientations) })
            .countOccurences()
            .filter({ $0.value > 1 })
            .count
    }
}

struct Coordinate: Equatable, Hashable {
    let x: Int
    let y: Int
}

extension Coordinate: CustomStringConvertible {
    var description: String { "(\(x), \(y))" }
}

extension Coordinate {
    init?(string: String) {
        let numbers = string
            .components(separatedBy: ",")
            .compactMap({ Int($0) })
        guard numbers.count == 2 else { return nil }
        self.init(x: numbers[0], y: numbers[1])
    }
}

struct Route {
    struct Orientation: OptionSet {
        let rawValue: Int
        static let horizontal = Orientation(rawValue: 1 << 0)
        static let vertical   = Orientation(rawValue: 1 << 1)
        static let diagonal   = Orientation(rawValue: 1 << 2)

        static let orthogonals: Orientation = [.horizontal, .vertical]
        static let includeDiagonals: Orientation = [.horizontal, .vertical, .diagonal]
    }

    let origin: Coordinate
    let destination: Coordinate
    
    func path(allowing orientations: Orientation = [.horizontal, .vertical]) -> [Coordinate] {
        guard origin != destination else { return [origin] }
        // Since stride doesn't start on the coordinates, we have to determine whether
        // it's a horizontal, vertical or diagonal route.
        if orientations.contains(.vertical), origin.x == destination.x {
            // Vertical route.
            let stride = stride(from: origin.y, to: destination.y, by: origin.y <= destination.y ? 1 : -1)
            return stride.map { Coordinate(x: origin.x, y: $0) } + [destination]
            
        } else if orientations.contains(.horizontal), origin.y == destination.y {
            // Horizontal route.
            let stride = stride(from: origin.x, to: destination.x, by: origin.x <= destination.x ? 1 : -1)
            return stride.map { Coordinate(x: $0, y: origin.y) } + [destination]
            
        } else if orientations.contains(.diagonal), abs(origin.x - destination.x) == abs(origin.y - destination.y) {
            // Diagonal route.
            let xStride = stride(from: origin.x, to: destination.x, by: origin.x <= destination.x ? 1 : -1)
            let yStride = stride(from: origin.y, to: destination.y, by: origin.y <= destination.y ? 1 : -1)
            return zip(xStride, yStride).map { Coordinate(x: $0, y: $1) } + [destination]
        } else {
            // Unspecified route
            return []
        }
    }

}

extension Route {
    init?(string: String) {
        let coordinates = string
            .components(separatedBy: " -> ")
            .compactMap({ Coordinate(string: $0) })
        guard coordinates.count == 2 else { return nil }
        self.init(origin: coordinates[0], destination: coordinates[1])
    }
}

extension Array where Element: Hashable {
    func countOccurences() -> [Element: Int] {
        var result = [Element: Int]()
        forEach { result[$0, default: 0] += 1 }
        return result
    }
}

extension Dictionary where Key == Coordinate, Value == Int {
    func prettyPrint() -> Self {
        let xMax = keys.map({ $0.x }).reduce(0) { Swift.max($0, $1) }
        let yMax = keys.map({ $0.y }).reduce(0) { Swift.max($0, $1) }
        
        var string = ""
        for y in 0...yMax {
            for x in 0...xMax {
                let count = self[.init(x: x, y: y)] ?? 0
                string += "\(count)".padding(toLength: 3, withPad: " ", startingAt: 0)
            }
            string += "\n"
        }
        print(string)
        return self
    }
}
