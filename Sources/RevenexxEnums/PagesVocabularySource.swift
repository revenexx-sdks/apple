import Foundation

public enum PagesVocabularySource: String, CustomStringConvertible {
    case schema = "schema"

    public var description: String {
        return rawValue
    }
}
