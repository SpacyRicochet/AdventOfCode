public struct Day9 {
    public init() {}

    public func runPart1() throws -> Int {
        let input = try Input.fromFile("day9")
            .filter({ !$0.isEmpty })
        return sumOfRiskLevels(from: input)
    }
    
    public func runPart2() throws -> Int {
        let input = try Input.fromFile("day9")
            .filter({ !$0.isEmpty })
        return productOfTopThreeBasins(from: input)
    }
}

extension Day9 {
    func sumOfRiskLevels(from input: [String]) -> Int {
        let matrix = input.createMatrix(from: input)
        
        var result = 0
        for y in 0..<matrix.height {
            for x in 0..<matrix.length {
                let coordinate = Coordinate(x: x, y: y)
                if matrix.coordinateIsLowestPoint(coordinate) {
                    result += 1 + matrix[coordinate]
                }
            }
        }
        return result
    }
    
    func productOfTopThreeBasins(from input: [String]) -> Int {
        let matrix = input.createMatrix(from: input)
        
        // Get lowest points to start from.
        var lowestPoints = Set<Coordinate>()
        for y in 0..<matrix.height {
            for x in 0..<matrix.length {
                let coordinate = Coordinate(x: x, y: y)
                if matrix.coordinateIsLowestPoint(coordinate) {
                    lowestPoints.insert(coordinate)
                }
            }
        }
        
        // From each lowest point, we're going to explore the basin.
        let basinPoints = lowestPoints
            .map({ matrix.mapBasin(from: $0) })
            .map({ $0.map({ matrix[$0] }).count })
            .sorted()
            .reversed()
        
        let topThree = basinPoints.dropLast(basinPoints.count - 3)
        let result = topThree.reduce(1, *)
        return result
    }
}

struct Matrix<Element> {
    let length: Int
    let height: Int
    var matrix: [[Element]]
}

extension Matrix where Element == Int {
    
    func coordinateIsLowestPoint(_ coordinate: Coordinate) -> Bool {
        let point = self[coordinate]
        for neighbour in coordinate.neighbours(length: length, height: height) {
            if self[neighbour] <= point { return false }
        }
        return true
    }
    
    func mapBasin(from coordinate: Coordinate) -> Set<Coordinate> {
        coordinate.neighbours(length: length, height: height)
            .filter({ self[$0] < 9 && self[$0] > self[coordinate] })
            .reduce(Set<Coordinate>()) { partialResult, neighbour in
                partialResult
                    .union([coordinate, neighbour]) // Add the current coordinate and the neighbour.
                    .union(mapBasin(from: neighbour)) // For each neighbour, we continue to map the basin.
            }
    }
    
}

private extension Array where Element == String {
    func createMatrix(from input: [String]) -> Matrix<Int> {
        guard !input.isEmpty,
              !input[0].isEmpty else { return .init(length: 0, height: 0, matrix: [[Int]]()) }
        let matrix = input.map({
            $0.map({
                Int(String($0)) ?? -1
            })
        })
        let length = input[0].count
        let height = input.count
        return .init(length: length, height: height, matrix: matrix)
    }
}

// See Day 5 for implementation.
extension Coordinate {
    /// Returns the orthogonal neighbours of the coordinate that have positive x or y values,
    /// that fall within the given length and height.
    func neighbours(length: Int, height: Int) -> Set<Coordinate> {
        precondition(x >= 0)
        precondition(y >= 0)
        
        var result = Set<Coordinate>()
        for nX in [x - 1, x + 1] {
            if nX < 0 || nX >= length { continue }
            result.insert(.init(x: nX, y: y))
        }
        for nY in [y - 1, y + 1] {
            if nY < 0 || nY >= height { continue }
            
            result.insert(.init(x: x, y: nY))
        }
        return result
    }
}

extension Matrix {
    subscript(index: Coordinate) -> Element {
        get {
            self.matrix[index.y][index.x]
        }
        set {
            self.matrix[index.y][index.x] = newValue
        }
    }
}
