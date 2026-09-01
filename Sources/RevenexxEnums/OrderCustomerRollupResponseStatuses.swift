import Foundation

public enum OrderCustomerRollupResponseStatuses: String, CustomStringConvertible {
    case pending = "pending"
    case placed = "placed"
    case inFulfillment = "in_fulfillment"
    case completed = "completed"
    case cancelled = "cancelled"

    public var description: String {
        return rawValue
    }
}
