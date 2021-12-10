import Foundation

enum Input {
    static func fromFile(_ filename: String, extension: String = "txt") throws -> [String] {
        guard let inputUrl = Bundle.module.url(forResource: filename, withExtension: `extension`) else { throw AdventError.missingInput }
        let inputString = try String(contentsOf: inputUrl)
        let result = inputString
            .components(separatedBy: CharacterSet.newlines)
        return result
    }
}
