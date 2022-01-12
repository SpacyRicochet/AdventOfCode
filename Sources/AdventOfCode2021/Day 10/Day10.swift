public struct Day10 {
    public init() {}

    public func runPart1() throws -> Int {
        let input = try Input.fromFile("day10")
            .filter({ !$0.isEmpty })
        return syntaxErrorScore(from: input)
    }
    
    public func runPart2() throws -> Int {
        let input = try Input.fromFile("day10")
        return autoCorrectScore(from: input)
    }
}

extension Day10 {
    
    func syntaxErrorScore(from input: [String]) -> Int {
        input.reduce(0) { partialResult, line in
            do {
               try validateLine(input: line)
            } catch ValidationError.illegalCharacter(let character) {
                return partialResult + character.illegalScore
            } catch {} // `missingInput(_)` not counted.
            return partialResult
        }
    }
    
    func autoCorrectScore(from input: [String]) -> Int {
        var scores: [Int] = input.map { line in
            do {
               try validateLine(input: line)
            } catch ValidationError.missingInput(let characters) {
                let chars = characters
                    .reversed()
                    .map { $0.pairedCharacter }
                return chars
                    .map { $0.missingInputScore }
                    .reduce(0) { $0 * 5 + $1 }
            } catch {} // `illegalCharacter(_)` not counted.
            return 0
        }
        scores = scores.filter { $0 > 0 }.sorted()
        return scores[scores.count / 2]
    }
    
}

private let characterPairs: [Character: Character] = [
    "(": ")",
    "[": "]",
    "{": "}",
    "<": ">",
]

private extension Character {
    
    var isOpeningCharacter: Bool {
        characterPairs.keys.contains(self)
    }
    
    var pairedCharacter: Character {
        characterPairs[self] ?? " "
    }
    
    var illegalScore: Int {
        switch self {
            case ")": return 3
            case "]": return 57
            case "}": return 1197
            case ">": return 25137
            default:  return 0
        }
    }

    var missingInputScore: Int {
        switch self {
            case ")": return 1
            case "]": return 2
            case "}": return 3
            case ">": return 4
            default:  return 0
        }
    }
    
}

private extension Day10 {
    
    private enum ValidationError: Error {
        case illegalCharacter(Character)
        case missingInput([Character])
    }
    
    func validateLine(input: String) throws {
        var openingCharacters: [Character] = []
        
        for nextCharacter in input {
            if nextCharacter.isOpeningCharacter {
                openingCharacters.append(nextCharacter)
            } else if openingCharacters.removeLast().pairedCharacter != nextCharacter {
                throw ValidationError.illegalCharacter(nextCharacter)
            }
        }
        
        guard openingCharacters.isEmpty else {
            throw ValidationError.missingInput(openingCharacters)
        }
    }
    
}
