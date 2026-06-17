import Foundation

public enum MarketStatus: String, CustomStringConvertible {
    case active = "active"
    case inactive = "inactive"

    public var description: String {
        return rawValue
    }
}
