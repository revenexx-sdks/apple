import Foundation

public enum ShippingTaxMarketSource: String, CustomStringConvertible {
    case request = "request"
    case header = "header"
    case country = "country"
    case soleMarket = "sole_market"

    public var description: String {
        return rawValue
    }
}
