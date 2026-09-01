import Foundation

public enum ShippingCarriersListStatus: String, CustomStringConvertible {
    case active = "active"
    case paused = "paused"
    case retired = "retired"

    public var description: String {
        return rawValue
    }
}
