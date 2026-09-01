import Foundation

public enum VocabularySource: String, CustomStringConvertible {
    case schema = "schema"
    case table = "table"
    case tenant = "tenant"
    case defaults = "defaults"

    public var description: String {
        return rawValue
    }
}
