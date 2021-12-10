public struct Day4 {
    public init() {}

    public func runPart1() throws -> Int {
        let input = try Input.fromFile("day4")
        return firstPlaceBingoScore(from: input)
    }
    
    public func runPart2() throws -> Int {
        let input = try Input.fromFile("day4")
        return lastPlaceBingoScore(from: input)
    }
}

extension Day4 {
    func firstPlaceBingoScore(from input: [String]) -> Int {
        var game = BingoGame(from: input)
        game.playGameUntilFirstWinner()
        return game.firstPlaceScore
    }
    
    func lastPlaceBingoScore(from input: [String]) -> Int {
        var game = BingoGame(from: input)
        game.playGameUntilEnd()
        return game.lastPlaceScore
    }
}

// MARK: - BingoGame

struct BingoGame {
    enum State {
        case ongoing
        case finished(winner: BingoBoard?, score: Int)
    }
    var draws: [Int]
    var boards: [BingoBoard]
    var state: State
    var turn: Int
    var finishedBoards: [BingoBoard]
}

extension BingoGame {
    init(from input: [String]) {
        let splitInput = input.split(separator: "")
        let draws = splitInput.first?.first?.components(separatedBy: ",").map({ Int($0) ?? -1 }) ?? []
        let boards = splitInput
            .dropFirst() // We already have the draws.
            .enumerated()
            .map { (index, stringArray) -> BingoBoard in
                let rowCount = stringArray.count
                let board = stringArray
                    .flatMap { string in
                        string
                            .components(separatedBy: .whitespaces)
                            .filter { !$0.isEmpty }
                            .map { Int($0) ?? -1 }
                    }
                return BingoBoard(id: index, numbers: board, lastNumber: nil, rowCount: rowCount)
            }
        
        self.init(draws: draws, boards: boards, state: .ongoing, turn: 0, finishedBoards: [])
    }
    
    mutating func nextStep() {
        guard !draws.isEmpty else {
            self.state = .finished(winner: nil, score: 0)
            return
        }
        
        guard !boards.isEmpty else {
            return
        }
        
        let nextNumber = draws.removeFirst()
        turn += 1
        var finishedThisRound = [BingoBoard]()
        boards.indices.forEach {
            var board = boards[$0]
            board.draw(number: nextNumber)
            if board.isFinished {
                if case .ongoing = state {
                    // WE HAVE A WINNER!    
                    state = .finished(winner: board, score: board.score)
                }
                finishedThisRound.append(board)
            }
            boards[$0] = board
        }
        finishedThisRound.forEach { finished in
            if let index = boards.firstIndex(where: { $0.id == finished.id }) {
                boards.remove(at: index)
            }
            finishedBoards.append(contentsOf: finishedThisRound)
        }
    }
    
    mutating func playGameUntilFirstWinner() {
        while case .ongoing = state {
            nextStep()
        }
    }
    
    mutating func playGameUntilEnd() {
        while !boards.isEmpty && !draws.isEmpty {
            nextStep()
        }
    }
    
    var firstPlaceScore: Int {
        guard case .finished(_, let score) = state else { return 0 }
        return score
    }
    
    var lastPlaceScore: Int {
        guard let score = finishedBoards.last?.score else { return 0 }
        return score
    }
}

extension BingoGame: CustomStringConvertible {
    var description: String {
        """
        -----------
        Boards:
        
        \(boards.map({ String(describing: $0) }).joined(separator: "\n\n"))
        
        Finished boards:
        
        \(finishedBoards.map({ String(describing: $0) }).joined(separator: "\n\n"))

        State:  \(state)
        Turn:   \(turn)
        Draws:  \(draws)
        ___________
        """
    }
}

extension BingoGame.State: CustomStringConvertible {
    var description: String {
        switch self {
            case .ongoing: return "ongoing"
            case .finished(let winner, let score):
                if let winner = winner {
                    return "Finished; Board \(winner.id) won with \(score) points!"
                } else {
                    return "Finished; no winner."
                }
        }
    }
}

// MARK: - BingoBoard

struct BingoBoard: Identifiable {
    var id: Int
    var numbers: [Int]
    var lastNumber: Int?
    private let rowCount: Int
    
    init(id: Int, numbers: [Int], lastNumber: Int?, rowCount: Int) {
        self.id = id
        self.numbers = numbers
        self.lastNumber = lastNumber
        self.rowCount = rowCount
    }
}

extension BingoBoard {
    var columnCount: Int {
        numbers.count / rowCount
    }
    
    var isFinished: Bool {
        lastNumber != nil
    }
    
    mutating func draw(number: Int) {
        guard let index = numbers.firstIndex(of: number) else { return }
        numbers[index] = -1
        if completedOneRowOrColumn {
            lastNumber = number
        }
    }
    
    var score: Int {
        boardSum * (lastNumber ?? 0)
    }
}

extension BingoBoard: CustomStringConvertible {
    var description: String {
        rowDescription
    }
    
    var rowDescription: String {
        "Board \(id):\n"
        + numbers
            .map({ String("\($0 == -1 ? " ⍟" : String($0))").padding(toLength: 2, withPad: " ", startingAt: 0) })
            .chunked(into: columnCount)
            .map({ $0.joined(separator: " ") })
            .joined(separator: "\n")
    }
    
    var columnDescription: String {
        "Board \(id):\n"
        + numbers
            .indices
            .map({ columnMajorIndex(for: $0) })
            .map({ String("\(numbers[$0] == -1 ? " ⍟" : String(numbers[$0]))").padding(toLength: 2, withPad: " ", startingAt: 0) })
            .chunked(into: columnCount)
            .map({ $0.joined(separator: " ") })
            .joined(separator: "\n")
    }
}

private extension BingoBoard {
    func columnMajorIndex(for index: Int) -> Int {
        let x = index % columnCount
        let y = index / columnCount
        return x * columnCount + y
    }
    
    private var boardSum: Int {
        numbers.filter({ $0 > 0 }).reduce(0, +)
    }
    
    private var completedOneRowOrColumn: Bool {
        let indices = numbers.indices.chunked(into: columnCount)
        for indexArray in indices {
            if indexArray
                .map({ numbers[$0] })
                .contains(where: { $0 != -1 })
            && indexArray
                .map({ columnMajorIndex(for: $0) })
                .map({ numbers[$0] })
                .contains(where: { $0 != -1 })
            {
                continue
            } else {
                return true
            }
        }
        return false
    }
}

private extension Collection where Index == Int {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

