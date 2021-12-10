import Foundation

public struct Day2 {
    public init() {}

    public func runPart1() throws -> Int {
        let input = try Input.fromFile("day2")
        return naiveLocationMultiplied(from: input)
    }
    
    public func runPart2() throws -> Int {
        let input = try Input.fromFile("day2")
        return locationMultiplied(from: input)
    }
}

extension Day2 {
    func naiveLocationMultiplied(from input: [String]) -> Int {
        let location = input
            .compactMap { CourseDirection(input: $0) }
            .reduce(CourseLocation(0, 0)) { $0.naiveAdjust(by: $1) }
        return location.position * location.depth
    }

    func locationMultiplied(from input: [String]) -> Int {
        let location = input
            .compactMap { CourseDirection(input: $0) }
            .reduce(CourseLocation(0, 0)) { $0.adjust(by: $1) }
        return location.position * location.depth
    }
}

// MARK: - CourseLocation

struct CourseLocation {
    let position: Int
    let depth: Int
    let aim: Int
    
    init(_ position: Int, _ depth: Int, _ aim: Int = 0) {
        self.position = position
        self.depth = depth
        self.aim = aim
    }
}

extension CourseLocation {
    func naiveAdjust(by direction: CourseDirection) -> CourseLocation {
        switch direction.heading {
            case .forward: return .init(position + direction.distance, depth, aim)
            case .up:      return .init(position, depth - direction.distance, aim)
            case .down:    return .init(position, depth + direction.distance, aim)
        }
    }

    func adjust(by direction: CourseDirection) -> CourseLocation {
        switch direction.heading {
            case .forward: return .init(position + direction.distance, depth + (aim * direction.distance), aim)
            case .up:      return .init(position, depth, aim - direction.distance)
            case .down:    return .init(position, depth, aim + direction.distance)
        }
    }
}

// MARK: - CourseDirection

struct CourseDirection {
    enum Heading: String {
        case forward
        case up
        case down
    }
    
    let heading: Heading
    let distance: Int
}

extension CourseDirection {
    init?(input: String) {
        let parts = input.components(separatedBy: .whitespaces)
        guard parts.count == 2,
              let heading = CourseDirection.Heading(rawValue: parts[0]),
              let distance = Int(parts[1])
        else { return nil }
        
        self = .init(heading: heading, distance: distance)
    }
}

