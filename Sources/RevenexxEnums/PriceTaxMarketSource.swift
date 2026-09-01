import Foundation

public enum PriceTaxMarketSource: String, CustomStringConvertible {
    case request = "request"
    case header = "header"
    case soleMarket = "sole_market"

    public var description: String {
        return rawValue
    }
}
