import Foundation

public enum FormStatus: String, CustomStringConvertible {
    case draft = "draft"
    case live = "live"
    case archived = "archived"

    public var description: String {
        return rawValue
    }
}
