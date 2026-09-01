import Foundation

public enum PriceCurrencySource: String, CustomStringConvertible {
    case request = "request"
    case market = "market"
    case tenant = "tenant"
    case fallback = "fallback"

    public var description: String {
        return rawValue
    }
}
