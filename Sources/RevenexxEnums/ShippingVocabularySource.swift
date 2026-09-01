import Foundation

public enum ShippingVocabularySource: String, CustomStringConvertible {
    case schema = "schema"
    case table = "table"

    public var description: String {
        return rawValue
    }
}
