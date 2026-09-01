import Foundation

public enum OrderVocabularySource: String, CustomStringConvertible {
    case schema = "schema"
    case app = "app"

    public var description: String {
        return rawValue
    }
}
