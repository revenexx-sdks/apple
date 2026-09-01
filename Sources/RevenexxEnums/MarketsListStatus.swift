import Foundation

public enum MarketsListStatus: String, CustomStringConvertible {
    case active = "active"
    case inactive = "inactive"

    public var description: String {
        return rawValue
    }
}
