import Foundation

public enum ShippingTrackingCarrierStatus: String, CustomStringConvertible {
    case active = "active"
    case paused = "paused"
    case retired = "retired"

    public var description: String {
        return rawValue
    }
}
