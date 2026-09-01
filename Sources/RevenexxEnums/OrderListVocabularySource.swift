import Foundation

public enum OrderListVocabularySource: String, CustomStringConvertible {
    case schema = "schema"
    case table = "table"

    public var description: String {
        return rawValue
    }
}
