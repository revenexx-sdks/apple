import Foundation

public enum PriceListStatus: String, CustomStringConvertible {
    case active = "active"
    case inactive = "inactive"

    public var description: String {
        return rawValue
    }
}
