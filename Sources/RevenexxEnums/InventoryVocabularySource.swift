import Foundation

public enum InventoryVocabularySource: String, CustomStringConvertible {
    case schema = "schema"

    public var description: String {
        return rawValue
    }
}
