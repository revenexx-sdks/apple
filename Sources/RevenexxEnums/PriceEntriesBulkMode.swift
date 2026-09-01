import Foundation

public enum PriceEntriesBulkMode: String, CustomStringConvertible {
    case upsert = "upsert"
    case append = "append"

    public var description: String {
        return rawValue
    }
}
