import Foundation

public enum ShippingCarrierStatus: String, CustomStringConvertible {
    case active = "active"
    case paused = "paused"
    case retired = "retired"

    public var description: String {
        return rawValue
    }
}
