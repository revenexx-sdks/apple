import Foundation

public enum ShippingRatePricingType: String, CustomStringConvertible {
    case fixed = "fixed"
    case free = "free"
    case matrix = "matrix"

    public var description: String {
        return rawValue
    }
}
