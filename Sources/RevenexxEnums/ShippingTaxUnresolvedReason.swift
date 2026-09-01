import Foundation

public enum ShippingTaxUnresolvedReason: String, CustomStringConvertible {
    case marketRequired = "market_required"
    case noMarkets = "no_markets"
    case noTaxClasses = "no_tax_classes"
    case lookupFailed = "lookup_failed"

    public var description: String {
        return rawValue
    }
}
