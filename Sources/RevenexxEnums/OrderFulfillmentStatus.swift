import Foundation

public enum OrderFulfillmentStatus: String, CustomStringConvertible {
    case unfulfilled = "unfulfilled"
    case partial = "partial"
    case fulfilled = "fulfilled"

    public var description: String {
        return rawValue
    }
}
