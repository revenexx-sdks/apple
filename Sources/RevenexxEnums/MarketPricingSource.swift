import Foundation

public enum MarketPricingSource: String, CustomStringConvertible {
    case market = "market"
    case tenant = "tenant"
    case unset = "unset"

    public var description: String {
        return rawValue
    }
}
