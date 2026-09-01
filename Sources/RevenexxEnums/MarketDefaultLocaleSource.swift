import Foundation

public enum MarketDefaultLocaleSource: String, CustomStringConvertible {
    case market = "market"
    case marketFirst = "market_first"
    case tenantFallback = "tenant_fallback"

    public var description: String {
        return rawValue
    }
}
