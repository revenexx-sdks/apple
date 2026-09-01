import Foundation

public enum MarketsVocabularySource: String, CustomStringConvertible {
    case schema = "schema"

    public var description: String {
        return rawValue
    }
}
