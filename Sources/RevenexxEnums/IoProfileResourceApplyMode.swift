import Foundation

public enum IoProfileResourceApplyMode: String, CustomStringConvertible {
    case upsert = "upsert"
    case fullSync = "full-sync"
    case append = "append"

    public var description: String {
        return rawValue
    }
}
