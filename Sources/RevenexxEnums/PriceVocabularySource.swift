import Foundation

public enum PriceVocabularySource: String, CustomStringConvertible {
    case schema = "schema"

    public var description: String {
        return rawValue
    }
}
