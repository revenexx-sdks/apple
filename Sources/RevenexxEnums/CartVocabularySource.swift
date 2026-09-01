import Foundation

public enum CartVocabularySource: String, CustomStringConvertible {
    case schema = "schema"

    public var description: String {
        return rawValue
    }
}
